# Changelog — businesspowers (monorepo)

Plugin-specific changes live in the per-plugin CHANGELOGs:

- [`plugins/ua/CHANGELOG.md`](./plugins/ua/CHANGELOG.md) — Ukrainian, tracks `ua` plugin releases.
- [`plugins/pl/CHANGELOG.md`](./plugins/pl/CHANGELOG.md) — Polish, tracks `pl` plugin releases.

This root file is an **index + monorepo-level structural log** only. It's not versioned. Cross-cutting structural moves (repo layout, release tooling, marketplace shape) show up here as dated entries.

---

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
