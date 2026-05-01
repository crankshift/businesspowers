# businesspowers

A collection of jurisdiction-specific business & tax plugins for **Claude Code and Codex**. Each plugin wraps a set of subagents and skills tuned to one country's tax system, registration procedures, reporting requirements, and the day-to-day headaches of running as a sole trader or declaring taxes as an individual.

Monorepo structure — install only the jurisdictions you need.

> ⚠️ **Disclaimer.** `businesspowers` is a drafting and guidance aid. It is **not tax advice**, **not accounting advice**, and does **not establish a professional relationship** with a certified accountant, tax advisor, or lawyer. Rates, thresholds, and reporting deadlines change frequently (Ukrainian tax law especially during martial law; Polish PIT / składka zdrowotna is reshaped almost every year by the Polski Ład reforms). Every output must be verified against the current primary source (state tax service of Ukraine, Ministry of Finance of Poland, the respective statute on its official portal) before being relied on for payment, filing, or planning. Neither Anthropic (Claude), OpenAI (Codex), nor the authors or contributors of this repository, make any warranty as to the accuracy, completeness, timeliness, or fitness for purpose of the output, and none of them accept any liability for the use of, or reliance on, this software or its results. Use at your own risk.

## Available plugins

| Plugin | Jurisdiction | Scope | Command prefix | Documentation | Language |
|---|---|---|---|---|---|
| [`ua`](./plugins/ua) | Ukraine | ФОП (private entrepreneur) + фізична особа (individual taxes, stocks, foreign income) | `/ua:…` | [`ua/README.md`](./plugins/ua/README.md) | Ukrainian |
| [`pl`](./plugins/pl) | Poland | JDG (sole proprietorship) + osoba fizyczna (individual taxes, PIT-38 capital gains) | `/pl:…` | [`pl/README.md`](./plugins/pl/README.md) | Polish |

Each plugin's README covers the agents and skills it provides. The plugins are independent — installing one doesn't pull in the other.

## What it covers

Both plugins cover the **full life-cycle** of a sole trader plus the **personal-tax** add-ons that spill over from running a business:

- **Registration** — step-by-step guides for opening ФОП (via Дія / ЦНАП / notary) and JDG (via CEIDG).
- **Choosing a tax form** — decision trees and comparisons for UA єдиний податок groups 1–4 vs. загальна система, and PL skala / liniowy / ryczałt / karta.
- **Tax calculators** — єдиний податок, ЄСВ, ПДФО, військовий збір for UA; PIT (skala / liniowy), ryczałt, ZUS, składka zdrowotna, VAT for PL.
- **Reporting** — which form, by when, where to file (податкова декларація платника єдиного податку, 1-ДФ, додаток 4-ДФ; JPK_V7M/K, PIT-36, PIT-36L, PIT-28, PIT-11, PIT-38).
- **Closure** — clean exit procedures, final reporting obligations, EСВ / ZUS wind-down.
- **Personal investments** — declaring stocks (giełda, NYSE, Nasdaq), ETFs, dividends, crypto, IBKR / Revolut / XTB / Freedom24 statements. PIT-38 for PL; Додаток до декларації про майновий стан для фізосіб for UA.
- **Foreign-source income** — currency conversion at НБУ / NBP rate, avoidance of double taxation, treaty application.
- **Invoicing** — issuing acts/invoices in local currency and in USD/EUR/GBP for foreign clients; registering ПН in ЄРПН (UA VAT) or faktury VAT in KSeF (PL from 2026); correction invoices / РК / faktury korygujące; MPP for Polish >15k transactions; parsing bank statements (mono / privat24 / sense / fuib / ING / mBank / Santander / Pekao / Millennium); aging reports, cash-flow forecasts, reconciliation against the tax declaration (ЄП for UA, JPK_V7 for PL); client verification (ДПС registries, white list VAT, VIES, CEIDG, KRS); payment reminders, overdue notices, formal wezwania with interest under art. 625 CC / Polish Late Payments Act.

## Installation

Installation is a two-step process: add the marketplace once, then install each plugin you want.

### Step 1. Add the marketplace

#### Claude Desktop App (macOS/Windows)

1. **Settings → Extensions → Plugins**.
2. Switch to the **Personal** tab.
3. Click the «**+**» next to `Local uploads`.
4. Select **Add marketplace**.
5. Enter `crankshift/businesspowers` (or the full URL `https://github.com/crankshift/businesspowers`).

#### Claude Code CLI

```bash
claude
```

Then in the running session:

```
/plugin marketplace add crankshift/businesspowers
```

### Step 2. Install the plugin(s)

#### Ukraine only

```
/plugin install ua@businesspowers
/reload-plugins
```

Agents and skills become available under the `ua:` namespace — e.g. `ua:fop-registrator`, `ua:tax-system-advisor`, `ua:calculating-edynyi-podatok`, `ua:declaring-investments`.

See [`ua/README.md`](./plugins/ua/README.md) for the full catalog.

#### Poland only

```
/plugin install pl@businesspowers
/reload-plugins
```

Agents and skills under the `pl:` namespace — e.g. `pl:jdg-registrator`, `pl:tax-form-advisor`, `pl:calculating-ryczalt`, `pl:kapitalowe-investments-agent`.

See [`pl/README.md`](./plugins/pl/README.md) for the full catalog.

#### Both

```
/plugin install ua@businesspowers
/plugin install pl@businesspowers
/reload-plugins
```

The `ua:` and `pl:` namespaces are isolated — you can have both active at once and they won't conflict. This is actually a common setup for people who run a ФОП in Ukraine *and* a JDG in Poland (common since 2022 migration), or for accountants who serve clients on both sides of the border.

### Local development

```bash
git clone https://github.com/crankshift/businesspowers.git
cd businesspowers
claude --plugin-dir ./plugins/ua --plugin-dir ./plugins/pl
```

Or only one plugin:

```bash
claude --plugin-dir ./plugins/ua
```

### Verification

- `/plugin` → **Installed** tab — lists the plugins you've added.
- `/agents` — subagents show up with the `ua:` and/or `pl:` prefix.
- Skills trigger automatically on context (mentioning «єдиний податок» triggers `ua:calculating-edynyi-podatok`; mentioning «ryczałt» triggers `pl:calculating-ryczalt`).

### Updating

```
/plugin marketplace update businesspowers
/reload-plugins
```

Or enable auto-update from `/plugin` → **Marketplaces** → `businesspowers` → **Enable auto-update**.

### Uninstalling a single plugin

```
/plugin uninstall ua@businesspowers   # remove only UA
/plugin uninstall pl@businesspowers   # remove only PL
```

The marketplace stays registered; reinstall whenever you need.

## Install in Codex

Codex uses the `.agents/plugins/marketplace.json` catalog and the `.codex-plugin/plugin.json` manifests in each plugin folder. Add the marketplace once, then enable the plugin IDs you need from Codex's plugin UI or marketplace flow.

```bash
codex plugin marketplace add crankshift/businesspowers
```

For local development from a checkout:

```bash
git clone https://github.com/crankshift/businesspowers.git
cd businesspowers
codex plugin marketplace add .
```

Codex plugin IDs:

| Codex plugin ID | Folder | Claude Code equivalent |
|---|---|---|
| `business-ua` | `plugins/ua` | `ua@businesspowers` |
| `business-pl` | `plugins/pl` | `pl@businesspowers` |

Update the Codex marketplace copy with:

```bash
codex plugin marketplace upgrade businesspowers
```

Codex reads repo and plugin guidance from `AGENTS.md`; Claude Code reads `CLAUDE.md`. Keep both in sync when changing behavior.

## Landing page

The public landing lives at [`site/`](./site/) and is deployed to **https://businesspowers.web.app/**. It is a static Astro site (not a plugin) built on the [powers-landing-shell](https://github.com/crankshift/powers-landing-shell) package — multilingual (EN / UA / PL), SEO-first, deployed to Firebase Hosting independently of plugin releases.

See [`site/README.md`](./site/README.md) for local dev, deploy, and content-update instructions.

## Disclaimer

`businesspowers` is a tooling project whose sole purpose is to **assist with the administration of sole-trader businesses and personal tax matters**. It doesn't replace an accountant, tax advisor, or lawyer, and running an agent is not a professional consultation.

- **Not tax/legal advice.** Nothing produced by this software is tax advice, accounting advice, legal advice, or a substitute for retaining a licensed professional. No professional relationship is created by installing or using the plugins.
- **AI-generated guidance.** All agent output is generated by a large-language model and may be inaccurate, out of date, or incomplete. Tax law changes constantly — Ukrainian Податковий кодекс sees multiple amendments a year; Polish PIT, ZUS, and the infamous składka zdrowotna are rewritten almost annually by Polski Ład and its successors. Every rate, threshold, and deadline must be verified against the primary source on the day it's used.
- **Human review is mandatory.** Every calculation, declaration draft, or filing produced with these plugins must be reviewed, corrected, and adopted by the user (or their accountant / tax advisor) before it is filed with the tax authority, submitted to ZUS / ПФУ, or acted upon.
- **No warranty.** The software is provided "AS IS", without warranty of any kind, express or implied, including but not limited to warranties of merchantability, fitness for a particular purpose, legal or tax accuracy, or non-infringement.
- **No liability.** To the maximum extent permitted by law, neither Anthropic (the provider of Claude), OpenAI (the provider of Codex), nor the authors, maintainers, or contributors of this repository, will be liable for any direct, indirect, incidental, consequential, special, or exemplary damages arising from the use of, or inability to use, this software — including but not limited to damages from incorrect calculations, missed filing deadlines, under- or over-payment of tax, penalties, interest, fines, or any other financial or administrative consequence. You use these plugins entirely at your own risk.
- **Your responsibility.** How you use the tool, what you do with its output, and what consequences follow — including toward tax authorities, ZUS / ПФУ, banks, counterparties, and your own finances — is entirely yours. If you are not confident, consult a licensed tax advisor or accountant before acting.

## Shared principles

All plugins in this monorepo follow the same working principles:

- **Verbatim citations of statutes.** Articles of the Податковий кодекс / PIT / VAT act are quoted in the exact wording in force on a given date, with a direct link to the primary source (`zakon.rada.gov.ua` for UA, `isap.sejm.gov.pl` for PL).
- **Mandatory source references.** Every rate, threshold, or deadline carries a link to the article + source + verification date.
- **No fabricated interpretations.** Rulings, individual tax interpretations, and case numbers come only from official registries (tax.gov.ua explanatory letters for UA; eureka.mf.gov.pl for PL). Claude should never invent a citation.
- **Placeholders for personal data.** Templates use placeholders (`[ПІБ]` / `[imię i nazwisko]`, `[РНОКПП]` / `[PESEL] [NIP]`, `[адреса]` / `[adres]`) — never real client data in source files.
- **Drafts, not final filings.** Everything the agents produce is a working draft for a human to review, adapt, and file. Final responsibility is always human.
- **Rates change; code doesn't.** Every agent that cites a specific rate includes a «verify» step pointing to the primary source so the user re-checks before using. Hard-coded rates in this repo are a starting point, not a truth source.

## Extending the monorepo

Adding a plugin for a new jurisdiction (e.g. `de`, `cz`, `lt`, `ge`):

1. Create `./plugins/xx/` alongside the existing ones. Short ISO-style code.
2. Lay out the directory: `xx/README.md`, `xx/CLAUDE.md`, `xx/CHANGELOG.md`, `xx/.claude-plugin/plugin.json`, `xx/agents/`, `xx/skills/`.
3. Register it in `.claude-plugin/marketplace.json` under `plugins` with `"source": "./plugins/xx"`.
4. Add a CHANGELOG entry and bump `metadata.version` in the marketplace manifest.
5. Open a PR, merge, then tag a release.

See [`CLAUDE.md`](./CLAUDE.md) for the monorepo contributor guidelines.

## License

MIT — see [LICENSE](./LICENSE).
