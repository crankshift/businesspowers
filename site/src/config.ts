import type { SiteConfig } from 'powers-landing-shell/types'

export const UA_AGENTS = [
  'fop-registrator',
  'tax-system-advisor',
  'fop-tax-calculator',
  'fop-reporting-agent',
  'fop-closer',
  'physical-person-tax-advisor',
  'investment-tax-agent',
  'invoice-manager',
  'invoice-analyzer',
] as const
export type UaAgent = (typeof UA_AGENTS)[number]

export const UA_SKILLS = [
  'calculating-edynyi-podatok',
  'calculating-esv',
  'calculating-pdfo-viyskovyi-zbir',
  'calculating-fop-on-zahalniy-systemi',
  'choosing-tax-group',
  'kved-codes-reference',
  'opening-fop-checklist',
  'closing-fop-checklist',
  'reporting-deadlines-ua',
  'filling-edynyi-podatok-deklaratsiya',
  'declaring-investments',
  'declaring-crypto',
  'converting-currency-nbu',
  'applying-tax-treaty',
  'fetching-podatkova-gov-ua',
  'fetching-diia-resources',
  'issuing-invoice-ua',
  'parsing-bank-statements-ua',
  'invoice-templates-ua',
  'reconciling-invoices-with-declaration',
] as const
export type UaSkill = (typeof UA_SKILLS)[number]

export const PL_AGENTS = [
  'jdg-registrator',
  'tax-form-advisor',
  'jdg-tax-calculator',
  'jdg-reporting-agent',
  'jdg-closer',
  'osoba-fizyczna-tax-advisor',
  'kapitalowe-investments-agent',
  'zus-agent',
  'vat-agent',
  'invoice-manager',
  'invoice-analyzer',
] as const
export type PlAgent = (typeof PL_AGENTS)[number]

export const PL_SKILLS = [
  'calculating-pit-scale',
  'calculating-pit-liniowy',
  'calculating-ryczalt',
  'calculating-zus',
  'calculating-skladka-zdrowotna',
  'calculating-pit-38',
  'choosing-tax-form',
  'pkd-codes-reference',
  'opening-jdg-checklist',
  'closing-jdg-checklist',
  'reporting-deadlines-pl',
  'declaring-pit-38',
  'declaring-crypto-pl',
  'converting-currency-nbp',
  'applying-umowa-o-unikaniu-podwojnego-opodatkowania',
  'fetching-podatki-gov-pl',
  'fetching-ceidg',
  'issuing-invoice-pl',
  'parsing-ksef-xml',
  'faktura-korygujaca-workflow',
  'parsing-bank-statements-pl',
  'reconciling-invoices-with-jpk-v7',
] as const
export type PlSkill = (typeof PL_SKILLS)[number]

export const PLUGIN_CODES = ['ua', 'pl'] as const
export type PluginCode = (typeof PLUGIN_CODES)[number]

export const LOCALE_CODES = ['en', 'ua', 'pl'] as const
export type LocaleCode = (typeof LOCALE_CODES)[number]

const FLAG_UA =
  '<span style="width:44px;height:30px;border-radius:4px;overflow:hidden;flex-shrink:0;border:1px solid var(--rule);display:grid;grid-template-rows:1fr 1fr" aria-hidden="true"><span style="background:#0057b7"></span><span style="background:#ffd700"></span></span>'

const FLAG_PL =
  '<span style="width:44px;height:30px;border-radius:4px;overflow:hidden;flex-shrink:0;border:1px solid var(--rule);display:grid;grid-template-rows:1fr 1fr" aria-hidden="true"><span style="background:#fff"></span><span style="background:#dc143c"></span></span>'

export const site: SiteConfig<PluginCode, LocaleCode> = {
  brand: 'businesspowers',
  brandSymbol: '%',
  repo: 'crankshift/businesspowers',
  url: 'https://businesspowers.web.app',
  defaultLocale: 'en',
  locales: [
    { code: 'en', hreflang: 'en', ogLocale: 'en_US', displayName: 'EN' },
    { code: 'ua', hreflang: 'uk', ogLocale: 'uk_UA', displayName: 'УКР' },
    { code: 'pl', hreflang: 'pl', ogLocale: 'pl_PL', displayName: 'PL' },
  ],
  plugins: [
    {
      code: 'ua',
      agents: UA_AGENTS,
      skills: UA_SKILLS,
      sources: [
        { name: 'tax.gov.ua (ДПС)', url: 'tax.gov.ua' },
        { name: 'zakon.rada.gov.ua', url: 'zakon.rada.gov.ua' },
        { name: 'Дія.Бізнес', url: 'business.diia.gov.ua' },
        { name: 'НБУ (курси)', url: 'bank.gov.ua' },
      ],
      flag: FLAG_UA,
    },
    {
      code: 'pl',
      agents: PL_AGENTS,
      skills: PL_SKILLS,
      sources: [
        { name: 'podatki.gov.pl (MF)', url: 'podatki.gov.pl' },
        { name: 'isap.sejm.gov.pl', url: 'isap.sejm.gov.pl' },
        { name: 'biznes.gov.pl (CEIDG)', url: 'biznes.gov.pl' },
        { name: 'NBP (kursy)', url: 'nbp.pl' },
        { name: 'KIS (eureka)', url: 'eureka.mf.gov.pl' },
      ],
      flag: FLAG_PL,
    },
  ],
}
