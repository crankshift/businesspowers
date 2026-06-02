# Changelog — businesspowers

Format — [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), versioning — [SemVer](https://semver.org/).

Releases are unified across the repository and tagged as `v<version>`. The per-plugin changelogs keep jurisdiction-specific history from the earlier `ua/v<version>` and `pl/v<version>` release model.

---

## [0.5.0] — 2026-06-02

### Added

- Canonical root `agents/` and `skills/` sources for both jurisdictions, with generated Claude Code adapters under `plugins/*/agents` and `plugins/*/skills`.
- OpenCode package-plugin support through `package.json` and `.opencode/plugins/businesspowers.js`.
- Platform adapter validation covering canonical sources, generated Claude adapters, generated Codex agents, Codex manifests, and OpenCode package metadata.

### Changed

- Switched Businesspowers to a unified repository version shared by Claude Code marketplace metadata, Claude plugin manifests, Codex plugin manifests, and the OpenCode package manifest.
- Replaced per-plugin release tags (`ua/v<version>`, `pl/v<version>`) with one repository tag (`v<version>`) for new releases.
- Codex keeps collision-safe IDs (`business-ua`, `business-pl`) while Claude Code keeps the existing plugin IDs (`ua`, `pl`).
- Top-level canonical files now use `business-ua-*` and `business-pl-*` names; generated adapters preserve platform-specific loading behavior.

---

### 2026-05-01 — Codex agent compatibility

- `ua` bumped to `0.4.2`: generated Codex custom-agent TOML files from the existing Claude agents.
- `pl` bumped to `0.4.2`: same Codex custom-agent compatibility layer.
- Added `scripts/convert-agents-to-codex.py` and `scripts/validate-codex-agents.py` for keeping Claude and Codex agent artifacts in sync.
- Marketplace `metadata.version` bumped to `0.4.2`.

### 2026-05-01 — Codex support

- `ua` bumped to `0.4.1`: Codex marketplace/manifest support, `AGENTS.md`, and Codex install docs.
- `pl` bumped to `0.4.1`: same Codex support.
- Marketplace `metadata.version` bumped to `0.4.1`.

### 2026-04-26 — Token usage optimization

- `ua` bumped to `0.3.0`: agent descriptions trimmed to 250–350 chars, skill descriptions to 150–250 chars; `CLAUDE.md` deduplicated.
- `pl` bumped to `0.3.0`: same optimization applied.
- Marketplace `metadata.version` bumped to `0.3.0`.

### 2026-04-22 — Invoice layer added to both plugins

- `ua` bumped to `0.2.0`: +2 agents (`invoice-manager`, `invoice-analyzer`), +4 skills (`issuing-invoice-ua`, `parsing-bank-statements-ua`, `invoice-templates-ua`, `reconciling-invoices-with-declaration`).
- `pl` bumped to `0.2.0`: +2 agents (`invoice-manager`, `invoice-analyzer`), +5 skills (`issuing-invoice-pl`, `parsing-ksef-xml`, `faktura-korygujaca-workflow`, `parsing-bank-statements-pl`, `reconciling-invoices-with-jpk-v7`).
- Marketplace `metadata.version` bumped to `0.2.0`.

### 2026-04-22 — Initial monorepo scaffold

- Created monorepo `businesspowers` with two independent plugins:
  - `ua` — Ukrainian ФОП + фізична особа — initial version `0.1.0`.
  - `pl` — Polish JDG + osoba fizyczna — initial version `0.1.0`.
- Marketplace catalog `.claude-plugin/marketplace.json` created at version `0.1.0`.
- MIT license applied at repo root.
- See per-plugin CHANGELOGs for the agent/skill catalog shipped in each `0.1.0`.

[0.5.0]: https://github.com/crankshift/businesspowers/releases/tag/v0.5.0
