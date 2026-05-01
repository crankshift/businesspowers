# businesspowers / pl — Codex guide

Codex plugin ID: `business-pl`. Claude Code plugin ID: `pl`.

Use this plugin for Polish JDG and individual-tax workflows. The working language is Polish. Keep `agents/` and `skills/` as the source of truth, and keep this Codex guide in sync with `CLAUDE.md` and `README.md`.

## Rules

- Verify rates, thresholds, deadlines, and legal text against primary sources before use.
- Primary sources include `isap.sejm.gov.pl`, `dziennikustaw.gov.pl`, `podatki.gov.pl`, `zus.pl`, `ceidg.gov.pl`, `krs.ms.gov.pl`, and `nbp.pl`.
- Never fabricate tax interpretations, official letters, case numbers, or registry results.
- Use placeholders for personal data: `[imię i nazwisko]`, `[PESEL]`, `[NIP]`, `[REGON]`, `[adres]`, `[numer konta]`.
- Outputs are drafts for human review, not tax, accounting, or legal advice.

## Codex maintenance

- Codex manifest: `.codex-plugin/plugin.json`.
- Claude manifest: `.claude-plugin/plugin.json`.
- If agents or skills change, update both Codex and Claude docs where user-visible names or behavior changes.
