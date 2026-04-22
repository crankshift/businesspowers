# site — contributor context

Static landing page for [businesspowers](../README.md). This is **not** a Claude Code plugin; no agents, no skills. Plugins live under [`../plugins/`](../plugins/).

See [README.md](./README.md) for the user-facing quick start. This file is contributor context — human or agent — for working on the site itself.

## Architecture

The site is a **thin consumer** of the [`powers-landing-shell`](https://github.com/crankshift/powers-landing-shell) package. It has **no local components, layouts, or styles**. All rendering is done by the shell; the site supplies:

- **`src/config.ts`** — `SiteConfig` object: `brand: 'businesspowers'`, `brandSymbol: '%'`, plugin catalogs (agents, skills, sources), locale definitions.
- **`src/locales/{en,ua,pl}.ts`** — translation dictionaries that `satisfies ShellTranslation` from the shell.
- **`src/pages/index.astro`** — one-liner: `<RedirectShell site={site} />`.
- **`src/pages/[locale]/index.astro`** — one-liner: `<PageShell lang={locale} t={t} site={site} />`.

To override a section of the page, use `PageShell`'s named slots — don't fork shell components into the site.

## Ground rules

### This is a tax/business site, not a legal site

- The `brandSymbol` is `%`, not `§`.
- Disclaimer says "not tax or accounting advice", not "not legal advice".
- Copy is about sole-trader registration, tax calculations, reporting deadlines, invoicing, and investment declarations — not lawsuits, courts, or legal proceedings.

### Data source of truth

- Plugin catalogs (`UA_AGENTS`, `PL_AGENTS`, `UA_SKILLS`, `PL_SKILLS`) and sources live in `src/config.ts`. These arrays must match the actual contents of `../plugins/ua/agents/`, `../plugins/pl/agents/`, `../plugins/ua/skills/`, `../plugins/pl/skills/`. When the monorepo bumps plugin contents, update the arrays **and** the label maps in every locale dictionary. The `satisfies Record<..., string>` constraint makes missing keys a type error — lean on that rather than grepping.
- Hero stats (agent count, skill count) are computed from array lengths by the shell — don't hardcode numbers.

### Copy discipline

- Text stays **factual** and **in the working language of each locale's audience**. Skip marketing superlatives.
- Don't invent features. The landing reflects what the plugins actually do; if a claim isn't backed by an existing agent or skill in `../plugins/`, don't put it on the landing.
- Disclaimer copy (`t.disclaimer.*`) must say "not tax or accounting advice" and make clear that a qualified human accountant or tax advisor owns the final filing. This is non-negotiable — same rule as the plugins.

### i18n

- Locales: `en`, `ua`, `pl`. Default: `en`. URL path: `/{locale}/`.
- Root `/` is a minimal redirect page (`src/pages/index.astro`) — `RedirectShell` handles `<meta http-equiv="refresh">` plus an inline JS that reads `navigator.languages` and replaces location.
- Dictionaries: `src/locales/{en,ua,pl}.ts`. **`en.ts` defines the shape** via `export type Translation = typeof en`. `ua.ts` and `pl.ts` declare `export const <locale>: Translation = { ... }`, so missing keys fail `astro check`.
- Update all three locales together. Translation tone per locale: UA dictionary in Ukrainian, PL in Polish, EN in English. Don't leak English into UA / PL (except verbatim code snippets like `/plugin install ua@businesspowers`).
- **hreflang uses ISO 639-1** (`en`, `uk` for Ukrainian — note `uk`, not `ua` — and `pl`). Our URL path uses `ua` for namespace parity with the plugin. The mapping is defined in the `locales` array in `config.ts`.

### SEO

- Per-page `<title>` and `<meta description>` come from `t.seo` in each locale — keep them unique per locale and under ~160 chars where possible.
- Social-card image is `public/og.png` (1200x630), referenced as `/og.png` from OG / Twitter tags. The source is `scripts/build-og.mjs` (SVG authored in-script with `%` symbol and "Sole-trader tax & accounting" headline, rasterized with `sharp`); the generated PNG is committed. Regenerate with `pnpm build:og` whenever the source SVG changes.
- `src/pages/index.astro` is a redirect shell — it carries `noindex, follow` and is filtered out of the sitemap in `astro.config.mjs`. Don't let it drift back in or it'll duplicate the `/en/` canonical.
- Hreflang alternates must use ISO 639-1 (`en`, `uk`, `pl`) — see the i18n section. `x-default` points to `/en/`.

## Tech stack pin

| Thing | Version |
|---|---|
| Astro | `^6.1.8` |
| `@astrojs/sitemap` | `^3.7.2` |
| `@astrojs/check` | `^0.9.8` |
| TypeScript | `~6.0.2` |
| Node | `>= 22.12.0` |
| Firebase CLI | `^15.15.0` (devDependency) |
| `powers-landing-shell` | `github:crankshift/powers-landing-shell` |

Package manager: **pnpm**. Lockfile (`pnpm-lock.yaml`) is the source of truth.

## Build & deploy

```bash
pnpm build   # astro check + astro build → dist/
pnpm run deploy  # pnpm build + firebase deploy --only hosting:businesspowers
```

Firebase context:
- Project: `landings-d3578`
- Multi-site target: `businesspowers` → `https://businesspowers.web.app/`
- Target + public dir configured in `firebase.json`
- Web-SDK config (public identifiers) in `.env`; see `.env.example` for shape

## Do / don't

**Do**
- Keep the site as a thin shell consumer. Data in `config.ts`, labels in `locales/`, rendering in the shell.
- Use `PageShell` named slots if you need to override a section for businesspowers specifically.
- Pre-render everything — that's the whole point.
- Run `pnpm check` before committing.

**Don't**
- Don't add local components, layouts, or styles unless there's no slot or shell-level solution. The shell exists to keep sites DRY.
- Don't add a runtime framework. If you reach for React, stop and rethink.
- Don't fetch from `tax.gov.ua`, `podatki.gov.pl`, or any other live tax source at build or runtime. The landing is static marketing; live data fetches belong in the plugins.
- Don't pipe real client data into locale strings. Placeholders only (`[ПІБ]`, `[imię i nazwisko]`, etc.) — same rule as the plugins.
- Don't mix UA and PL content in one component. Keep parallel, jurisdiction-separated, like the plugins themselves.
- Don't commit `.env` — it's git-ignored for a reason. Use `.env.example` to document shape.
