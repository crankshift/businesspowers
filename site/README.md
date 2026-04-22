# businesspowers-site

Static marketing landing for the [businesspowers](../README.md) marketplace, built with **Astro 6** + **[powers-landing-shell](https://github.com/crankshift/powers-landing-shell)** and deployed to **Firebase Hosting**. Multilingual (EN / UA / PL), SEO-first, no runtime framework.

This is a separate sub-project inside the [businesspowers](../) monorepo. It is **not** a Claude Code plugin — no agents, no skills. Plugins live under [`../plugins/`](../plugins/).

## Stack

- **[Astro](https://astro.build) 6.1.8** — static site generator, output: `static`
- **[powers-landing-shell](https://github.com/crankshift/powers-landing-shell)** — shared layout, components, and styles; the site is a thin consumer that supplies config + locale dictionaries
- **No JS framework** — interactivity (copy buttons, theme toggle, install-tab switcher) is plain `<script>` inside shell components
- **Native Astro i18n** — `/en/`, `/ua/`, `/pl/` routes; root `/` detects browser language and redirects
- **[`@astrojs/sitemap`](https://docs.astro.build/en/guides/integrations-guide/sitemap/)** — generates `sitemap-index.xml` with hreflang alternates
- **Firebase Hosting** — multi-site target `businesspowers` in project `landings-d3578`

## Local development

```bash
pnpm install
pnpm dev         # http://localhost:4321
pnpm check       # astro check (type errors + syntax)
pnpm build       # astro check + astro build → dist/
pnpm preview     # local preview of dist/
pnpm build:og    # regenerate public/og.png from scripts/build-og.mjs
```

Requires **Node >= 22.12.0** and **pnpm**.

## Deploy

```bash
pnpm exec firebase login     # one-time, per machine
pnpm run deploy               # → https://businesspowers.web.app/
```

`pnpm run deploy` runs `astro check`, builds to `dist/`, then `firebase deploy --only hosting:businesspowers`. `public/og.png` is committed to the repo, so a plain deploy always ships the current social card — you don't need to run `pnpm build:og` unless you've changed the SVG source in `scripts/build-og.mjs`.

## Project structure

```
site/
├── astro.config.mjs          # site URL, i18n config, sitemap integration
├── firebase.json             # Firebase Hosting config (multi-site target "businesspowers")
├── .firebaserc               # Firebase project: landings-d3578
├── .env                      # PUBLIC_FIREBASE_* (public identifiers, git-ignored)
├── .env.example              # template for contributors
├── tsconfig.json             # extends astro/tsconfigs/strict
├── public/
│   ├── robots.txt
│   └── og.png               # 1200x630 social card, committed; regen via `pnpm build:og`
├── scripts/
│   └── build-og.mjs         # SVG → PNG via sharp; source of truth for og.png
└── src/
    ├── config.ts             # SiteConfig: brand, brandSymbol (%), plugins, agents, skills, sources
    ├── locales/
    │   ├── index.ts          # dicts map + re-export of Translation type
    │   ├── en.ts             # EN dictionary (shape source of truth)
    │   ├── ua.ts             # UA dictionary
    │   └── pl.ts             # PL dictionary
    └── pages/
        ├── index.astro       # root: one-liner RedirectShell (browser-lang redirect)
        └── [locale]/
            └── index.astro   # dynamic route → /en/, /ua/, /pl/ (one-liner PageShell)
```

No local components, layouts, or styles — everything comes from `powers-landing-shell`. The site supplies data (`config.ts`) and translations (`locales/`); the shell renders the page.

## Content changes

### Plugin catalogs

Source of truth: **`src/config.ts`** — `UA_AGENTS`, `PL_AGENTS`, `UA_SKILLS`, `PL_SKILLS` arrays plus the `sources` list for each plugin. These arrays must mirror the actual contents of `../plugins/ua/agents/`, `../plugins/pl/agents/`, `../plugins/ua/skills/`, `../plugins/pl/skills/`.

Hero stats (agent/skill counts) are computed from array lengths by the shell — don't hardcode numbers anywhere.

### Locale labels

Translations live in **`src/locales/{en,ua,pl}.ts`**. `en.ts` defines the `Translation` shape (which itself `satisfies ShellTranslation` from the shell package); `ua.ts` and `pl.ts` declare `export const <locale>: Translation = { ... }` — missing or extra keys fail `astro check` at build time.

When you add or remove an agent or skill in `config.ts`, you must also update the `agents.ua` / `agents.pl` / `skills.ua` / `skills.pl` label maps in every locale. The `satisfies Record<..., string>` constraint makes missing keys a type error.

Update all three locales together.

## Firebase config

| | |
|---|---|
| Project | `landings-d3578` |
| Multi-site target | `businesspowers` |
| Live URL | `https://businesspowers.web.app/` (and `.firebaseapp.com`) |
| Config file | `firebase.json` — `hosting.site: "businesspowers"`, `public: "dist"`, `trailingSlash: true` |

Web-SDK config (`apiKey`, `authDomain`, etc.) is in `.env` — see `.env.example` for the shape. These are **public identifiers**, not secrets, but **restrict the API key in [Cloud Console → Credentials](https://console.cloud.google.com/apis/credentials?project=landings-d3578)** by HTTP referrer once the domain is live. Add `https://businesspowers.web.app/*`, `https://businesspowers.firebaseapp.com/*`, and any custom domain.

### Custom domain

1. Firebase Console → Hosting → `businesspowers` → **Add custom domain**
2. Follow the A / CNAME instructions; SSL auto-provisions
3. Update `SITE` in `astro.config.mjs` to the new origin
4. Update `public/robots.txt` sitemap URL
5. `pnpm run deploy`

Canonical URLs, hreflang links, Open Graph URLs, and the sitemap are all driven from `SITE` — one change, all three locales update.

## SEO

Handled entirely by the shell:
- `<link rel="canonical">` per locale
- Full `hreflang` set (`en`, `uk` for Ukrainian, `pl`, `x-default`) on every page
- Open Graph + Twitter card meta per locale (`og:locale`, `og:locale:alternate`, `og:site_name`)
- Social card at `public/og.png` (1200x630), referenced from `og:image` + `twitter:image` with width / height / type / alt. Source is `scripts/build-og.mjs` (SVG authored inline, rasterized with `sharp`); regenerate with `pnpm build:og`
- `theme-color` meta with `prefers-color-scheme` variants for mobile browser chrome
- JSON-LD `@graph` (`WebSite` + `Organization`, localized `inLanguage`)
- `sitemap-index.xml` + per-URL alternate links via `@astrojs/sitemap`. Root `/` is filtered out of the sitemap (it's a redirect shell carrying `noindex, follow`) so only `/en/`, `/ua/`, `/pl/` appear
- `robots.txt` → sitemap
- `<html lang>` pulled from hreflang map
- `trailingSlash: 'always'` in Astro + `trailingSlash: true` in Firebase — canonical URLs end in `/`, no duplicate-content risk

Content (headings, paragraphs, agent lists) is rendered into HTML at build — no client-side hydration for crawlers.

## Disclaimer

This landing is marketing copy for a **calculation aid**. The plugins it promotes are not tax or accounting advice. See the [root README](../README.md) for the full liability disclaimer — the same terms apply to anything on this landing and to the marketplace as a whole.
