---
name: invoice-templates-ua
description: Use when generating invoice documents for Ukrainian ФОП. Covers templates for акт наданих послуг, English Invoice, proforma, ПН (VAT), mandatory fields, SWIFT/SEPA/IBAN payment instructions.
---

# invoice-templates-ua

Скіл — бібліотека готових шаблонів первинних документів і платіжних інструкцій.

## Кольоритетка — швидкий вибір

- ФОП без ПДВ → ТОВ → **акт наданих послуг** (UAH).
- ФОП без ПДВ → іноземний клієнт → **English Invoice** (USD/EUR).
- ФОП без ПДВ → попередня оплата → **рахунок на оплату (proforma)**.
- ФОП з ПДВ → будь-хто → **акт + ПН** (за Наказом № 1307).
- Клієнт хоче «Receipt» → **Statement of Services Rendered**.

## 1. Акт наданих послуг — базовий (UAH, B2B)

```
                          АКТ № [номер]
                 наданих послуг (виконаних робіт)

                  від «[день]» [місяць] [рік] р.                      м. [місто]

ВИКОНАВЕЦЬ: ФОП [ПІБ повністю]
  РНОКПП: [10 цифр]
  Адреса реєстрації: [індекс, місто, вулиця, буд.]
  IBAN: UA[24 символи]
  Банк: [повна назва]
  МФО: [6 цифр]
  Виписка з ЄДР: [реквізити]
  Платник єдиного податку __ групи за ставкою __ % (не є платником ПДВ)
  e-mail: [...]
  телефон: [...]

ЗАМОВНИК: [повна назва юрособи / ФОП]
  Код ЄДРПОУ (для ТОВ) / РНОКПП (для ФОП): [...]
  Адреса: [...]
  IBAN: [...]
  Банк: [...]
  МФО: [...]

Цим Актом сторони підтверджують, що на виконання Договору про надання послуг № __ від __.__.20__ р. Виконавець надав, а Замовник прийняв такі послуги:

┌───┬──────────────────────────────────────────┬──────┬───────┬───────────┬────────────┐
│ № │ Найменування послуги                     │ Од.  │ К-сть │ Ціна, грн │ Сума, грн  │
├───┼──────────────────────────────────────────┼──────┼───────┼───────────┼────────────┤
│ 1 │ [опис]                                   │ [..] │ [..]  │ [..]      │ [..]       │
│ 2 │                                          │      │       │           │            │
└───┴──────────────────────────────────────────┴──────┴───────┴───────────┴────────────┘

Разом без ПДВ: [сума прописом] гривень [копійок] коп. ([сума цифрами] грн)
Податок на додану вартість: не є платником ПДВ (підпункт 14.1.139 ПКУ)
ВСЬОГО до сплати: [...] грн

Послуги надано якісно, в повному обсязі, у строк, визначений Договором.
Сторони взаємних претензій не мають.

Цей Акт складено українською мовою у двох примірниках, по одному для кожної зі сторін,
які мають однакову юридичну силу.

ВИКОНАВЕЦЬ:                              ЗАМОВНИК:
ФОП [ПІБ]                                 [Посада] [Назва]
______________________ (підпис)           ______________________ (підпис)
                                          М.П. (за наявності)
```

## 2. English Invoice — standard (USD/EUR, B2B international)

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                               INVOICE                                     ║
║                                                                           ║
║   Invoice No.:      INV-[YYYY]-[###]                                      ║
║   Issue Date:       [DD Month YYYY]                                       ║
║   Due Date:         [DD Month YYYY]   (Net [N] days)                      ║
╚═══════════════════════════════════════════════════════════════════════════╝

FROM (Seller / Service Provider):
  [FULL NAME] — Private Entrepreneur (FOP)
  Ukrainian Individual Tax Number (RNOKPP): [XXXXXXXXXX]
  Registered Address: [street, city, postal code, Ukraine]
  Entry in Unified State Register of Ukraine: No. [...], date [...]
  Tax Status: Simplified Tax System, Group [1/2/3]
  VAT Status: Not registered for VAT

  Contact: [email], [phone]

BILL TO (Buyer / Client):
  [Full legal name]
  [Business address]
  [Country]
  [Registration No. / EIN / VAT ID, if any]

DESCRIPTION OF SERVICES / GOODS:
[2–3 sentences describing the scope: what was done, period, reference to agreement.]

┌────┬──────────────────────────────────────────────┬─────┬────────────┬────────────┐
│ #  │ Description                                  │ Qty │ Rate ([C]) │ Amount     │
├────┼──────────────────────────────────────────────┼─────┼────────────┼────────────┤
│ 1  │ [line item]                                  │     │            │            │
│ 2  │                                              │     │            │            │
└────┴──────────────────────────────────────────────┴─────┴────────────┴────────────┘

                                       Subtotal:     [C] [amount]
                                       Taxes:        N/A — supplied outside Ukrainian
                                                     VAT scope (art. 186.3, Ukrainian
                                                     Tax Code)
                                       TOTAL DUE:    [C] [amount]

PAYMENT INSTRUCTIONS (SWIFT wire transfer):

  Beneficiary Name:     [FULL NAME], Private Entrepreneur
  Beneficiary IBAN:     UA[XXX XXXX XXXX XXXX XXXX XXXX XXXX]
  Beneficiary Bank:     [Bank full name]
  Bank Address:         [address]
  SWIFT / BIC:          [8 or 11 chars]

  Correspondent Bank (if required):
    Bank Name:          [e.g., JPMorgan Chase Bank N.A.]
    SWIFT/BIC:          [CHASUS33]
    Account with Corr.: [if applicable]

PAYMENT REFERENCE (important):
  "Invoice INV-[YYYY]-[###]"

NOTES:
• Payment in [USD / EUR / GBP].
• Intermediary bank fees are the responsibility of the Buyer (SHA or OUR to be confirmed).
• Late payments incur interest at 3% per annum plus an inflation adjustment, under
  art. 625 of the Civil Code of Ukraine.
• Bank details may be verified via the Beneficiary directly. If in doubt, please contact
  [email] before the payment.

─────────────────────────────
Authorized by:
[Signature]
[Full Name], Private Entrepreneur
Date: [DD Month YYYY]
```

## 3. Proforma Invoice (Рахунок на оплату)

Найпростіший формат — для передплати.

```
ФОП [ПІБ]
РНОКПП: [...]                                   РАХУНОК № [номер]
Адреса: [...]                                   від [дата] р.
IBAN: [...]
Банк: [...], МФО [...]

Платник: [ТОВ / ФОП / фізособа]
Код ЄДРПОУ / РНОКПП: [...]

┌──┬─────────────────────────────┬──────┬───────┬───────────┬──────────┐
│№ │ Найменування                │ Од.  │ К-сть │ Ціна, грн │ Сума, грн│
├──┼─────────────────────────────┼──────┼───────┼───────────┼──────────┤
│1 │ [опис]                      │ [..] │ [..]  │ [..]      │ [..]     │
└──┴─────────────────────────────┴──────┴───────┴───────────┴──────────┘

Разом: [сума] грн
Без ПДВ.

Призначення платежу: «Оплата за послуги згідно рахунку № [...] від [...].
                     Без ПДВ.»

Рахунок дійсний до: [дата+5 днів].

ФОП [ПІБ]   _______________
```

## 4. Statement of Services / Receipt (підтвердження оплати)

Опціонально, на прохання клієнта.

```
STATEMENT OF SERVICES RENDERED

Date: [DD Month YYYY]
Reference: Invoice INV-[YYYY]-[###]

We hereby confirm that the services described in Invoice INV-[YYYY]-[###] dated
[date] have been fully rendered, and that payment in the amount of [C] [amount]
has been received in full on [date of credit] to our account.

We have no outstanding claims against the Buyer in connection with this Invoice.

─────────────────────────────
[Signature]
[Full Name], Private Entrepreneur
```

## 5. Payment reminder (нагадування, soft)

```
Subject: Friendly reminder — Invoice INV-2026-042

Dear [Client],

I hope this email finds you well.

I'd like to gently remind you that Invoice INV-2026-042 dated 10 April 2026
in the amount of USD 8,000 is due today.

If you have already initiated the payment, please disregard this message and
let me know the expected arrival date — SWIFT transfers sometimes take up to
5 business days.

If you need me to re-send the invoice or payment details, please reply and I'll
attach them again.

Thank you for your continued partnership.

Best regards,
[Name]
Private Entrepreneur
[email] · [phone]
```

## 6. Overdue notice (офіційне нагадування, 14+ днів прострочення)

```
Subject: Overdue Invoice INV-2026-042 — Payment Now [X] Days Late

Dear [Client],

I am writing to follow up on Invoice INV-2026-042 dated 10 April 2026 in the
amount of USD 8,000, which was due on 24 April 2026 and remains outstanding
as of today.

Current status:
  • Invoice amount:         USD 8,000.00
  • Due date:               24 April 2026
  • Days overdue:           [X]
  • Interest accrued (3% p.a. pursuant to Civil Code of Ukraine art. 625):
                            USD [calculated]
  • Total payable now:      USD [total]

Please arrange settlement within 7 calendar days of this notice. If you're
experiencing any issues with payment processing or the invoice itself, let me
know immediately so we can resolve them together.

In the absence of payment by [date + 7 days], I may be obligated to pursue
formal collection, including referral to a legal advisor.

Best regards,
[Name]
```

## Нумерація

### Рекомендовані формати

- **Простий:** `001`, `002`, ... (підходить для малого обсягу).
- **З роком:** `INV-2026-001`, `INV-2026-002`.
- **З місяцем:** `2026-04-01`, `2026-04-02` (рік-місяць-порядковий у місяці).
- **Префіксами для типів:**
  - `АКТ-2026-001` — для актів.
  - `РАХ-2026-001` — для рахунків.
  - `INV-2026-001` — для англомовних інвойсів.

### Правила

- Номер **унікальний** у межах ФОП (не дублювати).
- **Безперервний** — не пропускати (розриви → питання ДПС).
- Скасований / анульований документ — зберігати з позначкою «анульовано».

## Мультимовні версії

### Українська + Англійська в одному документі (для мішаних угод)

Для ФОП, який обслуговує і українських, і іноземних клієнтів — можна робити **двомовний Invoice**:

- Дві колонки або послідовно.
- Офіційно діє українська версія (у разі спору).
- Англомовна — для зручності іноземного клієнта.

### Польська (для клієнтів у Польщі)

- Використовувати Invoice/Faktura FA-002 формат (нижче в скіллах PL плагіна).
- Але ФОП в Україні видає українською + польською версії; польська тільки для зручності.

## Платіжні інструкції — дрібниці

### SWIFT для США-клієнтів

**Пам'ятати про correspondent bank:**
- Mono business → JPMorgan Chase (CHASUS33) як correspondent для USD.
- Sense → CITIUS33.
- PrivatBank → BOFAUS3NXXX (Bank of America).

### SEPA для ЄС

- **IBAN достатньо** для ЄС-платежу.
- SWIFT опціональний.
- Зазвичай без комісії intermediary.
- Європейські банки — 1-2 дні обробки.

### Wise / Payoneer (альтернативи SWIFT)

- **Wise** — локальні реквізити для USD, GBP, EUR. Клієнт платить як локальний, не SWIFT. Дешевше.
- **Payoneer** — рахунок для фрілансерів (хоча комісії вищі).

Вказувати в Invoice обидва варіанти — хай клієнт обирає:

```
PAYMENT OPTIONS:

Option A — Direct SWIFT to Ukraine:
  [Beneficiary IBAN, SWIFT, correspondent]

Option B — Wise / Payoneer local transfer (faster, cheaper):
  [Wise account details for USD / EUR]
```

## Типові помилки

| Помилка | Наслідок | Правильно |
|---|---|---|
| Відсутність `(не є платником ПДВ)` | Клієнт очікує ПН, йде конфлікт | Завжди зазначати статус |
| Лише IBAN без SWIFT для іноземного | SWIFT-платіж неможливий | SWIFT обов'язковий для 3-х країн |
| Нема correspondent bank для USD | Платіж «зависне» | JPMorgan Chase (CHASUS33) типово |
| Ставка UAH у English Invoice | Іноземний банк не може | Валюта = валюта договору |
| Дата Invoice = дата надсилання e-mail | Формально нецілком точно | Дата Invoice = дата фактичного надання послуг / виставлення |

## Обмеження

- Шаблони — базові; для специфічних індустрій (будівництво, медицина, IT з IP-трансфером) — додавати специфічні пункти (порядок прийому, гарантія, передача прав інтелектуальної власності).
- Для ФОП з великим обсягом — використовувати програмні генератори (Fakturownia, Invoicely, Wave).
- Для ПН-платників — тільки офіційна форма Наказу № 1307.
