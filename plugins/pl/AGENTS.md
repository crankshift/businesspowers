# businesspowers / pl — Codex guide

Codex plugin ID: `business-pl`. Claude Code plugin ID: `pl`.

Use this plugin for Polish JDG and individual-tax workflows. The working language is Polish. Keep root `agents/pl` and `skills/pl` as the source of truth, and keep this Codex guide in sync with `CLAUDE.md` and `README.md`.

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
- Canonical source files: `agents/pl/business-pl-*.md` and `skills/pl/business-pl-*/SKILL.md` in the repo root.
- Generated Claude adapters: `plugins/pl/agents` and `plugins/pl/skills`.
- Generated Codex agents: `plugins/pl/.codex/agents/*.toml`.
- OpenCode reads root sources through `.opencode/plugins/businesspowers.js`.
- After editing agents, skills, or platform adapter support, run `python3 scripts/generate-claude-plugin-files.py`, `python3 scripts/convert-agents-to-codex.py`, `python3 scripts/validate-codex-agents.py`, and `python3 scripts/validate-platform-adapters.py` from the repo root.
- Do not add an `agents` field to `.codex-plugin/plugin.json` unless Codex schema support is confirmed.
- Tool lists from Claude agents are carried into Codex instructions as guidance, not hard permission boundaries.
