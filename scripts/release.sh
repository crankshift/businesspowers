#!/usr/bin/env bash
#
# Release helper for the businesspowers monorepo.
#
# Usage:
#   ./scripts/release.sh bump <version>
#       Update the unified repository version in package.json,
#       Claude marketplace metadata, plugin-level Claude/Codex manifests,
#       and the OpenCode validator expectation.
#
#   ./scripts/release.sh prepare <version>
#       From a clean main: create branch release-v<version>, run bump,
#       wait for you to edit CHANGELOG.md, commit, push, and open a PR.
#
#   ./scripts/release.sh publish <version>
#       After the PR merges: pull main, tag the merge commit as v<version>,
#       and publish a GitHub Release with body extracted from CHANGELOG.md.
#
# Requirements: bash, git, gh (authenticated), jq, awk, python3.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MARKETPLACE_JSON="$REPO_ROOT/.claude-plugin/marketplace.json"
CHANGELOG="$REPO_ROOT/CHANGELOG.md"

CLAUDE_PLUGIN_MANIFESTS=(
  "$REPO_ROOT/plugins/ua/.claude-plugin/plugin.json"
  "$REPO_ROOT/plugins/pl/.claude-plugin/plugin.json"
)
CODEX_PLUGIN_MANIFESTS=(
  "$REPO_ROOT/plugins/ua/.codex-plugin/plugin.json"
  "$REPO_ROOT/plugins/pl/.codex-plugin/plugin.json"
)

die() { printf 'error: %s\n' "$*" >&2; exit 1; }
info() { printf '==> %s\n' "$*"; }

require_tool() {
  command -v "$1" >/dev/null 2>&1 || die "required tool not found: $1"
}

check_tools() {
  for tool in git gh jq awk python3; do
    require_tool "$tool"
  done
  gh auth status >/dev/null 2>&1 || die "gh not authenticated; run 'gh auth login'"
}

set_json_field() {
  local file="$1" path="$2" value="$3"
  [[ -f "$file" ]] || die "file not found: $file"
  local tmp
  tmp=$(mktemp)
  jq --indent 2 "$path = \"$value\"" "$file" >"$tmp"
  mv "$tmp" "$file"
}

set_validator_version() {
  local version="$1"
  local file="$REPO_ROOT/scripts/validate-platform-adapters.py"
  [[ -f "$file" ]] || die "file not found: $file"

  python3 - "$file" "$version" <<'PY'
from __future__ import annotations

import sys
from pathlib import Path

path = Path(sys.argv[1])
version = sys.argv[2]
text = path.read_text(encoding="utf-8")
old = '    "version": "'
start = text.find(old)
if start == -1:
    raise SystemExit("expected package version field not found")
start += len(old)
end = text.find('"', start)
if end == -1:
    raise SystemExit("unterminated package version field")
path.write_text(text[:start] + version + text[end:], encoding="utf-8")
PY
}

extract_section() {
  local file="$1" version="$2"
  awk -v v="$version" '
    $0 ~ "^## \\[" v "\\]" { inside=1; print; next }
    inside && /^## \[/ { exit }
    inside && /^\[[^]]+\]:[[:space:]]+https?:\/\// { next }
    inside { print }
    END { if (!inside) exit 1 }
  ' "$file"
}

require_changelog_entry() {
  local version="$1"
  grep -q "^## \[$version\]" "$CHANGELOG" || die "no [$version] section found in CHANGELOG.md"
  grep -q "^\[$version\]:" "$CHANGELOG" || die "no [$version]: link reference found in CHANGELOG.md"
}

cmd_bump() {
  local version="${1:?usage: bump <version>}"

  info "package.json -> $version"
  set_json_field "$REPO_ROOT/package.json" '.version' "$version"

  info "Claude marketplace -> $version"
  set_json_field "$MARKETPLACE_JSON" '.metadata.version' "$version"
  set_json_field "$MARKETPLACE_JSON" '.plugins[].version' "$version"

  for manifest in "${CLAUDE_PLUGIN_MANIFESTS[@]}" "${CODEX_PLUGIN_MANIFESTS[@]}"; do
    info "${manifest#"$REPO_ROOT/"} -> $version"
    set_json_field "$manifest" '.version' "$version"
  done

  info "OpenCode validator expectation -> $version"
  set_validator_version "$version"

  info "validating JSON manifests..."
  python3 -m json.tool "$REPO_ROOT/package.json" >/dev/null
  python3 -m json.tool "$MARKETPLACE_JSON" >/dev/null
  for manifest in "${CLAUDE_PLUGIN_MANIFESTS[@]}" "${CODEX_PLUGIN_MANIFESTS[@]}"; do
    python3 -m json.tool "$manifest" >/dev/null
  done
}

cmd_prepare() {
  local version="${1:?usage: prepare <version>}"

  cd "$REPO_ROOT"

  if ! git diff --quiet || ! git diff --cached --quiet; then
    die "working tree not clean; commit or stash first"
  fi

  info "switching to main and pulling..."
  git checkout main
  git pull --ff-only origin main

  local branch="release-v$version"
  if git rev-parse --verify "$branch" >/dev/null 2>&1; then
    die "branch $branch already exists locally"
  fi
  git checkout -b "$branch"

  cmd_bump "$version"

  cat <<MSG

Now edit the root CHANGELOG:

  - $CHANGELOG

Add a [$version] section at the top, plus the link reference at the bottom
pointing to https://github.com/crankshift/businesspowers/releases/tag/v$version

Press Enter when done.
MSG
  read -r _

  require_changelog_entry "$version"

  info "committing..."
  git add -A
  git commit -m "release v$version"
  git push -u origin "$branch"

  info "opening PR..."
  local body
  body=$(extract_section "$CHANGELOG" "$version")
  gh pr create --base main --head "$branch" \
    --title "v$version" \
    --body "$body"

  cat <<MSG

PR opened. Merge it on GitHub, then run:

  ./scripts/release.sh publish $version

MSG
}

cmd_publish() {
  local version="${1:?usage: publish <version>}"

  cd "$REPO_ROOT"

  info "switching to main and pulling..."
  git checkout main
  git pull --ff-only origin main

  require_changelog_entry "$version"

  local merge_sha tag
  merge_sha=$(git rev-parse HEAD)
  tag="v$version"

  if git rev-parse --verify "$tag" >/dev/null 2>&1; then
    die "tag $tag already exists"
  fi

  info "tagging $tag on $merge_sha..."
  git tag -a "$tag" "$merge_sha" -m "businesspowers v$version"
  git push origin "$tag"

  info "publishing GitHub release..."
  local body
  body=$(extract_section "$CHANGELOG" "$version")
  printf '%s\n' "$body" | gh release create "$tag" \
    --title "businesspowers v$version" \
    --notes-file -

  local url
  url=$(gh release view "$tag" --json url --jq .url)
  info "published: $url"
}

main() {
  check_tools
  local cmd="${1:-}"
  shift || true

  case "$cmd" in
    bump) cmd_bump "$@" ;;
    prepare) cmd_prepare "$@" ;;
    publish) cmd_publish "$@" ;;
    -h|--help|help|"")
      sed -n '2,/^$/p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
      ;;
    *)
      die "unknown command: $cmd (try --help)"
      ;;
  esac
}

main "$@"
