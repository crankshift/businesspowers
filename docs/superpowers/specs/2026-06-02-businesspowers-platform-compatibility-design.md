# Businesspowers Platform Compatibility Design

Date: 2026-06-02

## Goal

Refactor `businesspowers` to match the platform compatibility model already used by `lawpowers`: one canonical source tree for plugin behavior, generated adapters for Claude Code and Codex, and a root OpenCode package plugin for git-package installation.

The target platforms are:

- Claude Code plugin marketplace and local plugin directories.
- Codex plugin marketplace and generated custom-agent shims.
- OpenCode package plugin installation via root `package.json` and `.opencode/plugins/businesspowers.js`.

## Current State

`businesspowers` already supports Claude Code and Codex:

- Claude marketplace: `.claude-plugin/marketplace.json`.
- Codex marketplace: `.agents/plugins/marketplace.json`.
- Plugin manifests: `plugins/*/.claude-plugin/plugin.json` and `plugins/*/.codex-plugin/plugin.json`.
- Generated Codex agent files: `plugins/*/.codex/agents/*.toml`.

The current source of truth is plugin-local:

- `plugins/ua/agents`, `plugins/ua/skills`.
- `plugins/pl/agents`, `plugins/pl/skills`.

This differs from `lawpowers`, where canonical files live at root under `agents/<jurisdiction>` and `skills/<jurisdiction>`, and plugin-local folders are generated adapters.

## Decision

Use exact `lawpowers` parity rather than a hybrid compatibility layer.

Canonical Businesspowers agent and skill names will be collision-safe and prefixed everywhere:

- Ukrainian sources: `business-ua-*`.
- Polish sources: `business-pl-*`.

This means the generated Claude plugin files will also use the prefixed names. The public Claude namespace still comes from plugin IDs `ua` and `pl`, but the command names inside those namespaces will reflect the new canonical names.

## Alternatives Considered

1. Adapter-only OpenCode loader.

This would add OpenCode support with less churn, but plugin-local files would remain canonical. It would not match `lawpowers` and would leave two repositories with different maintenance models.

2. Hybrid names.

OpenCode and Codex would use collision-safe names while Claude files kept unprefixed legacy names. This preserves current Claude-visible names, but creates naming translation rules and weakens validation.

3. Full parity.

Root canonical files use prefixed names, generated adapters mirror those names, and validation enforces the model. This creates more file churn but gives one consistent source-of-truth pattern across `lawpowers` and `businesspowers`.

The chosen approach is full parity.

## Architecture

Add root canonical source folders:

- `agents/ua/*.md`
- `agents/pl/*.md`
- `skills/ua/*/SKILL.md`
- `skills/pl/*/SKILL.md`

Keep plugin metadata in `plugins/*`:

- `README.md`
- `CLAUDE.md`
- `AGENTS.md`
- `CHANGELOG.md`
- `.claude-plugin/plugin.json`
- `.codex-plugin/plugin.json`

Treat these folders as generated adapters:

- `plugins/*/agents`
- `plugins/*/skills`
- `plugins/*/.codex/agents`

Add OpenCode package support:

- Root `package.json` with `type: "module"` and `main: ".opencode/plugins/businesspowers.js"`.
- `.opencode/plugins/businesspowers.js` that anchors to the installed package root, exposes root skill paths, parses Markdown agent frontmatter, and registers agents with OpenCode.

## Name And Reference Rules

Canonical files must be prefixed:

- `agents/ua/business-ua-fop-tax-calculator.md`
- `skills/ua/business-ua-calculating-edynyi-podatok/SKILL.md`
- `agents/pl/business-pl-jdg-tax-calculator.md`
- `skills/pl/business-pl-calculating-ryczalt/SKILL.md`

Frontmatter `name` must match the canonical filename or folder name.

Same-jurisdiction references inside canonical content should use prefixed names. Examples:

- `business-ua-tax-system-advisor`
- `business-ua-calculating-edynyi-podatok`
- `business-pl-tax-form-advisor`
- `business-pl-calculating-ryczalt`

Generated adapter validation must reject stale same-jurisdiction references such as `ua:fop-tax-calculator`, `tax-system-advisor`, or `calculating-ryczalt` when they should be prefixed.

## Generators

Add `scripts/generate-claude-plugin-files.py` adapted from `lawpowers`.

Responsibilities:

- Mirror `skills/<jurisdiction>` into `plugins/<jurisdiction>/skills`.
- Generate `plugins/<jurisdiction>/agents` from `agents/<jurisdiction>`.
- Rewrite canonical root skill links into plugin-relative skill links for Claude plugin copies.

Update `scripts/convert-agents-to-codex.py` to read from root `agents/<jurisdiction>` rather than plugin-local `plugins/<jurisdiction>/agents`.

Responsibilities:

- Prefix Codex names with the Codex plugin ID when needed.
- Preserve Claude `tools` metadata as prompt guidance.
- Add Codex migration notes that point back to canonical root agents.
- Rewrite same-jurisdiction references to prefixed names.

Keep `scripts/validate-codex-agents.py`, but align it with canonical root sources and generated Codex output.

Add `scripts/validate-platform-adapters.py` adapted from `lawpowers`.

Responsibilities:

- Validate canonical prefix discipline.
- Validate Claude adapter copies match transformed canonical sources.
- Validate generated Codex agent names and source references.
- Validate OpenCode package metadata and package plugin entrypoint.
- Reject obsolete OpenCode config shapes that would conflict with package-plugin installation.

## Documentation Updates

Update root docs:

- `README.md` should say the repository supports Claude Code, Codex, and OpenCode.
- `README.md` should describe canonical `agents/` and `skills/` root source folders.
- `README.md` should include OpenCode installation instructions.
- `CLAUDE.md` and `AGENTS.md` should describe root canonical sources, generated adapters, and verification commands.

Update plugin docs where public surfaces change:

- `plugins/ua/README.md`, `CLAUDE.md`, and `AGENTS.md`.
- `plugins/pl/README.md`, `CLAUDE.md`, and `AGENTS.md`.

Do not change tax content or rates as part of this structural refactor unless a generated reference requires a name update.

## Verification

After implementation, run:

```bash
python3 scripts/generate-claude-plugin-files.py
python3 scripts/convert-agents-to-codex.py
python3 scripts/validate-codex-agents.py
python3 scripts/validate-platform-adapters.py
python3 -m json.tool package.json
python3 -m json.tool .agents/plugins/marketplace.json
python3 -m json.tool .claude-plugin/marketplace.json
python3 -m json.tool plugins/ua/.codex-plugin/plugin.json
python3 -m json.tool plugins/pl/.codex-plugin/plugin.json
python3 -m json.tool plugins/ua/.claude-plugin/plugin.json
python3 -m json.tool plugins/pl/.claude-plugin/plugin.json
```

Expected result:

- Root canonical source files exist and are prefixed.
- Generated Claude and Codex adapters are fresh.
- OpenCode package metadata points to `.opencode/plugins/businesspowers.js`.
- JSON manifests parse successfully.
- No stale same-jurisdiction unprefixed references remain in generated adapter text.

## Scope Boundaries

In scope:

- Structural parity with `lawpowers`.
- Naming canonicalization.
- Generator and validator updates.
- Documentation updates for Claude Code, Codex, and OpenCode compatibility.

Out of scope:

- Changing tax logic, rates, thresholds, or filing guidance.
- Adding new agents or skills.
- Changing site content except if a later implementation plan finds a direct name-surface mismatch that must be reflected publicly.
- Publishing releases or tags.
