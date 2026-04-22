// @ts-check
import { defineConfig } from 'astro/config'
import sitemap from '@astrojs/sitemap'

const SITE = 'https://businesspowers.web.app'

export default defineConfig({
  site: SITE,
  trailingSlash: 'always',
  build: {
    format: 'directory',
  },
  i18n: {
    defaultLocale: 'en',
    locales: ['en', 'ua', 'pl'],
    routing: {
      prefixDefaultLocale: true,
      redirectToDefaultLocale: false,
    },
  },
  integrations: [
    sitemap({
      filter: (page) => page !== `${SITE}/`,
      i18n: {
        defaultLocale: 'en',
        locales: {
          en: 'en',
          ua: 'uk',
          pl: 'pl',
        },
      },
    }),
  ],
})
