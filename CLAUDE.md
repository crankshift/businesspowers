# businesspowers — monorepo

Monorepo of jurisdiction-specific business & tax plugins for **Claude Code and Codex**. One marketplace (`businesspowers`) hosts several plugins; each plugin wraps subagents and skills for running a sole-trader business and handling individual taxes in a single legal system.

| Plugin | Jurisdiction | Scope | Command prefix | Working language | Documentation |
|---|---|---|---|---|---|
| [`ua`](./plugins/ua) | Ukraine | ФОП + фізична особа (investments, stocks, foreign income) | `/ua:…` | Ukrainian | [`ua/README.md`](./plugins/ua/README.md), [`ua/CLAUDE.md`](./plugins/ua/CLAUDE.md) |
| [`pl`](./plugins/pl) | Poland | JDG + osoba fizyczna (kapitały, PIT-38) | `/pl:…` | Polish | [`pl/README.md`](./plugins/pl/README.md), [`pl/CLAUDE.md`](./plugins/pl/CLAUDE.md) |

Plugins are independent: users install whichever jurisdiction(s) they need. Namespaces (`ua:`, `pl:`) don't collide, so both can be active at once (common for people who run a ФОП in Ukraine and a JDG in Poland after relocation).

User-facing install instructions live in the root [`README.md`](./README.md). This file is for contributors working on the repo itself.

## Repository layout

```
businesspowers/                     # GitHub: crankshift/businesspowers
├── README.md                       # user-facing — install guide, links to per-plugin docs
├── CLAUDE.md                       # this file — Claude Code contributor context
├── AGENTS.md                       # Codex contributor context (mirrors CLAUDE.md for Codex)
├── CHANGELOG.md                    # index of per-plugin CHANGELOGs + monorepo-level structural log
├── LICENSE                         # MIT — covers the whole repo
├── .claude-plugin/
│   └── marketplace.json            # Claude Code marketplace catalog
├── .agents/
│   └── plugins/
│       └── marketplace.json        # Codex marketplace catalog (business-ua, business-pl)
├── scripts/
│   ├── release.sh                  # release helper (bump, prepare, publish)
│   ├── convert-agents-to-codex.py  # generates .codex/agents/*.toml from Claude agents/*.md
│   └── validate-codex-agents.py    # validates generated Codex agent TOML files
├── plugins/                        # all jurisdiction plugins live here
│   ├── ua/                         # plugin "ua" — Ukrainian ФОП + фізособа
│   │   ├── README.md               # user-facing, Ukrainian
│   │   ├── CLAUDE.md               # Claude Code contributor context for the UA plugin
│   │   ├── AGENTS.md               # Codex contributor context for the UA plugin
│   │   ├── CHANGELOG.md            # plugin-level change log, Ukrainian
│   │   ├── .claude-plugin/plugin.json  # Claude Code manifest; name: "ua"
│   │   ├── .codex-plugin/plugin.json   # Codex manifest; name: "business-ua"
│   │   ├── .codex/agents/*.toml    # generated Codex custom-agent shims (from agents/*.md)
│   │   ├── agents/                 # source agent definitions (Claude + Codex source of truth)
│   │   └── skills/                 # skill definitions (shared by Claude Code and Codex)
│   └── pl/                         # plugin "pl" — Polish JDG + osoba fizyczna
│       ├── README.md               # user-facing, Polish
│       ├── CLAUDE.md               # Claude Code contributor context for the PL plugin
│       ├── AGENTS.md               # Codex contributor context for the PL plugin
│       ├── CHANGELOG.md            # plugin-level change log, Polish
│       ├── .claude-plugin/plugin.json  # Claude Code manifest; name: "pl"
│       ├── .codex-plugin/plugin.json   # Codex manifest; name: "business-pl"
│       ├── .codex/agents/*.toml    # generated Codex custom-agent shims (from agents/*.md)
│       ├── agents/                 # source agent definitions (Claude + Codex source of truth)
│       └── skills/                 # skill definitions (shared by Claude Code and Codex)
└── site/                           # public landing page (static Astro site, not a plugin)
    ├── README.md                   # site quick-start, deploy flow
    ├── CLAUDE.md                   # site contributor context
    ├── astro.config.mjs            # Astro + i18n + sitemap config
    ├── firebase.json               # Firebase Hosting config (multi-site "businesspowers")
    ├── package.json                # separate deps: astro, @astrojs/sitemap, powers-landing-shell
    └── src/
        ├── config.ts               # SiteConfig: brand, brandSymbol (%), plugins, agents, skills, sources
        ├── locales/{en,ua,pl}.ts    # locale dictionaries (satisfies ShellTranslation)
        ├── locales/index.ts         # dicts map + Translation re-export
        └── pages/
            ├── index.astro         # root: one-liner RedirectShell (browser-lang redirect)
            └── [locale]/index.astro # /en/, /ua/, /pl/ — one-liner PageShell
```

## Contribution principles

- **One jurisdiction = one plugin.** Don't mix UA and PL tax logic inside the same agent or skill — each plugin stays self-contained. A person who needs both installs both.
- **Plugin language matches jurisdiction.** Agents, skills, templates, and plugin-level docs (`README.md`, `CLAUDE.md`, `CHANGELOG.md`) for `ua` are in Ukrainian; for `pl` in Polish. Root-level documentation (at the repo root) is in English for broad accessibility.
- **Command prefixes come from plugin names.** `name` in `plugin.json` becomes the namespace — `/ua:…`, `/pl:…`. Agent and skill file names inside the plugin don't need a prefix; Claude Code adds it automatically.
- **Shared license.** MIT, applied at the repo root.
- **Independent plugin versions.** Each plugin carries its own `version` in its `plugin.json` (and mirrored in the marketplace entry). The marketplace catalog itself has a separate version in `marketplace.json:metadata.version`.
- **Releases are per-plugin, never monorepo-level.** Each plugin gets its own GitHub release with a prefixed tag: `ua/v0.3.0`, `pl/v0.3.0`. Release notes are in the plugin's language (Ukrainian for `ua`, Polish for `pl`). Never create a single release for the whole repo. When bumping versions, update `plugin.json` in each plugin + the corresponding entry in `marketplace.json`.
- **No fabricated rates.** If a tax rate or deadline isn't in the current published statute, it doesn't go in an agent. Better to prompt the user to verify than to hard-code stale numbers.

## Editorial rules (all plugins)

- **Verbatim citations.** Statutes are quoted in the exact wording in force on a given date, with a link to the primary source.
  - UA primary source: `zakon.rada.gov.ua` (Податковий кодекс України — ID `2755-17`).
  - PL primary source: `isap.sejm.gov.pl` (ustawa o PIT / VAT / ZUS; Dz.U.).
- **No fabricated rulings.** Tax interpretations, case numbers, and court rulings come only from official registries:
  - UA — [tax.gov.ua](https://tax.gov.ua) (листи-роз'яснення ДПС); ЄДРСР for litigated disputes.
  - PL — [eureka.mf.gov.pl](https://eureka.mf.gov.pl) (interpretacje indywidualne KIS); Portal Orzeczeń for litigated disputes.
  - If a citation can't be verified, mark it unverified or omit it.
- **Placeholders for personal data.** Templates must use placeholders:
  - UA: `[ПІБ]`, `[РНОКПП]`, `[адреса]`, `[ІПН]`, `[рахунок]`.
  - PL: `[imię i nazwisko]`, `[PESEL]`, `[NIP]`, `[REGON]`, `[adres]`, `[numer konta]`.
  - Never commit real client data.
- **Drafts, not final filings.** Every agent output is a working draft for a human to review and submit. Make that explicit in agent prompts and output.
- **Fast-moving tax law.** Both jurisdictions see annual or more frequent changes:
  - UA — ЗУ «Про Державний бюджет» щороку змінює мінімальну зарплату і ПМ, що впливає на ставки ЄП і ЄСВ; під час воєнного стану — пільги (група 3 під 2% замість 5% у 2022–23 була; група 1/2 із правом не сплачувати ЄСВ).
  - PL — Polski Ład (2022), Polski Ład 2.0 (липень 2022), 2023 zmiany w składce zdrowotnej, 2024–2026 — kolejne korekty dla JDG.
  - Agents should re-verify rates on each use rather than relying on cached knowledge.

## Key resources per jurisdiction

See per-plugin `CLAUDE.md` files for authoritative resource tables:
- Ukraine: [`plugins/ua/CLAUDE.md`](./plugins/ua/CLAUDE.md) → "Ключові ресурси"
- Poland: [`plugins/pl/CLAUDE.md`](./plugins/pl/CLAUDE.md) → "Kluczowe zasoby"

## Landing site (`site/`)

The repo ships a static marketing landing alongside the plugins. It lives in [`site/`](./site/), is deployed to Firebase Hosting at `https://businesspowers.web.app/`, and is maintained independently of plugin releases.

- **Stack:** Astro 6 + [powers-landing-shell](https://github.com/crankshift/powers-landing-shell). The site is a thin consumer — it supplies `SiteConfig` (brand, brandSymbol `%`, plugin catalogs) and locale dictionaries; the shell renders the page. No local components, layouts, or styles.
- **Languages:** EN, UA, PL — path-based routing (`/en/`, `/ua/`, `/pl/`). Dictionaries in `site/src/locales/`, structurally type-checked against the EN shape via `satisfies ShellTranslation`.
- **Deploy:** `cd site && pnpm run deploy` (requires `pnpm exec firebase login` once per machine).
- **Release coupling:** **none.** The site isn't versioned with the marketplace — push it whenever a user-facing change lands. The site *does* reflect plugin content (agent and skill lists with labels, counts derived from array lengths), so after a plugin bump update `site/src/config.ts` (add / remove entries in `UA_AGENTS` / `PL_AGENTS` / `UA_SKILLS` / `PL_SKILLS`) and the matching `agents` / `skills` label maps in `site/src/locales/*.ts`, then redeploy.
- **Editorial rules the site inherits:** same disclaimer discipline as the plugins (not tax or accounting advice, human review mandatory), same jurisdiction separation (no UA/PL mixing in one component), same no-fabrication rule (if it's not in `plugins/`, it's not on the landing).

Full contributor rules in [`site/CLAUDE.md`](./site/CLAUDE.md).

## Codex support

This repository also ships Codex plugin metadata. Keep Claude and Codex surfaces in sync when changing plugin structure.

- Claude marketplace: `.claude-plugin/marketplace.json`; Codex marketplace: `.agents/plugins/marketplace.json`.
- Claude plugin manifests stay in `plugins/*/.claude-plugin/plugin.json`; Codex plugin manifests stay in `plugins/*/.codex-plugin/plugin.json`.
- Claude contributor instructions live in `CLAUDE.md`; Codex contributor instructions live in `AGENTS.md`.
- Claude plugin IDs remain `ua` and `pl`; Codex plugin IDs are `business-ua` and `business-pl` to avoid collisions with `lawpowers`.
- When adding a plugin, agent, skill, or public install instruction, update README, CLAUDE.md, AGENTS.md, and both manifest families as applicable.
- Codex custom-agent files live in `plugins/*/.codex/agents/*.toml` and are generated from Claude `agents/*.md` files.
- After changing any agent frontmatter/body, run `python3 scripts/convert-agents-to-codex.py` and `python3 scripts/validate-codex-agents.py`.
- Do not hand-edit generated Codex agent TOML unless you also update the converter; Claude agent files remain the source of truth.
- Current Codex plugin manifests do not declare agents directly, so `.codex/agents/` is the compatibility/import layer.
