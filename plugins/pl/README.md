# businesspowers / pl

Plugin `pl` monorepo `businesspowers` — zestaw subagentów i skillów Claude Code, Codex i OpenCode do obsługi **Jednoosobowej Działalności Gospodarczej (JDG)** oraz **spraw podatkowych osoby fizycznej** w Polsce.

> ⚠️ **Nie jest to porada podatkowa.** Narzędzie pomaga w orientacji w procedurach, stawkach i sprawozdawczości, ale ostateczne wyliczenia i deklaracje powinny być zweryfikowane przez księgowego lub doradcę podatkowego (lub co najmniej przeciwko aktualnej treści ustawy o PIT / VAT / ZUS i własnemu kontu w e-Urzędzie Skarbowym na podatki.gov.pl).

## Dla kogo

- **JDG** — osoby prowadzące jednoosobową działalność gospodarczą na dowolnej formie opodatkowania.
- **IT-developerzy, freelancerzy, konsultanci** — PKD 62.01.Z, 62.02.Z, 63.12.Z, 70.22.Z; zwykle liniowy 19% lub ryczałt 12%/15%.
- **Osoby fizyczne**, które:
  - inwestują przez Interactive Brokers, XTB, eToro, Trading212, Revolut Stocks;
  - otrzymują dywidendy zagraniczne (US, UK, DE, FR);
  - sprzedały akcje lub ETF w danym roku podatkowym;
  - mają aktywność crypto (BTC, ETH, stablecoins);
  - otrzymały spadek, darowiznę.
- **Księgowi** obsługujący klientów z JDG.
- **Polsko-ukraińscy relokanci** — dla części ukraińskiej (ФОП) — plugin `/ua:…`.

## Instalacja

```
/plugin marketplace add crankshift/businesspowers
/plugin install pl@businesspowers
/reload-plugins
```

Po instalacji agenci i skille są dostępni pod prefiksem `/pl:…`.

Weryfikacja:

```
/agents
```

Powinno się pojawić `pl:business-pl-jdg-registrator`, `pl:business-pl-tax-form-advisor`, `pl:business-pl-jdg-tax-calculator` itd.

## Instalacja w Codex

Codex ID tego plagina: `business-pl`. Claude Code ID pozostaje `pl`.

Z marketplace GitHub:

```bash
codex plugin marketplace add crankshift/businesspowers
```

Lokalnie z checkoutu repozytorium:

```bash
cd /path/to/businesspowers
codex plugin marketplace add .
```

Po dodaniu marketplace'u włącz `business-pl` w Codex plugin UI / marketplace flow. Codex czyta instrukcje z `AGENTS.md`; Claude Code czyta `CLAUDE.md`.

Codex custom-agent files are included in `.codex/agents/`. They are generated from root `agents/pl/business-pl-*.md`, so update the Markdown source first and run the repo-level generator, converter, and validators before release.

## Źródła i adaptery

Pliki kanoniczne znajdują się w katalogu głównym repozytorium: `agents/pl/business-pl-*.md` i `skills/pl/business-pl-*/SKILL.md`.

`plugins/pl/agents` i `plugins/pl/skills` są wygenerowanymi adapterami Claude Code. `plugins/pl/.codex/agents` to wygenerowane Codex custom-agent shims. OpenCode czyta źródła z katalogu głównego przez `.opencode/plugins/businesspowers.js`.

Po zmianie agentów, skillów lub adapterów platformowych uruchom z katalogu głównego repozytorium:

```bash
python3 scripts/generate-claude-plugin-files.py
python3 scripts/convert-agents-to-codex.py
python3 scripts/validate-codex-agents.py
python3 scripts/validate-platform-adapters.py
```

## Katalog agentów

### Blok JDG — cykl życia działalności

| Agent | Zastosowanie |
|---|---|
| `business-pl-jdg-registrator` | Rejestracja JDG przez CEIDG (online) lub urząd gminy; wybór PKD, wybór formy opodatkowania (skala / liniowy / ryczałt / karta), zgłoszenie do ZUS (ZUS ZUA/ZZA), zgłoszenie VAT (VAT-R), zgłoszenie rachunku bankowego (biała lista), wybór Małego ZUS / Ulgi na start. Krok po kroku. |
| `business-pl-tax-form-advisor` | Pomoc w wyborze formy opodatkowania: skala 12%/32%, liniowy 19%, ryczałt (2% – 17% zależnie od działalności), karta podatkowa (praktycznie wygaszona od 2022). Porównanie pod dochód, strukturę kosztów, składkę zdrowotną, możliwości rozliczania z małżonkiem. |
| `business-pl-jdg-tax-calculator` | Kalkulacja PIT (skala / liniowy / ryczałt), ZUS (społeczne + chorobowe), składki zdrowotnej (w zależności od formy), VAT. Progi 2026, ulga termomodernizacyjna, PIT-0 dla rodzin 4+, IKZE. |
| `business-pl-jdg-reporting-agent` | Harmonogram i formy sprawozdawczości: JPK_V7M/K (VAT), PIT-36 (skala) / PIT-36L (liniowy) / PIT-28 (ryczałt), zaliczki miesięczne / kwartalne, PIT-11 (dla pracowników), zgłoszenia do ZUS. |
| `business-pl-jdg-closer` | Zamknięcie JDG: wniosek do CEIDG o wykreślenie, ostatnie deklaracje, wyrejestrowanie z VAT (VAT-Z), wyrejestrowanie z ZUS, rozliczenie końcowe składek zdrowotnych. |

### Blok osoba fizyczna

| Agent | Zastosowanie |
|---|---|
| `business-pl-osoba-fizyczna-tax-advisor` | Ogólne zagadnienia podatkowe osoby fizycznej: PIT-37 (pracownicy), spadki (ustawa o podatku od spadków i darowizn), sprzedaż nieruchomości (PIT-39), sprzedaż akcji / ETF przez polskiego pośrednika. |
| `business-pl-kapitalowe-investments-agent` | Deklarowanie zysków kapitałowych (PIT-38): akcje, ETF, dywidendy zagraniczne przez IBKR / Freedom24 / Wise / Revolut / XTB; podatek od zysków kapitałowych 19%; straty przez 5 lat przenoszone; W-8BEN dla US (15% zamiast 30%); zaliczenie podatku zagranicznego na podstawie umów o unikaniu podwójnego opodatkowania. |
| `business-pl-zus-agent` | Kompleksowa obsługa ZUS: składki społeczne, chorobowa, wypadkowa, Fundusz Pracy; **Ulga na start** (6 miesięcy bez ZUS społecznego), **Mały ZUS** (preferencyjny — 24 miesiące), **Mały ZUS Plus** (do ~120 tys. zł przychodu), podstawa wymiaru, e-PUE ZUS, terminy. |
| `business-pl-vat-agent` | VAT dla JDG i dla osoby fizycznej zwolnionej przedmiotowo/podmiotowo: rejestracja VAT-R, JPK_V7M/K, WDT/WNT (UE), importy, mechanizm podzielonej płatności (MPP), biała lista, kasa fiskalna. |

### Blok fakturowanie — praca operacyjna

| Agent | Zastosowanie |
|---|---|
| `business-pl-invoice-manager` | Wystawianie faktur VAT (dla VAT-czynnych), rachunków (dla zwolnionych z VAT), faktur walutowych (EUR/USD/GBP), WDT (0% VAT), eksportowych, zaliczkowych + końcowych; KSeF (obligatoryjny od 2026); faktury korygujące in minus / in plus; MPP dla > 15k zł; oznaczenia GTU. |
| `business-pl-invoice-analyzer` | Rejestr faktur, aging report, cash-flow forecast, TOP-10 klienci; parsowanie wyciągów ING / mBank / Santander / Pekao / Millennium (MT940, CSV); uzgodnienie z JPK_V7 (sprzedaż + zakupy); weryfikacja białej listy VAT, VIES, CEIDG, KRS; odsetki za opóźnienie (481 KC + ustawa o transakcjach handlowych); wezwania do zapłaty. |

## Katalog skillów

Skille uruchamiają się automatycznie z kontekstu. Kanoniczne źródła są w `skills/pl/business-pl-*/SKILL.md`; kopie plugin-local są wygenerowanymi adapterami.

### Kalkulacje

| Skill | Kiedy się włącza |
|---|---|
| `business-pl-calculating-pit-scale` | Kalkulacja PIT wg skali (12% do 120 000 zł, 32% powyżej); kwota wolna 30 000 zł; wspólne rozliczenie z małżonkiem; PIT-0 dla rodziców 4+ dzieci; kwota zmniejszająca podatek. |
| `business-pl-calculating-pit-liniowy` | Kalkulacja PIT liniowego 19% (art. 30c ustawy o PIT); brak kwoty wolnej, brak wspólnego rozliczenia, odliczenie składki zdrowotnej do limitu rocznego (10 200 zł na 2026 — weryfikować). |
| `business-pl-calculating-ryczalt` | Kalkulacja ryczałtu od przychodów ewidencjonowanych (ustawa z 20.11.1998): stawki 2% / 3% / 5,5% / 8,5% / 10% / 12% / 12,5% / 14% / 15% / 17%; limity przychodów (~2 mln euro); odliczenie składki zdrowotnej 50% zapłaconych; brak kosztów. |
| `business-pl-calculating-zus` | Składki społeczne ZUS dla JDG: emerytalna 19,52%, rentowa 8%, chorobowa 2,45% (dobrowolna), wypadkowa ~1,67%, Fundusz Pracy 2,45%. Podstawa wymiaru: min. 60% prognozowanego przeciętnego wynagrodzenia (duży ZUS); preferencyjna 30% min. wynagrodzenia (mały ZUS). |
| `business-pl-calculating-skladka-zdrowotna` | Składka zdrowotna w zależności od formy: skala (9% dochodu, min. = 9% × min. wynagr.), liniowy (4,9% dochodu, min. jak dla skali), ryczałt (zryczałtowana 3 progi — niski / średni / wysoki). |
| `business-pl-calculating-pit-38` | Kalkulacja podatku od zysków kapitałowych (PIT-38): 19% od nadwyżki przychodów nad kosztami; przenoszenie strat przez 5 lat; dywidendy zagraniczne z zaliczeniem podatku zagranicznego. |

### Wybór formy

| Skill | Kiedy się włącza |
|---|---|
| `business-pl-choosing-tax-form` | Drzewo decyzyjne: skala / liniowy / ryczałt / karta. Uwzględnia dochód, koszty, branżę (np. IT 12% ryczałt vs liniowy), rozliczenie z małżonkiem, ulgę na dzieci. |
| `business-pl-pkd-codes-reference` | Podręcznik kodów PKD dla JDG: IT (62.01.Z, 62.02.Z, 63.12.Z), konsultacje (70.22.Z), handel (47.xx), usługi (96.xx). Kody zakazane dla ryczałtu (art. 8 ustawy o ryczałcie). |

### Rejestracja i zamknięcie

| Skill | Kiedy się włącza |
|---|---|
| `business-pl-opening-jdg-checklist` | Pełna lista kroków otwarcia JDG: wniosek CEIDG-1, wybór PKD, opcje ZUS, VAT-R (jeśli potrzebny), zgłoszenie rachunku (biała lista), KSeF (jeśli obligatoryjny), kasa fiskalna. |
| `business-pl-closing-jdg-checklist` | Zamknięcie JDG: wniosek CEIDG-1 o wykreślenie, VAT-Z, ZUS ZWUA, ostatnie JPK_V7, ostatnie zaliczki PIT, rozliczenie roczne składki zdrowotnej. |

### Sprawozdawczość

| Skill | Kiedy się włącza |
|---|---|
| `business-pl-reporting-deadlines-pl` | Kalendarz: JPK_V7M (25-go), zaliczki PIT (20-go lub kwartalnie), PIT-36 (30 kwietnia), PIT-36L (30 kwietnia), PIT-28 (30 kwietnia od 2023), PIT-11 (31 stycznia), deklaracje ZUS (10-go / 15-go / 20-go). |
| `business-pl-filling-pit-36-liniowy` | Struktura PIT-36L (dla liniowego): dochód, składki ZUS odliczone, składka zdrowotna odliczona do limitu, zaliczki, podatek do zapłaty. |
| `business-pl-filling-jpk-v7` | JPK_V7M (miesięczny) / JPK_V7K (kwartalny): ewidencja sprzedaży i zakupów, sekcje deklaracyjne, kody GTU, oznaczenia SW, EE, TP. |

### Inwestycje i zyski kapitałowe

| Skill | Kiedy się włącza |
|---|---|
| `business-pl-declaring-pit-38` | Wypełnienie PIT-38: przychody, koszty uzyskania, dochód / strata, straty z poprzednich lat, dywidendy zagraniczne, podatek zagraniczny do zaliczenia. |
| `business-pl-declaring-crypto-pl` | Deklarowanie krypto w PIT-38 od 2019 (art. 30b ustawy o PIT): 19% od dochodu z odpłatnego zbycia; crypto→fiat i crypto→crypto obie są zdarzeniami podatkowymi; FIFO; straty przenoszone przez 5 lat. |
| `business-pl-converting-currency-nbp` | Przeliczenie walut obcych po kursie średnim NBP na dzień roboczy poprzedzający (art. 11a, 24a ustawy o PIT). |
| `business-pl-applying-umowa-o-unikaniu-podwojnego-opodatkowania` | Stosowanie umów o unikaniu podwójnego opodatkowania: US-PL 1974, DE-PL, FR-PL, UK-PL, IE-PL (UCITS ETF), NL-PL; zaliczenie proporcjonalne; certyfikat rezydencji. |

### Źródła

| Skill | Kiedy się włącza |
|---|---|
| `business-pl-fetching-podatki-gov-pl` | Praca z podatki.gov.pl (MF), e-Urząd Skarbowy, e-PUAP, KSeF; interpretacje indywidualne KIS (eureka.mf.gov.pl). |
| `business-pl-fetching-ceidg` | Praca z CEIDG (biznes.gov.pl/pl/firma/ceidg): rejestracja, zmiana wpisu, zawieszenie, wznowienie, wykreślenie. |

### Fakturowanie

| Skill | Kiedy się włącza |
|---|---|
| `business-pl-issuing-invoice-pl` | Gotowe wzorce: faktura VAT, rachunek, faktura walutowa (WDT / eksportowa), faktura uproszczona (<450 zł), zaliczkowa + końcowa. Obowiązkowe elementy art. 106e, MPP, GTU. |
| `business-pl-parsing-ksef-xml` | Struktura FA_VAT v3 XML; parsowanie elementów (Podmiot1/2, Fa, FaWiersz); walidacja XSD; API KSeF (zapytania, wysyłanie). |
| `business-pl-faktura-korygujaca-workflow` | Korekty in minus (moment potwierdzenia odbioru) / in plus (moment wystawienia) / techniczne; rozliczenie w JPK_V7; czynny żal; liberalizacja art. 29a ust. 15. |
| `business-pl-parsing-bank-statements-pl` | MT940 (SWIFT standard), CSV banków (ING, mBank, Santander, Pekao, Millennium, BNP, Nest); klasyfikacja transakcji; matchowanie z fakturami; konwersja walut wg NBP. |
| `business-pl-reconciling-invoices-with-jpk-v7` | Uzgodnienie rejestru faktur z JPK_V7 (sprzedaż + zakupy); weryfikacja GTU / MPP / oznaczeń procedur; uzgodnienie WDT z VAT-UE; korekta JPK wg art. 81 Ordynacji. |

## Przykładowe scenariusze

### «Otwieram JDG w IT, dochód ~15k/mies»

```
Jestem senior developerem, chcę otworzyć JDG, mam zawartą umowę z klientem z USA
na 15 000 zł brutto / miesiąc. Jaką formę opodatkowania wybrać?
```

Claude uruchomi `pl:business-pl-tax-form-advisor` → analiza: porównanie liniowego 19% vs ryczałtu 12% dla PKD 62.01.Z; z uwzględnieniem składki zdrowotnej i ZUS. Zwykle dla IT → **ryczałt 12%** jest optymalny przy dochodzie ~15 000 zł/mies.

### «Przekroczyłem próg w skali — co teraz?»

```
JDG na skali, za 2025 dochód przekroczył 120 000 zł. Muszę przejść na liniowy?
```

Claude uruchomi `pl:business-pl-jdg-tax-calculator` → wyjaśnienie: próg 120k zł to granica stawki (powyżej 32%), ale nie wymusza zmiany formy. Porównanie, czy liniowy 19% się opłaca. Zmiana formy możliwa do 20 lutego roku następnego, nie w trakcie.

### «Kupiłem Apple przez IBKR, co z podatkiem?»

```
W 2025 kupiłem akcje Apple przez IBKR, dostałem dywidendy $120 z potrąceniem
W-8BEN 15%. Jak rozliczyć?
```

Claude uruchomi `pl:business-pl-kapitalowe-investments-agent` → przeliczenie po NBP; kalkulacja PIT-38 19% z zaliczeniem 15% podatku amerykańskiego; wypełnienie sekcji dywidend PIT-38.

### «Mały ZUS Plus — opłaca się?»

```
Mam JDG od 2 lat, przychód w 2024 wynosił 100 000 zł. Kwalifikuję się na Mały ZUS Plus?
```

Claude uruchomi `pl:business-pl-zus-agent` → weryfikacja: do 120 000 zł (limit 2025, weryfikować 2026); obliczenie preferencyjnej podstawy; korzyść — oszczędność ~500-700 zł/mies w ZUS społecznym.

## Akty prawne

Główne ustawy, na które powołuje się plugin:

- **Ustawa o PIT** z 26.07.1991 (Dz.U. 1991 nr 80 poz. 350, tekst jednolity) — rozdziały o skali (art. 27), liniowym (art. 30c), PIT-38 (art. 30b).
- **Ustawa o ryczałcie** z 20.11.1998 (Dz.U. 1998 nr 144 poz. 930).
- **Ustawa o VAT** z 11.03.2004 (Dz.U. 2004 nr 54 poz. 535).
- **Ustawa o systemie ubezpieczeń społecznych** z 13.10.1998 (Dz.U. 1998 nr 137 poz. 887).
- **Ustawa o świadczeniach opieki zdrowotnej** z 27.08.2004 — składka zdrowotna (w redakcji Polski Ład).
- **Polski Ład 1.0** (2022), **2.0** (lipiec 2022), **korekta 2023**, kolejne zmiany 2024-2026.
- **Ustawa o podatku od spadków i darowizn** z 28.07.1983.
- **Ordynacja podatkowa** z 29.08.1997 — procedury.

Pełna lista w `CLAUDE.md` → «Kluczowe zasoby».

## Zastrzeżenie

Ten plugin jest **narzędziem wspomagającym, nie poradą podatkową**. Decyzje dotyczące rejestracji, wyboru formy, wysokości zaliczek, formy i treści deklaracji podejmuje **podatnik we własnym zakresie** (lub jego księgowy / doradca podatkowy). Stawki, progi i formularze zmieniają się rocznie (lub częściej — Polski Ład ma wiele nowelizacji). Przed jakimkolwiek złożeniem deklaracji — weryfikacja z aktualną treścią ustawy i wyjaśnieniami KAS.

Autorom pluginu i Anthropic nie przysługuje odpowiedzialność za skutki zastosowania wygenerowanych rekomendacji.

## Licencja

MIT — patrz [LICENSE](../../LICENSE) w katalogu głównym monorepo.
