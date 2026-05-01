# businesspowers / ua — Codex guide

Codex plugin ID: `business-ua`. Claude Code plugin ID: `ua`.

Use this plugin for Ukrainian ФОП and individual-tax workflows. The working language is Ukrainian. Keep `agents/` and `skills/` as the source of truth, and keep this Codex guide in sync with `CLAUDE.md` and `README.md`.

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
