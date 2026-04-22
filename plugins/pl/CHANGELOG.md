# Changelog — businesspowers/pl

Format — [Keep a Changelog](https://keepachangelog.com/pl/1.1.0/), wersjonowanie — [SemVer](https://semver.org/lang/pl/).

---

## [0.2.0] — 2026-04-22

### Dodano

**Agenci (2):**
- `invoice-manager` — wystawianie faktur VAT, rachunków, faktur walutowych (WDT, eksportowe), KSeF (obligatoryjny od 2026), faktur korygujących (in minus / in plus / techniczne), MPP dla transakcji > 15k, oznaczenia GTU.
- `invoice-analyzer` — rejestr faktur, aging report, cash-flow forecast, parsing wyciągów ING / mBank / Santander / Pekao / Millennium, uzgodnienie z JPK_V7, weryfikacja białej listy VAT i VIES, odsetki ustawowe za opóźnienie w transakcjach handlowych, wezwania do zapłaty.

**Skille (5):**
- `issuing-invoice-pl` — gotowe wzorce: faktura VAT, rachunek, faktura walutowa (WDT, eksport), faktura uproszczona (<450 zł), faktura zaliczkowa + końcowa.
- `parsing-ksef-xml` — struktura FA_VAT v3, parsowanie XML, walidacja XSD, integracja z API KSeF.
- `faktura-korygujaca-workflow` — procedura korekt in minus / in plus / technicznych; rozliczenie w JPK_V7; czynny żal; liberalizacja art. 29a ust. 15.
- `parsing-bank-statements-pl` — MT940, CSV, XML-CAMT.053; parsing ING / mBank / Santander / Pekao / Millennium / BNP / Nest; matchowanie z fakturami.
- `reconciling-invoices-with-jpk-v7` — uzgodnienie: rejestr ↔ JPK_V7 (sprzedaż + zakupy); weryfikacja GTU; uzgodnienie z WDT / VAT-UE; korekta JPK wg art. 81 Ordynacji.

### Zmieniono

- `plugin.json`: wersja 0.1.0 → 0.2.0; rozszerzony opis i keywords.

---

## [0.1.0] — 2026-04-22

### Dodano

**Agenci (9):**
- `jdg-registrator` — rejestracja JDG przez CEIDG / urząd gminy; wybór PKD; ZUS ZUA/ZZA; VAT-R; rachunek bankowy na białej liście.
- `tax-form-advisor` — wybór formy opodatkowania (skala 12%/32% vs liniowy 19% vs ryczałt 2%-17% vs karta) z uzasadnieniem.
- `jdg-tax-calculator` — kalkulacja PIT / ZUS / składki zdrowotnej / VAT; zaliczki miesięczne vs kwartalne.
- `jdg-reporting-agent` — kalendarz i formy sprawozdawczości: JPK_V7M/K, PIT-36/36L/28, PIT-11, ZUS DRA.
- `jdg-closer` — zamknięcie JDG: wykreślenie z CEIDG, VAT-Z, ZUS ZWUA, remanent, ostatnie deklaracje.
- `osoba-fizyczna-tax-advisor` — PIT-37/39; spadki (ustawa z 28.07.1983); sprzedaż nieruchomości; najem prywatny (ryczałt 8,5% / 12,5%).
- `kapitalowe-investments-agent` — PIT-38: akcje, ETF, dywidendy zagraniczne przez IBKR / Freedom24 / Wise / XTB; umowy o unikaniu podwójnego opodatkowania.
- `zus-agent` — Ulga na start (6 mies.), Mały ZUS (24 mies. preferencyjny), Mały ZUS Plus (do 120 tys. zł przychodu), Duży ZUS.
- `vat-agent` — rejestracja VAT-R, JPK_V7M/K, WDT/WNT, split payment, biała lista, KSeF.

**Skille (17):**
- Kalkulacje: `calculating-pit-scale`, `calculating-pit-liniowy`, `calculating-ryczalt`, `calculating-zus`, `calculating-skladka-zdrowotna`, `calculating-pit-38`.
- Wybór formy: `choosing-tax-form`, `pkd-codes-reference`.
- Rejestracja / zamknięcie: `opening-jdg-checklist`, `closing-jdg-checklist`.
- Sprawozdawczość: `reporting-deadlines-pl`.
- Inwestycje: `declaring-pit-38`, `declaring-crypto-pl`, `converting-currency-nbp`, `applying-umowa-o-unikaniu-podwojnego-opodatkowania`.
- Źródła: `fetching-podatki-gov-pl`, `fetching-ceidg`.

**Dokumentacja:**
- `README.md` — katalog agentów i skillów, scenariusze użycia.
- `CLAUDE.md` — kontekst dla Claude: zasady pracy, kluczowe zasoby, reguły nazewnictwa.
- `plugin.json` — manifest pluginu: nazwa «pl», wersja 0.1.0, słowa kluczowe dla marketplace.

### Podstawa prawna w momencie wydania

- **Ustawa o PIT** (Dz.U. 1991 nr 80 poz. 350) — tekst jednolity weryfikowany na 22.04.2026.
- **Ustawa o ryczałcie** (Dz.U. 1998 nr 144 poz. 930) — tekst jednolity weryfikowany na 22.04.2026.
- **Ustawa o VAT** (Dz.U. 2004 nr 54 poz. 535) — tekst jednolity weryfikowany na 22.04.2026.
- **Ustawa o systemie ubezpieczeń społecznych** (Dz.U. 1998 nr 137 poz. 887).
- **Polski Ład** — stan po nowelizacjach 2022-2026 (weryfikować aktualne korekty).
- Minimalne wynagrodzenie i prognozowane przeciętne wynagrodzenie na 2026 — weryfikować w obwieszczeniu MRiPS i ustawie budżetowej.
- Składka zdrowotna 2026 — zasady zależne od bieżącej redakcji ustawy o świadczeniach opieki zdrowotnej (weryfikować ostatnie zmiany).

[0.2.0]: https://github.com/crankshift/businesspowers/releases/tag/pl/v0.2.0
[0.1.0]: https://github.com/crankshift/businesspowers/releases/tag/pl/v0.1.0
