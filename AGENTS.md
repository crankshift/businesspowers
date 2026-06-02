# businesspowers — Codex contributor guide

This repository supports Claude Code, Codex, and OpenCode. Claude Code remains supported through `.claude-plugin/` manifests and `CLAUDE.md`; Codex support lives in `.agents/plugins/marketplace.json`, plugin-level `.codex-plugin/plugin.json`, and this `AGENTS.md` instruction file; OpenCode support lives in `package.json` and `.opencode/plugins/businesspowers.js`.

## Plugin map

| Jurisdiction | Claude plugin ID | Codex plugin ID | Folder | Language |
|---|---|---|---|---|
| Ukraine | `ua` | `business-ua` | `plugins/ua` | Ukrainian |
| Poland | `pl` | `business-pl` | `plugins/pl` | Polish |

Keep the existing folders and Claude IDs unchanged. Codex uses collision-safe IDs because Lawpowers also has `ua` and `pl` plugins.

## Repository rules

- One jurisdiction equals one plugin; do not mix UA and PL tax logic inside one agent or skill.
- Plugin language matches jurisdiction: UA content in Ukrainian, PL content in Polish, root docs in English.
- Root `agents/` and `skills/` remain the source of truth for plugin behavior.
- Top-level canonical files use `business-ua-*` and `business-pl-*`; generated adapters live under plugin folders.
- OpenCode reads root sources through `.opencode/plugins/businesspowers.js`.
- Businesspowers uses one repository-wide SemVer version. New release tags use `v<version>`; do not create new `ua/v<version>` or `pl/v<version>` tags.
- When bumping a release, update `package.json`, `.claude-plugin/marketplace.json`, and every plugin-level Claude/Codex manifest to the same version.
- When adding or renaming agents or skills, update the plugin README, `CLAUDE.md`, `AGENTS.md`, Claude manifest, and Codex manifest/marketplace when the public surface changes.
- Do not commit real personal or client data. Use placeholders such as `[ПІБ]`, `[РНОКПП]`, `[imię i nazwisko]`, `[PESEL]`, and `[NIP]`.
- Tax rates, thresholds, deadlines, and official interpretations must be verified against primary sources before use.

## Codex layout

- `agents/ua` and `skills/ua` are canonical Ukrainian ФОП and individual-tax sources.
- `agents/pl` and `skills/pl` are canonical Polish JDG and individual-tax sources.
- `plugins/*/agents` and `plugins/*/skills` are generated Claude Code plugin adapters.
- `.agents/plugins/marketplace.json` is the Codex marketplace catalog.
- `plugins/*/.codex-plugin/plugin.json` is the Codex plugin manifest.
- `AGENTS.md` files are Codex-facing contributor instructions.
- `CLAUDE.md` files remain Claude-facing contributor instructions.
- `plugins/*/.codex/agents/*.toml` are generated Codex custom-agent shims derived from root canonical agent files.
- Codex plugin manifests do not currently expose an `agents` field, so do not add one unless the schema changes; commit the generated `.codex/agents/` files for compatibility/import workflows.

## Verification

After changing platform support, validate JSON manifests and verify each marketplace `source.path` points to a plugin folder with `.codex-plugin/plugin.json` and `skills/`.

Run these after editing agents, skills, or platform adapter support:

```bash
python3 scripts/generate-claude-plugin-files.py
python3 scripts/convert-agents-to-codex.py
python3 scripts/validate-codex-agents.py
python3 scripts/validate-platform-adapters.py
```

Then validate JSON manifests with `python3 -m json.tool` and run the normal Claude plugin validation flow.
