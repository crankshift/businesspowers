# businesspowers / ua — Codex guide

Codex plugin ID: `business-ua`. Claude Code plugin ID: `ua`.

Use this plugin for Ukrainian ФОП and individual-tax workflows. The working language is Ukrainian. Keep root `agents/ua` and `skills/ua` as the source of truth, and keep this Codex guide in sync with `CLAUDE.md` and `README.md`.

## Rules

- Verify rates, thresholds, deadlines, and legal text against primary sources before use.
- Primary sources include `zakon.rada.gov.ua`, `tax.gov.ua`, `cabinet.tax.gov.ua`, `diia.gov.ua`, `mof.gov.ua`, and `bank.gov.ua`.
- Never fabricate individual tax consultations, official letters, case numbers, or registry results.
- Use placeholders for personal data: `[ПІБ]`, `[РНОКПП]`, `[адреса]`, `[ІПН]`, `[рахунок]`.
- Outputs are drafts for human review, not tax, accounting, or legal advice.

## Codex maintenance

- Codex manifest: `.codex-plugin/plugin.json`.
- Claude manifest: `.claude-plugin/plugin.json`.
- If agents or skills change, update both Codex and Claude docs where user-visible names or behavior changes.
- Canonical source files: `agents/ua/business-ua-*.md` and `skills/ua/business-ua-*/SKILL.md` in the repo root.
- Generated Claude adapters: `plugins/ua/agents` and `plugins/ua/skills`.
- Generated Codex agents: `plugins/ua/.codex/agents/*.toml`.
- OpenCode reads root sources through `.opencode/plugins/businesspowers.js`.
- After editing agents, skills, or platform adapter support, run `python3 scripts/generate-claude-plugin-files.py`, `python3 scripts/convert-agents-to-codex.py`, `python3 scripts/validate-codex-agents.py`, and `python3 scripts/validate-platform-adapters.py` from the repo root.
- Do not add an `agents` field to `.codex-plugin/plugin.json` unless Codex schema support is confirmed.
- Tool lists from Claude agents are carried into Codex instructions as guidance, not hard permission boundaries.
