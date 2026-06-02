# Businesspowers Platform Compatibility Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Refactor `businesspowers` to match `lawpowers` platform compatibility: root canonical sources, generated Claude/Codex adapters, and OpenCode package plugin support.

**Architecture:** Root `agents/<jurisdiction>` and `skills/<jurisdiction>` become the canonical source tree with `business-ua-*` and `business-pl-*` names. Plugin-local `plugins/*/agents`, `plugins/*/skills`, and `plugins/*/.codex/agents` become generated adapters. OpenCode loads canonical root skills and agents through `.opencode/plugins/businesspowers.js`.

**Tech Stack:** Python 3 generator/validator scripts, Markdown agent/skill files with YAML frontmatter, JSON plugin manifests, JavaScript ESM OpenCode package plugin.

---

## File Structure

**Create:**

- `package.json`: OpenCode package metadata pointing to `.opencode/plugins/businesspowers.js`.
- `.opencode/plugins/businesspowers.js`: root-anchored OpenCode plugin that registers canonical skills and agents.
- `agents/ua/*.md`: canonical Ukrainian agent prompts, renamed to `business-ua-*`.
- `agents/pl/*.md`: canonical Polish agent prompts, renamed to `business-pl-*`.
- `skills/ua/*/SKILL.md`: canonical Ukrainian skills, renamed to `business-ua-*`.
- `skills/pl/*/SKILL.md`: canonical Polish skills, renamed to `business-pl-*`.
- `scripts/generate-claude-plugin-files.py`: mirrors canonical sources into Claude plugin adapter folders.
- `scripts/validate-platform-adapters.py`: validates canonical sources, generated adapters, and OpenCode package metadata.

**Modify:**

- `scripts/convert-agents-to-codex.py`: read canonical root agents and generate Codex shims from them.
- `scripts/validate-codex-agents.py`: validate Codex shims against root canonical agents.
- `plugins/ua/agents/*.md`: generated adapter copy; files become `business-ua-*.md`.
- `plugins/pl/agents/*.md`: generated adapter copy; files become `business-pl-*.md`.
- `plugins/ua/skills/*/SKILL.md`: generated adapter copy; folders become `business-ua-*`.
- `plugins/pl/skills/*/SKILL.md`: generated adapter copy; folders become `business-pl-*`.
- `plugins/ua/.codex/agents/*.toml`: regenerated Codex shims from root UA agents.
- `plugins/pl/.codex/agents/*.toml`: regenerated Codex shims from root PL agents.
- `README.md`: add canonical source layout and OpenCode install instructions.
- `CLAUDE.md`: describe root canonical sources, generated adapters, OpenCode support, and verification commands.
- `AGENTS.md`: mirror Codex/OpenCode contributor guidance.
- `plugins/ua/README.md`, `plugins/ua/CLAUDE.md`, `plugins/ua/AGENTS.md`: update public names and maintenance notes.
- `plugins/pl/README.md`, `plugins/pl/CLAUDE.md`, `plugins/pl/AGENTS.md`: update public names and maintenance notes.

**Do Not Modify:**

- `site/`: site changes are out of scope unless verification later exposes a direct breakage.
- Tax formulas, rates, thresholds, filing rules, or source citations except automatic name/reference prefixing.

---

### Task 1: Add The Platform Validator As The First Failing Check

**Files:**

- Create: `scripts/validate-platform-adapters.py`

- [ ] **Step 1: Add `scripts/validate-platform-adapters.py`**

Use `apply_patch` to create `scripts/validate-platform-adapters.py` with this exact content:

```python
#!/usr/bin/env python3
"""Validate generated businesspowers platform adapter files."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
JURISDICTIONS = ("pl", "ua")
FRONTMATTER_RE = re.compile(r"\A---\n(.*?)\n---\n?(.*)\Z", re.S)
EXPECTED_PACKAGE_JSON = {
    "name": "businesspowers",
    "version": "0.1.0",
    "type": "module",
    "main": ".opencode/plugins/businesspowers.js",
}


def fail(message: str) -> None:
    print(f"error: {message}", file=sys.stderr)
    raise SystemExit(1)


def rel(path: Path) -> str:
    return str(path.relative_to(ROOT))


def read(path: Path) -> str:
    if not path.is_file():
        fail(f"missing required file: {rel(path)}")
    return path.read_text(encoding="utf-8")


def parse_frontmatter(text: str, path: Path) -> tuple[dict[str, str], str]:
    match = FRONTMATTER_RE.match(text)
    if not match:
        fail(f"{rel(path)} is missing YAML frontmatter")
    raw, body = match.groups()
    values: dict[str, str] = {}
    for line in raw.splitlines():
        if not line.strip() or line.startswith(" "):
            continue
        key, sep, value = line.partition(":")
        if not sep:
            fail(f"{rel(path)} has unparsable frontmatter line: {line!r}")
        values[key.strip()] = value.strip().strip('"')
    return values, body


def plugin_codex_name(jurisdiction: str) -> str:
    manifest = ROOT / "plugins" / jurisdiction / ".codex-plugin" / "plugin.json"
    return json.loads(read(manifest))["name"]


def prefixed_name(jurisdiction: str, name: str) -> str:
    plugin_name = plugin_codex_name(jurisdiction)
    return name if name.startswith(f"{plugin_name}-") else f"{plugin_name}-{name}"


def source_agent_paths(jurisdiction: str) -> list[Path]:
    source_dir = ROOT / "agents" / jurisdiction
    if not source_dir.is_dir():
        fail(f"missing canonical agent directory: {rel(source_dir)}")
    return sorted(source_dir.glob("*.md"))


def source_skill_dirs(jurisdiction: str) -> list[Path]:
    source_dir = ROOT / "skills" / jurisdiction
    if not source_dir.is_dir():
        fail(f"missing canonical skill directory: {rel(source_dir)}")
    return sorted(path for path in source_dir.iterdir() if (path / "SKILL.md").is_file())


def canonical_names(jurisdiction: str) -> set[str]:
    return {path.stem for path in source_agent_paths(jurisdiction)} | {path.name for path in source_skill_dirs(jurisdiction)}


def unprefixed_canonical_names(jurisdiction: str) -> set[str]:
    plugin_name = plugin_codex_name(jurisdiction)
    names: set[str] = set()
    for name in canonical_names(jurisdiction):
        if name.startswith(f"{plugin_name}-"):
            names.add(name.removeprefix(f"{plugin_name}-"))
    return names


def rewrite_plugin_agent_skill_links(text: str, jurisdiction: str) -> str:
    return re.sub(
        rf"\.\./\.\./skills/{re.escape(jurisdiction)}/([A-Za-z0-9_-]+)/SKILL\.md",
        r"../skills/\1/SKILL.md",
        text,
    )


def require_prefixed_canonical_sources(jurisdiction: str) -> None:
    plugin_name = plugin_codex_name(jurisdiction)
    for source in source_agent_paths(jurisdiction):
        if not source.stem.startswith(f"{plugin_name}-"):
            fail(f"canonical agent is not prefixed: {rel(source)}")
        metadata, _ = parse_frontmatter(read(source), source)
        if metadata.get("name") != source.stem:
            fail(f"{rel(source)} name is {metadata.get('name')!r}; expected {source.stem!r}")
    for source_dir in source_skill_dirs(jurisdiction):
        if not source_dir.name.startswith(f"{plugin_name}-"):
            fail(f"canonical skill directory is not prefixed: {rel(source_dir)}")
        source = source_dir / "SKILL.md"
        metadata, _ = parse_frontmatter(read(source), source)
        if metadata.get("name") != source_dir.name:
            fail(f"{rel(source)} name is {metadata.get('name')!r}; expected {source_dir.name!r}")


def require_no_bare_same_jurisdiction_names(text: str, generated: Path, jurisdiction: str, plugin_name: str) -> None:
    text = re.sub(rf"lawpowers:{re.escape(jurisdiction)}:[A-Za-z0-9_-]+", "", text)
    stale_reference = re.search(rf"(?<!lawpowers:)\b{re.escape(jurisdiction)}:[A-Za-z0-9_-]+", text)
    if stale_reference:
        fail(f"{rel(generated)} contains stale same-jurisdiction reference {stale_reference.group(0)!r}")
    for name in sorted(unprefixed_canonical_names(jurisdiction)):
        pattern = re.compile(rf"(?<![A-Za-z0-9_-])(?<!{re.escape(plugin_name)}-){re.escape(name)}(?![A-Za-z0-9_-])")
        if pattern.search(text):
            fail(f"{rel(generated)} contains unprefixed same-jurisdiction canonical name {name!r}")


def parse_generated_toml(path: Path) -> dict[str, str]:
    data: dict[str, str] = {}
    for line in read(path).splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        key, sep, raw_value = line.partition("=")
        if not sep:
            fail(f"{rel(path)} has unparsable line: {line!r}")
        try:
            data[key.strip()] = json.loads(raw_value.strip())
        except json.JSONDecodeError as exc:
            fail(f"{rel(path)} has invalid string value for `{key.strip()}`: {exc}")
    return data


def codex_source_body(body: str) -> str:
    return body.split("\n\n## Codex migration notes", 1)[0]


def require_exact_file_set(directory: Path, expected_names: set[str], pattern: str) -> None:
    if not directory.is_dir():
        fail(f"missing generated directory: {rel(directory)}")
    actual_names = {path.name for path in directory.glob(pattern)}
    missing = sorted(expected_names - actual_names)
    extra = sorted(actual_names - expected_names)
    if missing:
        fail(f"{rel(directory)} is missing generated files: {', '.join(missing)}")
    if extra:
        fail(f"{rel(directory)} has stale generated files: {', '.join(extra)}")


def require_exact_dir_set(directory: Path, expected_names: set[str]) -> None:
    if not directory.is_dir():
        fail(f"missing generated directory: {rel(directory)}")
    actual_names = {path.name for path in directory.iterdir() if path.is_dir()}
    missing = sorted(expected_names - actual_names)
    extra = sorted(actual_names - expected_names)
    if missing:
        fail(f"{rel(directory)} is missing generated directories: {', '.join(missing)}")
    if extra:
        fail(f"{rel(directory)} has stale generated directories: {', '.join(extra)}")


def validate_claude_copies(jurisdiction: str) -> tuple[int, int]:
    agent_sources = source_agent_paths(jurisdiction)
    skill_sources = source_skill_dirs(jurisdiction)
    plugin_dir = ROOT / "plugins" / jurisdiction
    plugin_name = plugin_codex_name(jurisdiction)

    require_exact_file_set(plugin_dir / "agents", {path.name for path in agent_sources}, "*.md")
    for source in agent_sources:
        generated = plugin_dir / "agents" / source.name
        expected = rewrite_plugin_agent_skill_links(read(source), jurisdiction)
        generated_text = read(generated)
        if generated_text != expected:
            fail(f"{rel(generated)} does not match transformed canonical source {rel(source)}")
        require_no_bare_same_jurisdiction_names(generated_text, generated, jurisdiction, plugin_name)

    require_exact_dir_set(plugin_dir / "skills", {path.name for path in skill_sources})
    for source_dir in skill_sources:
        source = source_dir / "SKILL.md"
        generated = plugin_dir / "skills" / source_dir.name / "SKILL.md"
        generated_text = read(generated)
        if generated_text != read(source):
            fail(f"{rel(generated)} does not match canonical source {rel(source)}")
        require_no_bare_same_jurisdiction_names(generated_text, generated, jurisdiction, plugin_name)

    return len(agent_sources), len(skill_sources)


def validate_codex_agents(jurisdiction: str, seen_names: set[str]) -> int:
    plugin_name = plugin_codex_name(jurisdiction)
    sources = source_agent_paths(jurisdiction)
    output_dir = ROOT / "plugins" / jurisdiction / ".codex" / "agents"
    expected_names = {f"{prefixed_name(jurisdiction, source.stem)}.toml" for source in sources}
    require_exact_file_set(output_dir, expected_names, "*.toml")

    for source in sources:
        expected_name = prefixed_name(jurisdiction, source.stem)
        generated = output_dir / f"{expected_name}.toml"
        text = read(generated)
        if f'name = "{expected_name}"' not in text:
            fail(f"{rel(generated)} does not declare expected name {expected_name!r}")
        if f"Source canonical agent: `agents/{jurisdiction}/{source.name}`." not in text:
            fail(f"{rel(generated)} does not reference canonical source {rel(source)}")
        data = parse_generated_toml(generated)
        require_no_bare_same_jurisdiction_names(data.get("description", ""), generated, jurisdiction, plugin_name)
        require_no_bare_same_jurisdiction_names(
            codex_source_body(data.get("developer_instructions", "")),
            generated,
            jurisdiction,
            plugin_name,
        )
        if expected_name in seen_names:
            fail(f"duplicate generated Codex agent name: {expected_name}")
        seen_names.add(expected_name)
    return len(sources)


def validate_opencode_package() -> None:
    package_path = ROOT / "package.json"
    if json.loads(read(package_path)) != EXPECTED_PACKAGE_JSON:
        fail(f"{rel(package_path)} does not match expected OpenCode package metadata")
    plugin_path = ROOT / ".opencode" / "plugins" / "businesspowers.js"
    plugin_text = read(plugin_path)
    for needle in (
        "export default async function businesspowers",
        "fileURLToPath(import.meta.url)",
        'join(ROOT, "skills", jurisdiction)',
        'join(ROOT, "agents", jurisdiction)',
        "config(cfg)",
    ):
        if needle not in plugin_text:
            fail(f"{rel(plugin_path)} is missing root-anchored OpenCode loader text: {needle!r}")
    for obsolete in (
        ROOT / "opencode.json",
        ROOT / ".opencode" / "agents",
        ROOT / ".opencode" / "skills",
        ROOT / ".opencode" / "package.json",
        ROOT / ".opencode" / "package-lock.json",
        ROOT / ".opencode" / "node_modules",
    ):
        if obsolete.exists():
            fail(f"{rel(obsolete)} must not exist for package-plugin OpenCode install")


def validate_canonical_text(jurisdiction: str) -> None:
    plugin_name = plugin_codex_name(jurisdiction)
    for path in source_agent_paths(jurisdiction) + [d / "SKILL.md" for d in source_skill_dirs(jurisdiction)]:
        text = read(path)
        require_no_bare_same_jurisdiction_names(text, path, jurisdiction, plugin_name)


def main() -> None:
    claude_agents = 0
    claude_skills = 0
    codex_names: set[str] = set()
    codex_agents = 0

    for jurisdiction in JURISDICTIONS:
        require_prefixed_canonical_sources(jurisdiction)
        validate_canonical_text(jurisdiction)
        agents, skills = validate_claude_copies(jurisdiction)
        claude_agents += agents
        claude_skills += skills
        codex_agents += validate_codex_agents(jurisdiction, codex_names)

    validate_opencode_package()

    if claude_agents != codex_agents:
        fail(f"agent count mismatch: claude={claude_agents}, codex={codex_agents}")

    print(f"Validated platform adapters: {claude_agents} agents, {claude_skills} skills.")


if __name__ == "__main__":
    main()
```

- [ ] **Step 2: Run the validator and confirm it fails on the missing canonical tree**

Run:

```bash
python3 scripts/validate-platform-adapters.py
```

Expected: FAIL with an error that starts with `error: missing canonical agent directory: agents/pl`.

Do not commit yet. The failing validator proves the compatibility gap.

---

### Task 2: Add OpenCode Package Metadata And Canonical Root Sources

**Files:**

- Create: `package.json`
- Create: `.opencode/plugins/businesspowers.js`
- Create: `agents/ua/*.md`
- Create: `agents/pl/*.md`
- Create: `skills/ua/*/SKILL.md`
- Create: `skills/pl/*/SKILL.md`

- [ ] **Step 1: Add `package.json`**

Use `apply_patch` to add `package.json`:

```json
{
  "name": "businesspowers",
  "version": "0.1.0",
  "type": "module",
  "main": ".opencode/plugins/businesspowers.js"
}
```

- [ ] **Step 2: Add the OpenCode package plugin**

Use `apply_patch` to add `.opencode/plugins/businesspowers.js`:

```javascript
import { readdirSync, readFileSync } from "node:fs"
import { dirname, join, resolve } from "node:path"
import { fileURLToPath } from "node:url"

const ROOT = resolve(dirname(fileURLToPath(import.meta.url)), "../..")
const JURISDICTIONS = ["pl", "ua"]
const FRONTMATTER_RE = /^---\n([\s\S]*?)\n---\n?([\s\S]*)$/

function parseFrontmatter(markdown) {
  const match = markdown.match(FRONTMATTER_RE)
  if (!match) return { metadata: {}, body: markdown }

  const metadata = {}
  for (const line of match[1].split("\n")) {
    if (!line.trim() || line.startsWith(" ")) continue
    const separator = line.indexOf(":")
    if (separator === -1) continue
    const key = line.slice(0, separator).trim()
    const value = line.slice(separator + 1).trim().replace(/^["']|["']$/g, "")
    metadata[key] = value
  }

  return { metadata, body: match[2] }
}

function loadAgents() {
  const agents = {}
  for (const jurisdiction of JURISDICTIONS) {
    const directory = join(ROOT, "agents", jurisdiction)
    for (const entry of readdirSync(directory, { withFileTypes: true })) {
      if (!entry.isFile() || !entry.name.endsWith(".md")) continue
      const file = join(directory, entry.name)
      const { metadata, body } = parseFrontmatter(readFileSync(file, "utf8"))
      const name = metadata.name || entry.name.replace(/\.md$/, "")
      agents[name] = {
        description: metadata.description,
        mode: "subagent",
        prompt: body.trim(),
      }
    }
  }
  return agents
}

function skillPaths() {
  return JURISDICTIONS.map((jurisdiction) => join(ROOT, "skills", jurisdiction))
}

export default async function businesspowers() {
  return {
    config(cfg) {
      cfg.skills = {
        ...(cfg.skills || {}),
        paths: [...new Set([...(cfg.skills?.paths || []), ...skillPaths()])],
      }
      cfg.agent = { ...(cfg.agent || {}), ...loadAgents() }
    },
  }
}
```

- [ ] **Step 3: Bootstrap canonical root agents and skills from plugin-local sources**

Run this bulk migration script from the repository root. It copies plugin-local sources into root canonical folders, prefixes filenames/folders, prefixes frontmatter names, rewrites same-jurisdiction references, and rewrites plugin-local skill links to root canonical skill links.

```bash
python3 - <<'PY'
from pathlib import Path
import re
import shutil

ROOT = Path.cwd()
CONFIG = {
    "ua": "business-ua",
    "pl": "business-pl",
}


def prefixed(prefix: str, name: str) -> str:
    return name if name.startswith(f"{prefix}-") else f"{prefix}-{name}"


def collect_old_names(jurisdiction: str) -> set[str]:
    plugin = ROOT / "plugins" / jurisdiction
    names = {path.stem for path in (plugin / "agents").glob("*.md")}
    names.update(path.name for path in (plugin / "skills").iterdir() if (path / "SKILL.md").is_file())
    return names


OLD_NAMES = {jurisdiction: collect_old_names(jurisdiction) for jurisdiction in CONFIG}


def rewrite_text(text: str, jurisdiction: str) -> str:
    prefix = CONFIG[jurisdiction]
    text = re.sub(
        rf"\.\./skills/(?!{re.escape(prefix)}-)([A-Za-z0-9_-]+)/SKILL\.md",
        rf"../../skills/{jurisdiction}/{prefix}-\1/SKILL.md",
        text,
    )
    text = re.sub(
        rf"\.\./skills/({re.escape(prefix)}-[A-Za-z0-9_-]+)/SKILL\.md",
        rf"../../skills/{jurisdiction}/\1/SKILL.md",
        text,
    )
    text = re.sub(rf"\b{re.escape(jurisdiction)}:(?!{re.escape(prefix)}-)([A-Za-z0-9_-]+)", rf"{prefix}-\1", text)
    for name in sorted(OLD_NAMES[jurisdiction], key=len, reverse=True):
        text = re.sub(
            rf"(?<![A-Za-z0-9_-])(?<!{re.escape(prefix)}-){re.escape(name)}(?![A-Za-z0-9_-])",
            f"{prefix}-{name}",
            text,
        )
    return text


def rewrite_frontmatter_name(text: str, new_name: str) -> str:
    return re.sub(r"(?m)^name:\s*.*$", f"name: {new_name}", text, count=1)


for jurisdiction, prefix in CONFIG.items():
    source_agents = ROOT / "plugins" / jurisdiction / "agents"
    target_agents = ROOT / "agents" / jurisdiction
    target_agents.mkdir(parents=True, exist_ok=True)
    for stale in target_agents.glob("*.md"):
        stale.unlink()
    for source in sorted(source_agents.glob("*.md")):
        new_name = prefixed(prefix, source.stem)
        text = source.read_text(encoding="utf-8")
        text = rewrite_frontmatter_name(text, new_name)
        text = rewrite_text(text, jurisdiction)
        (target_agents / f"{new_name}.md").write_text(text, encoding="utf-8")

    source_skills = ROOT / "plugins" / jurisdiction / "skills"
    target_skills = ROOT / "skills" / jurisdiction
    if target_skills.exists():
        shutil.rmtree(target_skills)
    target_skills.mkdir(parents=True, exist_ok=True)
    for source_dir in sorted(path for path in source_skills.iterdir() if (path / "SKILL.md").is_file()):
        new_name = prefixed(prefix, source_dir.name)
        target_dir = target_skills / new_name
        shutil.copytree(source_dir, target_dir)
        skill_file = target_dir / "SKILL.md"
        text = skill_file.read_text(encoding="utf-8")
        text = rewrite_frontmatter_name(text, new_name)
        text = rewrite_text(text, jurisdiction)
        skill_file.write_text(text, encoding="utf-8")

print("Created canonical sources:")
for jurisdiction in CONFIG:
    agent_count = len(list((ROOT / "agents" / jurisdiction).glob("*.md")))
    skill_count = len([path for path in (ROOT / "skills" / jurisdiction).iterdir() if (path / "SKILL.md").is_file()])
    print(f"{jurisdiction}: {agent_count} agents, {skill_count} skills")
PY
```

Expected output:

```text
Created canonical sources:
ua: 9 agents, 20 skills
pl: 11 agents, 22 skills
```

- [ ] **Step 4: Run the validator again and confirm the next failure has advanced**

Run:

```bash
python3 scripts/validate-platform-adapters.py
```

Expected: FAIL with a generated-adapter mismatch, such as `plugins/pl/agents is missing generated files` or `plugins/pl/agents has stale generated files`. This proves canonical sources and OpenCode metadata now exist, while generated adapters still need regeneration.

Do not commit yet.

---

### Task 3: Add Claude Adapter Generation

**Files:**

- Create: `scripts/generate-claude-plugin-files.py`

- [ ] **Step 1: Add `scripts/generate-claude-plugin-files.py`**

Use `apply_patch` to create `scripts/generate-claude-plugin-files.py`:

```python
#!/usr/bin/env python3
"""Generate Claude-compatible plugin files from canonical sources."""

from __future__ import annotations

import re
import shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
JURISDICTIONS = ("pl", "ua")


def fail(message: str) -> None:
    raise SystemExit(f"error: {message}")


def mirror_tree(source: Path, destination: Path) -> None:
    if not source.is_dir():
        fail(f"missing source directory: {source.relative_to(ROOT)}")
    if destination.exists():
        shutil.rmtree(destination)
    shutil.copytree(source, destination)


def rewrite_agent_skill_links(text: str, jurisdiction: str) -> str:
    return re.sub(
        rf"\.\./\.\./skills/{re.escape(jurisdiction)}/([A-Za-z0-9_-]+)/SKILL\.md",
        r"../skills/\1/SKILL.md",
        text,
    )


def generate_agents(source: Path, destination: Path, jurisdiction: str) -> int:
    if not source.is_dir():
        fail(f"missing source directory: {source.relative_to(ROOT)}")
    if destination.exists():
        shutil.rmtree(destination)
    destination.mkdir(parents=True, exist_ok=True)
    count = 0
    for agent in sorted(source.glob("*.md")):
        text = rewrite_agent_skill_links(agent.read_text(encoding="utf-8"), jurisdiction)
        (destination / agent.name).write_text(text, encoding="utf-8")
        count += 1
    return count


def generate_jurisdiction(jurisdiction: str) -> tuple[int, int]:
    plugin_dir = ROOT / "plugins" / jurisdiction
    if not plugin_dir.is_dir():
        fail(f"missing plugin directory: {plugin_dir.relative_to(ROOT)}")

    source_agents = ROOT / "agents" / jurisdiction
    source_skills = ROOT / "skills" / jurisdiction
    agents = generate_agents(source_agents, plugin_dir / "agents", jurisdiction)
    mirror_tree(source_skills, plugin_dir / "skills")
    return agents, len([p for p in source_skills.iterdir() if p.is_dir()])


def main() -> None:
    total_agents = 0
    total_skills = 0
    for jurisdiction in JURISDICTIONS:
        agents, skills = generate_jurisdiction(jurisdiction)
        total_agents += agents
        total_skills += skills
    print(f"Generated Claude plugin files: {total_agents} agents, {total_skills} skills.")


if __name__ == "__main__":
    main()
```

- [ ] **Step 2: Generate Claude adapter files**

Run:

```bash
python3 scripts/generate-claude-plugin-files.py
```

Expected output:

```text
Generated Claude plugin files: 20 agents, 42 skills.
```

- [ ] **Step 3: Run the platform validator and confirm the next failure has advanced**

Run:

```bash
python3 scripts/validate-platform-adapters.py
```

Expected: FAIL with a Codex adapter issue, such as a missing canonical source reference in `plugins/*/.codex/agents/*.toml`. This proves Claude adapters now match canonical sources.

Do not commit yet.

---

### Task 4: Update Codex Generation And Validation

**Files:**

- Modify: `scripts/convert-agents-to-codex.py`
- Modify: `scripts/validate-codex-agents.py`
- Modify: `plugins/*/.codex/agents/*.toml` through regeneration

- [ ] **Step 1: Replace `scripts/convert-agents-to-codex.py`**

Use `apply_patch` to replace the file with this exact content:

```python
#!/usr/bin/env python3
"""Generate Codex custom-agent TOML files from canonical businesspowers agents.

This keeps `agents/<jurisdiction>/*.md` as the source of truth and writes
Codex-compatible custom agents to `plugins/<jurisdiction>/.codex/agents/*.toml`.
"""

from __future__ import annotations

import json
import re
import shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
FRONTMATTER_RE = re.compile(r"\A---\n(.*?)\n---\n?(.*)\Z", re.S)
SUPPORTED_MODELS = {
    "sonnet": "gpt-5.4-mini",
    "claude-sonnet": "gpt-5.4-mini",
    "haiku": "gpt-5.4-mini",
    "opus": "gpt-5.4",
}
OMIT_MODELS = {"inherit", "default", ""}


def parse_frontmatter(text: str) -> tuple[dict[str, object], str]:
    match = FRONTMATTER_RE.match(text)
    if not match:
        return {}, text
    raw, body = match.groups()
    return parse_simple_yaml(raw), body


def parse_simple_yaml(raw: str) -> dict[str, object]:
    values: dict[str, object] = {}
    current_key: str | None = None
    for line in raw.splitlines():
        if not line.strip():
            continue
        if line.startswith("  - ") and current_key:
            current = values.setdefault(current_key, [])
            if not isinstance(current, list):
                current = [current]
                values[current_key] = current
            current.append(line[4:].strip())
            continue
        key, sep, value = line.partition(":")
        if not sep:
            continue
        current_key = key.strip()
        value = value.strip()
        if value.startswith("[") and value.endswith("]"):
            values[current_key] = [part.strip().strip('"\'') for part in value[1:-1].split(",") if part.strip()]
        elif value:
            values[current_key] = value.strip('"')
        else:
            values[current_key] = []
    return values


def as_list(value: object) -> list[str]:
    if value is None:
        return []
    if isinstance(value, list):
        return [str(item).strip() for item in value if str(item).strip()]
    return [part.strip() for part in str(value).split(",") if part.strip()]


def toml_string(value: str) -> str:
    return json.dumps(value, ensure_ascii=False)


def toml_multiline(value: str) -> str:
    return toml_string(value.rstrip())


def plugin_codex_name(plugin_dir: Path) -> str:
    manifest = plugin_dir / ".codex-plugin" / "plugin.json"
    if not manifest.is_file():
        raise FileNotFoundError(f"Missing Codex plugin manifest: {manifest}")
    return json.loads(manifest.read_text(encoding="utf-8"))["name"]


def canonical_names(jurisdiction: str) -> set[str]:
    agent_dir = ROOT / "agents" / jurisdiction
    skill_dir = ROOT / "skills" / jurisdiction
    names = {path.stem for path in agent_dir.glob("*.md")}
    if skill_dir.is_dir():
        names.update(path.name for path in skill_dir.iterdir() if (path / "SKILL.md").is_file())
    return names


def unprefixed_canonical_names(jurisdiction: str, plugin_name: str) -> set[str]:
    prefix = f"{plugin_name}-"
    return {name.removeprefix(prefix) if name.startswith(prefix) else name for name in canonical_names(jurisdiction)}


def prefixed_name(plugin_name: str, source_name: str) -> str:
    return source_name if source_name.startswith(f"{plugin_name}-") else f"{plugin_name}-{source_name}"


def protect_external_references(text: str, jurisdiction: str) -> tuple[str, dict[str, str]]:
    protected: dict[str, str] = {}

    def replace(match: re.Match[str]) -> str:
        token = f"__LAWPOWERS_EXTERNAL_REF_{len(protected)}__"
        protected[token] = match.group(0)
        return token

    pattern = rf"lawpowers:{re.escape(jurisdiction)}:[A-Za-z0-9_-]+"
    return re.sub(pattern, replace, text), protected


def restore_external_references(text: str, protected: dict[str, str]) -> str:
    for token, original in protected.items():
        text = text.replace(token, original)
    return text


def rewrite_body_references(body: str, jurisdiction: str, plugin_name: str, same_jurisdiction_names: set[str]) -> str:
    body, protected = protect_external_references(body, jurisdiction)
    body = re.sub(rf"(?<!lawpowers:)\b{re.escape(jurisdiction)}:(?!{re.escape(plugin_name)}-)([A-Za-z0-9_-]+)", rf"{plugin_name}-\1", body)
    body = re.sub(
        rf"\.\./\.\./skills/{re.escape(jurisdiction)}/(?:{re.escape(plugin_name)}-)?([A-Za-z0-9_-]+)/SKILL\.md",
        rf"../skills/{plugin_name}-\1/SKILL.md",
        body,
    )
    body = re.sub(rf"\.\./(?:{re.escape(plugin_name)}-)?([A-Za-z0-9_-]+)/SKILL\.md", rf"../skills/{plugin_name}-\1/SKILL.md", body)
    for name in sorted(same_jurisdiction_names, key=len, reverse=True):
        body = re.sub(
            rf"(?<![A-Za-z0-9_-])(?<!{re.escape(plugin_name)}-){re.escape(name)}(?![A-Za-z0-9_-])",
            f"{plugin_name}-{name}",
            body,
        )
    return restore_external_references(body, protected)


def render_agent(source: Path, jurisdiction: str, plugin_name: str, same_jurisdiction_names: set[str]) -> tuple[str, str]:
    metadata, body = parse_frontmatter(source.read_text(encoding="utf-8"))
    body = rewrite_body_references(body, jurisdiction, plugin_name, same_jurisdiction_names)
    source_name = str(metadata.get("name") or source.stem).strip()
    codex_name = prefixed_name(plugin_name, source_name)
    description = str(metadata.get("description") or f"Migrated businesspowers agent `{source_name}`.").strip()
    description = rewrite_body_references(description, jurisdiction, plugin_name, same_jurisdiction_names)
    tools = as_list(metadata.get("tools"))
    source_model = str(metadata.get("model") or "").strip()
    mapped_model = SUPPORTED_MODELS.get(source_model.lower())

    notes: list[str] = [
        "## Codex migration notes",
        "",
        f"- Source canonical agent: `agents/{jurisdiction}/{source.name}`.",
        "- This file is generated by `scripts/convert-agents-to-codex.py`; edit the canonical Markdown agent, then regenerate.",
    ]
    if tools:
        notes.extend([
            "- Claude `tools` metadata is preserved as prompt guidance only; Codex does not treat this as a hard permission boundary.",
            "- Suggested tools from source: " + ", ".join(f"`{tool}`" for tool in tools) + ".",
        ])
    if source_model and source_model.lower() not in OMIT_MODELS and not mapped_model:
        notes.append(f"- Source model `{source_model}` has no explicit Codex mapping; session defaults apply.")

    instructions = body.rstrip() + "\n\n" + "\n".join(notes) + "\n"

    lines = [
        "# Generated from canonical businesspowers agent Markdown. Do not edit directly.",
        f"name = {toml_string(codex_name)}",
        f"description = {toml_string(description)}",
    ]
    if mapped_model:
        lines.append(f"model = {toml_string(mapped_model)}")
    lines.append(f"developer_instructions = {toml_multiline(instructions)}")
    return codex_name, "\n".join(lines) + "\n"


def convert_plugin(plugin_dir: Path) -> int:
    jurisdiction = plugin_dir.name
    agents_dir = ROOT / "agents" / jurisdiction
    if not agents_dir.is_dir():
        return 0
    plugin_name = plugin_codex_name(plugin_dir)
    same_jurisdiction_names = unprefixed_canonical_names(jurisdiction, plugin_name)
    output_dir = plugin_dir / ".codex" / "agents"
    if output_dir.exists():
        shutil.rmtree(output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    count = 0
    for source in sorted(agents_dir.glob("*.md")):
        codex_name, content = render_agent(source, jurisdiction, plugin_name, same_jurisdiction_names)
        (output_dir / f"{codex_name}.toml").write_text(content, encoding="utf-8")
        count += 1
    return count


def main() -> None:
    total = 0
    for plugin_dir in sorted((ROOT / "plugins").iterdir()):
        if plugin_dir.is_dir():
            total += convert_plugin(plugin_dir)
    print(f"Generated {total} Codex agent files.")


if __name__ == "__main__":
    main()
```

- [ ] **Step 2: Replace `scripts/validate-codex-agents.py`**

Use `apply_patch` to replace the file with this exact content:

```python
#!/usr/bin/env python3
"""Validate generated Codex custom-agent files."""

from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def plugin_codex_name(plugin_dir: Path) -> str:
    return json.loads((plugin_dir / ".codex-plugin" / "plugin.json").read_text(encoding="utf-8"))["name"]


def fail(message: str) -> None:
    print(f"error: {message}", file=sys.stderr)
    raise SystemExit(1)


def parse_generated_toml(path: Path) -> dict[str, str]:
    """Parse the small TOML subset emitted by convert-agents-to-codex.py."""
    data: dict[str, str] = {}
    for line in path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        if "=" not in line:
            fail(f"{path} has unparsable line: {line!r}")
        key, raw_value = [part.strip() for part in line.split("=", 1)]
        try:
            data[key] = json.loads(raw_value)
        except json.JSONDecodeError as exc:
            fail(f"{path} has invalid string value for `{key}`: {exc}")
    return data


def expected_codex_name(plugin_name: str, source_name: str) -> str:
    return source_name if source_name.startswith(f"{plugin_name}-") else f"{plugin_name}-{source_name}"


def main() -> None:
    seen_names: set[str] = set()
    source_count = 0
    generated_count = 0

    for plugin_dir in sorted((ROOT / "plugins").iterdir()):
        if not plugin_dir.is_dir():
            continue
        jurisdiction = plugin_dir.name
        agents_dir = ROOT / "agents" / jurisdiction
        if not agents_dir.is_dir():
            continue
        plugin_name = plugin_codex_name(plugin_dir)
        output_dir = plugin_dir / ".codex" / "agents"
        if not output_dir.is_dir():
            fail(f"missing generated agent directory: {output_dir}")

        expected_files: set[str] = set()
        for source in sorted(agents_dir.glob("*.md")):
            source_count += 1
            expected_name = expected_codex_name(plugin_name, source.stem)
            expected_files.add(f"{expected_name}.toml")
            generated = output_dir / f"{expected_name}.toml"
            if not generated.is_file():
                fail(f"missing generated agent for {source}: {generated}")
            generated_count += 1
            text = generated.read_text(encoding="utf-8")
            data = parse_generated_toml(generated)
            for key in ("name", "description", "developer_instructions"):
                if not str(data.get(key, "")).strip():
                    fail(f"{generated} missing non-empty `{key}`")
            if data["name"] != expected_name:
                fail(f"{generated} has name {data['name']!r}; expected {expected_name!r}")
            if data["name"] in seen_names:
                fail(f"duplicate generated agent name: {data['name']}")
            seen_names.add(data["name"])
            if f"Source canonical agent: `agents/{jurisdiction}/{source.name}`." not in text:
                fail(f"{generated} does not reference canonical source {source}")
            if ("[" + "TO" + "DO") in text:
                fail(f"placeholder found in {generated}")

        for generated in sorted(output_dir.glob("*.toml")):
            if generated.name not in expected_files:
                fail(f"stale generated agent file: {generated}")

    if source_count != generated_count:
        fail(f"source/generated count mismatch: {source_count}/{generated_count}")
    print(f"Validated {generated_count} Codex agent files.")


if __name__ == "__main__":
    main()
```

- [ ] **Step 3: Regenerate Codex shims**

Run:

```bash
python3 scripts/convert-agents-to-codex.py
```

Expected output:

```text
Generated 20 Codex agent files.
```

- [ ] **Step 4: Run Codex validation**

Run:

```bash
python3 scripts/validate-codex-agents.py
```

Expected output:

```text
Validated 20 Codex agent files.
```

- [ ] **Step 5: Run platform validation**

Run:

```bash
python3 scripts/validate-platform-adapters.py
```

Expected output:

```text
Validated platform adapters: 20 agents, 42 skills.
```

- [ ] **Step 6: Commit generator and adapter changes**

Run:

```bash
git status --short
git diff --stat
git add package.json .opencode/plugins/businesspowers.js agents skills plugins scripts
git commit -m "feat: add OpenCode platform adapters"
```

Expected commit summary includes root `agents/`, root `skills/`, regenerated `plugins/*/agents`, regenerated `plugins/*/skills`, regenerated `plugins/*/.codex/agents`, and updated scripts.

---

### Task 5: Update Contributor And User Documentation

**Files:**

- Modify: `README.md`
- Modify: `CLAUDE.md`
- Modify: `AGENTS.md`
- Modify: `plugins/ua/README.md`
- Modify: `plugins/ua/CLAUDE.md`
- Modify: `plugins/ua/AGENTS.md`
- Modify: `plugins/pl/README.md`
- Modify: `plugins/pl/CLAUDE.md`
- Modify: `plugins/pl/AGENTS.md`

- [ ] **Step 1: Apply deterministic documentation name rewrites**

Run this script from the repository root to prefix public same-jurisdiction names in root and plugin docs:

```bash
python3 - <<'PY'
from pathlib import Path
import re

ROOT = Path.cwd()
CONFIG = {
    "ua": "business-ua",
    "pl": "business-pl",
}
DOC_FILES = [
    ROOT / "README.md",
    ROOT / "CLAUDE.md",
    ROOT / "AGENTS.md",
    ROOT / "plugins" / "ua" / "README.md",
    ROOT / "plugins" / "ua" / "CLAUDE.md",
    ROOT / "plugins" / "ua" / "AGENTS.md",
    ROOT / "plugins" / "pl" / "README.md",
    ROOT / "plugins" / "pl" / "CLAUDE.md",
    ROOT / "plugins" / "pl" / "AGENTS.md",
]


def names_for(jurisdiction: str) -> set[str]:
    names = {path.name.removeprefix(f"business-{jurisdiction}-") for path in (ROOT / "skills" / jurisdiction).iterdir() if (path / "SKILL.md").is_file()}
    names.update(path.stem.removeprefix(f"business-{jurisdiction}-") for path in (ROOT / "agents" / jurisdiction).glob("*.md"))
    return names


OLD_NAMES = {jurisdiction: names_for(jurisdiction) for jurisdiction in CONFIG}


def applies(path: Path, jurisdiction: str) -> bool:
    rel = path.relative_to(ROOT).as_posix()
    return rel in {"README.md", "CLAUDE.md", "AGENTS.md"} or rel.startswith(f"plugins/{jurisdiction}/")


for path in DOC_FILES:
    text = path.read_text(encoding="utf-8")
    for jurisdiction, prefix in CONFIG.items():
        if not applies(path, jurisdiction):
            continue
        text = re.sub(rf"\b{re.escape(jurisdiction)}:(?!{re.escape(prefix)}-)([A-Za-z0-9_-]+)", rf"{jurisdiction}:{prefix}-\1", text)
        for name in sorted(OLD_NAMES[jurisdiction], key=len, reverse=True):
            text = re.sub(
                rf"(?<![A-Za-z0-9_-])(?<!{re.escape(prefix)}-){re.escape(name)}(?![A-Za-z0-9_-])",
                f"{prefix}-{name}",
                text,
            )
    path.write_text(text, encoding="utf-8")
PY
```

Expected: no terminal output. The docs now reference examples such as `ua:business-ua-fop-registrator` and `pl:business-pl-jdg-tax-calculator`.

- [ ] **Step 2: Update root `AGENTS.md` platform guidance**

Use `apply_patch` to replace the opening paragraph and the source-of-truth/layout/verification bullets with these exact blocks:

```markdown
This repository supports Claude Code, Codex, and OpenCode. Claude Code remains supported through `.claude-plugin/` manifests and `CLAUDE.md`; Codex support lives in `.agents/plugins/marketplace.json`, plugin-level `.codex-plugin/plugin.json`, and this `AGENTS.md` instruction file; OpenCode support lives in root `package.json` plus `.opencode/plugins/businesspowers.js` for git package installation.
```

```markdown
- Top-level `agents/<jurisdiction>` and `skills/<jurisdiction>` are the source of truth for plugin behavior. Canonical agent and skill names are namespaced with `business-ua-` or `business-pl-`. Files under `plugins/*/agents`, `plugins/*/skills`, and `plugins/*/.codex/agents` are generated adapters.
```

```markdown
- `plugins/*/agents` and `plugins/*/skills` are generated Claude-compatible plugin copies derived from top-level canonical sources.
- `plugins/*/.codex/agents/*.toml` are generated Codex custom-agent shims derived from top-level canonical agent files.
- `package.json` exposes `.opencode/plugins/businesspowers.js` as the OpenCode package plugin entrypoint; that plugin anchors to the installed package root, exposes root `skills/ua` and `skills/pl`, and loads root `agents/ua` and `agents/pl` into OpenCode.
```

```bash
python3 scripts/generate-claude-plugin-files.py
python3 scripts/convert-agents-to-codex.py
python3 scripts/validate-codex-agents.py
python3 scripts/validate-platform-adapters.py
```

- [ ] **Step 3: Update root `CLAUDE.md` platform guidance**

Use `apply_patch` to update `CLAUDE.md` so these exact statements are present:

```markdown
Monorepo of jurisdiction-specific business & tax plugins for **Claude Code, Codex, and OpenCode**. One marketplace (`businesspowers`) hosts several plugins; each jurisdiction wraps subagents and skills for running a sole-trader business and handling individual taxes in a single legal system.
```

```markdown
Top-level `agents/<jurisdiction>` and `skills/<jurisdiction>` are the canonical source files and use namespaced `business-ua-*` / `business-pl-*` names. Files under `plugins/*/agents`, `plugins/*/skills`, and `plugins/*/.codex/agents` are generated adapters; OpenCode reads root sources through the package plugin entrypoint `.opencode/plugins/businesspowers.js`. Edit canonical files first, then regenerate adapters.
```

```markdown
- After changing canonical agents or skills, run `python3 scripts/generate-claude-plugin-files.py`, `python3 scripts/convert-agents-to-codex.py`, `python3 scripts/validate-codex-agents.py`, and `python3 scripts/validate-platform-adapters.py`.
- Do not hand-edit generated Codex agent TOML or generated Claude adapter files unless you also update the generators; top-level canonical agent and skill files remain the source of truth.
```

- [ ] **Step 4: Update root `README.md` install and source layout sections**

Use `apply_patch` so `README.md` includes this exact source layout block after the available plugin table:

```markdown
## Source layout

`agents/` and `skills/` are the canonical source folders:

| Source | Purpose |
|---|---|
| `agents/ua`, `skills/ua` | Ukrainian FOP and individual-tax agents and skills |
| `agents/pl`, `skills/pl` | Polish JDG and individual-tax agents and skills |

Platform folders are generated adapters:

| Generated path | Consumer |
|---|---|
| `plugins/*/agents`, `plugins/*/skills` | Claude Code plugins |
| `plugins/*/.codex/agents` | Codex custom-agent shims |
| `package.json`, `.opencode/plugins/businesspowers.js` | OpenCode git package plugin and root skill/agent loader |

Edit canonical files first, then run the generators and validators listed in the verification section.
```

Use `apply_patch` so `README.md` includes this exact OpenCode section before `## Landing page`:

```markdown
## Use in OpenCode

Install Businesspowers as an OpenCode plugin in the project where you want to use it. Add this to that project's `opencode.json`:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "plugin": ["businesspowers@git+https://github.com/crankshift/businesspowers.git"]
}
```

Restart OpenCode. The plugin package anchors itself to the installed Businesspowers package root, adds `skills/ua` and `skills/pl` to OpenCode, and loads Markdown agents from `agents/ua` and `agents/pl`.

For local development before pushing:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "plugin": ["file:///path/to/businesspowers"]
}
```

Generated OpenCode names are collision-safe:

| Jurisdiction | Agent and skill prefix | Example |
|---|---|---|
| Ukraine | `business-ua-` | `business-ua-fop-tax-calculator` |
| Poland | `business-pl-` | `business-pl-jdg-tax-calculator` |

Validate OpenCode package metadata and root source compatibility after changing canonical agents or skills:

```bash
python3 scripts/validate-platform-adapters.py
```

Adapter compatibility: this repo commits generated Claude plugin copies and Codex custom-agent files. OpenCode consumes the canonical root files through the package entrypoint `.opencode/plugins/businesspowers.js`. After changing canonical `agents/` or `skills/`, run:

```bash
python3 scripts/generate-claude-plugin-files.py
python3 scripts/convert-agents-to-codex.py
python3 scripts/validate-codex-agents.py
python3 scripts/validate-platform-adapters.py
```
```

- [ ] **Step 5: Update plugin-level maintenance notes**

Use `apply_patch` so both `plugins/ua/AGENTS.md` and `plugins/pl/AGENTS.md` include these exact bullets in their Codex maintenance section:

```markdown
- Generated Claude agents and skills live in `agents/` and `skills/`; canonical source files live in the repository root under `agents/<jurisdiction>` and `skills/<jurisdiction>`.
- After editing a canonical agent or skill, run `python3 scripts/generate-claude-plugin-files.py` from the repo root, then `python3 scripts/convert-agents-to-codex.py`, `python3 scripts/validate-codex-agents.py`, and `python3 scripts/validate-platform-adapters.py`.
- Do not hand-edit generated plugin-local agents, plugin-local skills, or Codex TOML files unless you also update the relevant generator.
```

Use `apply_patch` so both `plugins/ua/CLAUDE.md` and `plugins/pl/CLAUDE.md` no longer say files are unprefixed. Replace those statements with jurisdiction-specific canonical source statements:

```markdown
- Канонічні файли агентів і скілів живуть у корені репозиторію: `agents/ua/business-ua-*.md` і `skills/ua/business-ua-*/SKILL.md`. Локальні `plugins/ua/agents` і `plugins/ua/skills` є згенерованими адаптерами.
```

```markdown
- Kanoniczne pliki agentów i skilli są w korzeniu repozytorium: `agents/pl/business-pl-*.md` i `skills/pl/business-pl-*/SKILL.md`. Lokalne `plugins/pl/agents` i `plugins/pl/skills` są wygenerowanymi adapterami.
```

- [ ] **Step 6: Re-run all generators after doc changes do not change generated adapters**

Run:

```bash
python3 scripts/generate-claude-plugin-files.py
python3 scripts/convert-agents-to-codex.py
python3 scripts/validate-codex-agents.py
python3 scripts/validate-platform-adapters.py
```

Expected output includes:

```text
Generated Claude plugin files: 20 agents, 42 skills.
Generated 20 Codex agent files.
Validated 20 Codex agent files.
Validated platform adapters: 20 agents, 42 skills.
```

- [ ] **Step 7: Commit documentation changes**

Run:

```bash
git status --short
git diff --stat
git add README.md CLAUDE.md AGENTS.md plugins/ua/README.md plugins/ua/CLAUDE.md plugins/ua/AGENTS.md plugins/pl/README.md plugins/pl/CLAUDE.md plugins/pl/AGENTS.md
git commit -m "docs: document platform adapter workflow"
```

Expected: commit succeeds and only documentation files are included.

---

### Task 6: Final Verification And Push

**Files:**

- Verify all modified files.
- Commit any remaining intended generated-file drift.
- Push `main` only if the user explicitly requests pushing or the current execution instruction includes pushing.

- [ ] **Step 1: Run final verification commands**

Run:

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

Expected:

```text
Generated Claude plugin files: 20 agents, 42 skills.
Generated 20 Codex agent files.
Validated 20 Codex agent files.
Validated platform adapters: 20 agents, 42 skills.
```

Each `python3 -m json.tool ...` command should print formatted JSON and exit with status 0.

- [ ] **Step 2: Check for unintended uncommitted changes**

Run:

```bash
git status --short
git diff --stat
git diff --cached --stat
```

Expected: no output from `git status --short`, no unstaged diff, and no staged diff. If generated files changed during final verification, inspect the diff and commit only intended generated changes with:

```bash
git add agents skills plugins scripts package.json .opencode README.md CLAUDE.md AGENTS.md
git commit -m "chore: refresh platform adapters"
```

- [ ] **Step 3: Push when requested**

If the user asked to push this implementation, run:

```bash
git log --oneline -5
git push origin main
git status --short
```

Expected: `git push` updates `origin/main`, and the final `git status --short` has no output.

---

## Self-Review

Spec coverage:

- Root canonical sources: Task 2.
- Prefixed `business-ua-*` and `business-pl-*` names: Task 2 bootstrap script and Task 4 validators.
- Generated Claude adapters: Task 3.
- Generated Codex adapters: Task 4.
- OpenCode package support: Task 2.
- Documentation updates: Task 5.
- Verification commands: Task 6.

Placeholder scan:

- The plan contains no unresolved placeholder steps. Every command has an expected result.

Type and naming consistency:

- OpenCode entrypoint is consistently `.opencode/plugins/businesspowers.js`.
- Package name is consistently `businesspowers`.
- Canonical prefixes are consistently `business-ua-` and `business-pl-`.
- Validation counts match current source inventory: 20 agents and 42 skills.
