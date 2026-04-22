# businesspowers — monorepo

Monorepo of jurisdiction-specific business & tax plugins for **Claude Code**. One marketplace (`businesspowers`) hosts several plugins; each plugin wraps subagents and skills for running a sole-trader business and handling individual taxes in a single legal system.

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
├── CLAUDE.md                       # this file — contributor context
├── CHANGELOG.md                    # index of per-plugin CHANGELOGs + monorepo-level structural log
├── LICENSE                         # MIT — covers the whole repo
├── .claude-plugin/
│   └── marketplace.json            # marketplace catalog ("businesspowers"); lists ua and pl with their source paths
└── plugins/                        # all jurisdiction plugins live here
    ├── ua/                         # plugin "ua" — Ukrainian ФОП + фізособа
    │   ├── README.md               # user-facing, Ukrainian
    │   ├── CLAUDE.md               # contributor context for the UA plugin
    │   ├── CHANGELOG.md            # plugin-level change log, Ukrainian
    │   ├── .claude-plugin/plugin.json  # name: "ua"
    │   ├── agents/
    │   └── skills/
    └── pl/                         # plugin "pl" — Polish JDG + osoba fizyczna
        ├── README.md               # user-facing, Polish
        ├── CLAUDE.md               # contributor context for the PL plugin
        ├── CHANGELOG.md            # plugin-level change log, Polish
        ├── .claude-plugin/plugin.json  # name: "pl"
        ├── agents/
        └── skills/
```

## Contribution principles

- **One jurisdiction = one plugin.** Don't mix UA and PL tax logic inside the same agent or skill — each plugin stays self-contained. A person who needs both installs both.
- **Plugin language matches jurisdiction.** Agents, skills, templates, and plugin-level docs (`README.md`, `CLAUDE.md`, `CHANGELOG.md`) for `ua` are in Ukrainian; for `pl` in Polish. Root-level documentation (at the repo root) is in English for broad accessibility.
- **Command prefixes come from plugin names.** `name` in `plugin.json` becomes the namespace — `/ua:…`, `/pl:…`. Agent and skill file names inside the plugin don't need a prefix; Claude Code adds it automatically.
- **Shared license.** MIT, applied at the repo root.
- **Independent plugin versions.** Each plugin carries its own `version` in its `plugin.json` (and mirrored in the marketplace entry). The marketplace catalog itself has a separate version in `marketplace.json:metadata.version`.
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

### Ukraine

| Ресурс | URL | Призначення |
|---|---|---|
| Податковий кодекс України | [zakon.rada.gov.ua/laws/show/2755-17](https://zakon.rada.gov.ua/laws/show/2755-17) | Первинне джерело податкового права |
| Державна податкова служба | [tax.gov.ua](https://tax.gov.ua) | Роз'яснення, кабінет платника, актуальні ставки |
| Дія | [diia.gov.ua](https://diia.gov.ua) | Реєстрація ФОП онлайн |
| Пенсійний фонд (ЄСВ) | [pfu.gov.ua](https://pfu.gov.ua) | ЄСВ: ставки, звіти, персональний кабінет |
| Національний банк | [bank.gov.ua](https://bank.gov.ua) | Офіційний курс валют для перерахунку |
| Мінфін | [mof.gov.ua](https://mof.gov.ua) | Мінімальна зарплата, прожитковий мінімум, ПМ |
| Електронний кабінет | [cabinet.tax.gov.ua](https://cabinet.tax.gov.ua) | Подання звітності, сплата податків |

### Poland

| Zasób | URL | Zastosowanie |
|---|---|---|
| Ustawa o PIT | [isap.sejm.gov.pl](https://isap.sejm.gov.pl/isap.nsf/DocDetails.xsp?id=WDU19910800350) | Podstawa prawna podatku dochodowego |
| Ustawa o VAT | [isap.sejm.gov.pl](https://isap.sejm.gov.pl/isap.nsf/DocDetails.xsp?id=WDU20040540535) | Podstawa prawna VAT |
| Ustawa o ryczałcie | [isap.sejm.gov.pl](https://isap.sejm.gov.pl/isap.nsf/DocDetails.xsp?id=WDU19981440930) | Ryczałt od przychodów ewidencjonowanych |
| Ministerstwo Finansów | [podatki.gov.pl](https://www.podatki.gov.pl) | Aktualne stawki, formularze, e-Urząd Skarbowy |
| KIS / interpretacje | [eureka.mf.gov.pl](https://eureka.mf.gov.pl) | Interpretacje indywidualne |
| CEIDG | [ceidg.gov.pl](https://www.biznes.gov.pl/pl/firma/ceidg) | Rejestracja JDG |
| ZUS | [zus.pl](https://www.zus.pl) | Składki społeczne i zdrowotna, kalkulator ZUS, e-PUE |
| NBP — kursy walut | [nbp.pl/kursy](https://www.nbp.pl/kursy) | Kurs średni NBP do przeliczeń |
| Biała lista VAT | [whitelist.tax.gov.pl](https://www.podatki.gov.pl/wykaz-podatnikow-vat-wyszukiwarka/) | Weryfikacja kontrahentów VAT |

For plugin-specific context (agent catalogs, jurisdiction-specific procedural rules, architectural notes) see the per-plugin `CLAUDE.md` files linked at the top.
