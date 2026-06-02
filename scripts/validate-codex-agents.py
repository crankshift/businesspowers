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
