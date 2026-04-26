# Changelog — businesspowers/ua

Формат — [Keep a Changelog](https://keepachangelog.com/uk/1.1.0/), версіонування — [SemVer](https://semver.org/lang/uk/).

---

## [0.4.0] — 2026-04-26

### Додано

- **Патерн «fetch-then-fallback»** для всіх 24 файлів UA-плагіна — агенти та скіли тепер спочатку отримують актуальні ставки з офіційних джерел (WebSearch/WebFetch zakon.rada.gov.ua, tax.gov.ua), а захардкоджені значення використовують лише як fallback із попередженням для користувача.

**Канонічні скіли (5 файлів — повні fetch-блоки «Актуальні параметри — отримати перед розрахунком»):**
- `calculating-esv` — ЄСВ 22%, МЗП min/max бази, воєнні пільги.
- `calculating-edynyi-podatok` — ставки/ліміти ЄП груп 1–3, ВЗ 1% для групи 3.
- `calculating-pdfo-viyskovyi-zbir` — ПДФО 18%, ВЗ 5%, ставки на дивіденди, спадщину, нерухомість, авто.
- `applying-tax-treaty` — ставки за конвенціями (WebFetch тексту договору).
- `issuing-invoice-ua` — ПДВ 20/7/0%, штрафи за ст. 120¹ ПКУ.

**Залежні скіли (10 файлів — перехресні посилання на канонічні скіли + fallback-анотації):**
- `calculating-fop-on-zahalniy-systemi`, `declaring-crypto`, `declaring-investments`, `filling-edynyi-podatok-deklaratsiya`, `choosing-tax-group`, `closing-fop-checklist`, `opening-fop-checklist`, `kved-codes-reference`, `reconciling-invoices-with-declaration`, `reporting-deadlines-ua` (+ міні fetch для штрафів і облікової ставки НБУ).

**Агенти (9 файлів — перехресні посилання + анотації):**
- `fop-tax-calculator`, `tax-system-advisor`, `physical-person-tax-advisor`, `investment-tax-agent`, `fop-reporting-agent`, `invoice-manager`, `invoice-analyzer`, `fop-registrator`, `fop-closer`.

### Змінено

- `plugin.json`: версія 0.3.0 → 0.4.0.

---

## [0.3.0] — 2026-04-26

### Змінено

- Оптимізація токенів: описи агентів скорочено до 250–350 символів, описи скілів — до 150–250 символів. Детальна інформація (статті НПА, ставки, назви форм) залишена в тілі кожного агента/скіла (завантажується при виклику).
- `CLAUDE.md`: видалено дублікати — секцію «Архітектура агентів», таблиці агентів/скілів, дерево файлів (усе завантажується автоматично з фронтматтера).
- `plugin.json`: версія 0.2.0 → 0.3.0.

---

## [0.2.0] — 2026-04-22

### Додано

**Агенти (2):**
- `invoice-manager` — виставлення рахунків, актів наданих послуг, інвойсів UA/EN; ПН в ЄРПН для ФОП-платників ПДВ; коригуючі розрахунки (РК); робота з mono business / privat24 / sense / fuib.
- `invoice-analyzer` — реєстр інвойсів, aging report, cash-flow прогноз, клієнтська аналітика, парсинг банківських виписок, звірка з декларацією ЄП, перевірка контрагентів, пеня за ст. 625 ЦК, претензійні листи.

**Скіли (4):**
- `issuing-invoice-ua` — готові шаблони актів / Invoice / рахунків; коли який документ; реквізити SWIFT/IBAN; реєстрація ПН.
- `parsing-bank-statements-ua` — алгоритм розпарсу mono / privat24 / sense / fuib CSV + API mono; класифікація транзакцій; матчинг з інвойсами.
- `invoice-templates-ua` — бібліотека шаблонів (Акт, English Invoice, рахунок, Statement, нагадування, Overdue notice).
- `reconciling-invoices-with-declaration` — звірка оборотів банку з декларацією платника ЄП (касовий метод ст. 292); уточнююча за ст. 50 ПКУ.

### Змінено

- `plugin.json`: версія 0.1.0 → 0.2.0; розширено опис та keywords.

---

## [0.1.0] — 2026-04-22

### Додано

**Агенти (7):**
- `fop-registrator` — реєстрація ФОП через Дію / ЦНАП / нотаріуса; вибір КВЕД; заява про спрощену систему; реєстрація платником ПДВ (за потреби).
- `tax-system-advisor` — вибір групи єдиного податку (1, 2, 3, 4) vs загальної системи з обґрунтуванням.
- `fop-tax-calculator` — розрахунок ЄП / ЄСВ / ПДВ / ПДФО+ВЗ; воєнні пільги; штрафи і пеня за прострочення.
- `fop-reporting-agent` — календар і форми звітності: декларація ЄП, додаток 4-ДФ, звіт з ЄСВ, декларація ПДВ.
- `fop-closer` — закриття ФОП: форма 8-ОПП, фінальна звітність, погашення боргів з ЄСВ, зняття з обліку.
- `physical-person-tax-advisor` — декларація про майновий стан (ст. 179 ПКУ), спадщина (ст. 174), подарунки, продаж нерухомості / авто.
- `investment-tax-agent` — декларування IBKR / Freedom24 / Wise / Revolut stocks і дивідендів; конвенції про уникнення подвійного оподаткування (USA, PL, CY, NL, UAE); крипто-активи.

**Скіли (16):**
- Розрахунки: `calculating-edynyi-podatok`, `calculating-esv`, `calculating-pdfo-viyskovyi-zbir`, `calculating-fop-on-zahalniy-systemi`.
- Вибір режиму: `choosing-tax-group`, `kved-codes-reference`.
- Реєстрація / закриття: `opening-fop-checklist`, `closing-fop-checklist`.
- Звітність: `reporting-deadlines-ua`, `filling-edynyi-podatok-deklaratsiya`.
- Інвестиції: `declaring-investments`, `declaring-crypto`, `converting-currency-nbu`, `applying-tax-treaty`.
- Джерела: `fetching-podatkova-gov-ua`, `fetching-diia-resources`.

**Документація:**
- `README.md` — каталог агентів і скілів, сценарії використання.
- `CLAUDE.md` — контекст для Claude: принципи роботи, ключові ресурси, правила найменування.
- `plugin.json` — маніфест плагіна: name «ua», версія 0.1.0, ключові слова для маркетплейсу.

### Правова база на момент релізу

- **ПКУ** (`2755-17`) — редакція перевірена станом на 22.04.2026.
- **ЗУ про ЄСВ** (`2464-17`) — редакція перевірена станом на 22.04.2026.
- **ЗУ № 4015-IX від 10.10.2024** — підвищення військового збору до 5% для загальних ставок з 01.12.2024, введення 1% ВЗ для ФОП 3 групи з 01.01.2025.
- Мінімальна зарплата на 2026 р. — перевіряти у ЗУ «Про Держбюджет України на 2026 рік» на момент розрахунку.

[0.4.0]: https://github.com/crankshift/businesspowers/releases/tag/ua/v0.4.0
[0.3.0]: https://github.com/crankshift/businesspowers/releases/tag/ua/v0.3.0
[0.2.0]: https://github.com/crankshift/businesspowers/releases/tag/ua/v0.2.0
[0.1.0]: https://github.com/crankshift/businesspowers/releases/tag/ua/v0.1.0
