# businesspowers / pl

Przestrzeń robocza do obsługi Jednoosobowej Działalności Gospodarczej (JDG) oraz spraw podatkowych osoby fizycznej w Polsce. Plugin zawiera wyspecjalizowanych subagentów pod konkretne zadania i skille do kalkulacji, wyboru form, sprawozdawczości oraz odniesień do pierwotnych źródeł.

Plugin `pl` wchodzi w skład monorepo `businesspowers` (`crankshift/businesspowers`). Komendy w Claude Code otrzymują prefiks `/pl:…` (np. `/pl:jdg-registrator`). Równolegle w tym samym marketplace istnieje plugin `ua` (Ukraina, ФОП), z którym plugin `pl` się nie krzyżuje.

## Język komunikacji

- Język podstawowy — **polski**. Wszyscy agenci, skille, szablony i deklaracje formułowane są po polsku.
- Terminologia podatkowa — zgodna z ustawą o PIT, VAT, ryczałcie, o systemie ubezpieczeń społecznych, Ordynacją podatkową.
- Daty cytowań aktów prawnych — wskazywać wyraźnie. Redakcja z konkretnego dnia ma znaczenie, bo stawki i progi zmieniają się corocznie (szczególnie składka zdrowotna w Polskim Ładzie).

## Architektura agentów

Agenci znajdują się w `agents/*.md`. Podzieleni na **blok JDG** (cykl życia działalności) oraz **blok osoba fizyczna** (deklarowanie dochodów poza działalnością — inwestycje, dywidendy, crypto, spadki, darowizny).

### Blok JDG — cykl życia

1. **`jdg-registrator`** — otwarcie JDG.
   - Kanały: CEIDG online (biznes.gov.pl), urząd gminy (papierowo).
   - Wniosek CEIDG-1: imię, nazwisko, PESEL, NIP, adres, PKD, forma opodatkowania, ZUS, VAT.
   - Wybór formy opodatkowania — w momencie rejestracji lub do 20 lutego kolejnego roku.
   - Zgłoszenie do ZUS (ZUS ZUA — z chorobowym; ZUS ZZA — tylko zdrowotna na Uldze na start).
   - VAT-R (jeśli ponad 200 000 zł rocznie lub dobrowolnie).
   - Rachunek firmowy i zgłoszenie do białej listy.

2. **`tax-form-advisor`** — wybór formy opodatkowania.
   - **Skala**: 12% do 120 000 zł, 32% powyżej. Kwota wolna 30 000 zł. Pełne koszty, wspólne z małżonkiem, ulgi (na dziecko, termomodernizacyjna, rehabilitacyjna).
   - **Liniowy 19%** (art. 30c ustawy o PIT). Brak kwoty wolnej, brak wspólnego rozliczenia, ograniczone ulgi. Składka zdrowotna 4,9% (mniej niż 9% na skali).
   - **Ryczałt** (ustawa o ryczałcie). 2% – 17% w zależności od PKD. **Bez kosztów**. Odliczenie 50% zapłaconej składki zdrowotnej.
   - **Karta podatkowa** — wygaszana od 2022; tylko dla osób, które były na karcie w 2021.

3. **`jdg-tax-calculator`** — kalkulacja podatków.
   - PIT (skala / liniowy / ryczałt).
   - ZUS społeczny (emerytalna 19,52%, rentowa 8%, chorobowa 2,45% dobrowolna, wypadkowa ~1,67%, FP 2,45%).
   - Składka zdrowotna (9% skala; 4,9% liniowy; zryczałtowana ryczałt).
   - VAT 23% / 8% / 5% / 0%.
   - Zaliczki miesięczne vs kwartalne.

4. **`jdg-reporting-agent`** — sprawozdawczość.
   - **JPK_V7M/K** — deklaracja VAT (do 25-go następnego miesiąca).
   - **Zaliczki PIT** — do 20-go następnego miesiąca (miesięczne) lub do 20-go po kwartale (kwartalne).
   - **PIT-36** (skala) / **PIT-36L** (liniowy) / **PIT-28** (ryczałt) — roczne, do 30 kwietnia.
   - **PIT-11** — dla pracowników, do 31 stycznia.
   - **ZUS DRA** — do 10-go / 15-go / 20-go w zależności od statusu.
   - **KSeF** — obowiązkowy od 2026 dla większości podatników (weryfikować wdrożenie).

5. **`jdg-closer`** — zamknięcie JDG.
   - Wniosek CEIDG-1 o wykreślenie.
   - VAT-Z — wyrejestrowanie z VAT.
   - ZUS ZWUA — wyrejestrowanie.
   - Ostatnie JPK, PIT, rozliczenie składki zdrowotnej.
   - Remanent likwidacyjny (dla skali i liniowego).

### Blok osoba fizyczna

6. **`osoba-fizyczna-tax-advisor`** — ogólne podatki osoby fizycznej.
   - **PIT-37** (pracownicy), **PIT-36** (dodatkowo przychody z działalności), **PIT-38** (kapitały), **PIT-39** (nieruchomości).
   - Podatek od spadków i darowizn (ustawa z 28.07.1983) — grupa I (0% do limitu 36 120 zł); II 7%, III 12%, IV 20%.
   - Sprzedaż nieruchomości (PIT-39): 19% od dochodu; zwolnienie przy zakupie nowej nieruchomości (art. 21 ust. 1 pkt 131).
   - Najem prywatny (opodatkowany ryczałtem od 2023 — 8,5% do 100 000 zł, 12,5% powyżej).

7. **`kapitalowe-investments-agent`** — inwestycje kapitałowe (PIT-38).
   - Art. 30b ustawy o PIT — 19% od dochodu z odpłatnego zbycia papierów wartościowych.
   - Dywidendy krajowe — 19% pobierane przez płatnika (nie w PIT-38).
   - Dywidendy zagraniczne — 19% minus zaliczony podatek zagraniczny.
   - Krypto — PIT-38 od 2019 (odrębna sekcja).
   - Straty przenoszone przez **5 lat** (art. 9 ust. 3).
   - W-8BEN dla US brokerów (IBKR, Freedom24, Wise Stocks).

8. **`zus-agent`** — obsługa ZUS.
   - **Ulga na start** — 6 miesięcy bez ZUS społecznego (tylko zdrowotna).
   - **Mały ZUS** (preferencyjny) — 24 miesiące; podstawa 30% minimalnego wynagrodzenia.
   - **Mały ZUS Plus** — dla przychodów do 120 000 zł; podstawa zależna od dochodu za poprzedni rok.
   - **Zwykły (Duży) ZUS** — 60% prognozowanego przeciętnego wynagrodzenia.
   - Chorobowa — **dobrowolna** 2,45%; daje prawo do zasiłku.

9. **`vat-agent`** — VAT.
   - Rejestracja VAT-R.
   - Zwolnienie podmiotowe (do 200 000 zł) / przedmiotowe.
   - JPK_V7M/K.
   - WDT/WNT (transakcje wewnątrzwspólnotowe).
   - Split payment (MPP) — obligatoryjny dla wybranych transakcji.
   - Biała lista VAT — weryfikacja kontrahentów.

## Kluczowe zasoby

| Zasób | URL | Zastosowanie |
|---|---|---|
| Ustawa o PIT | [isap.sejm.gov.pl](https://isap.sejm.gov.pl/isap.nsf/DocDetails.xsp?id=WDU19910800350) | Źródło pierwotne |
| Ustawa o VAT | [isap.sejm.gov.pl](https://isap.sejm.gov.pl/isap.nsf/DocDetails.xsp?id=WDU20040540535) | Źródło pierwotne |
| Ustawa o ryczałcie | [isap.sejm.gov.pl](https://isap.sejm.gov.pl/isap.nsf/DocDetails.xsp?id=WDU19981440930) | Źródło pierwotne |
| Ministerstwo Finansów | [podatki.gov.pl](https://www.podatki.gov.pl) | Stawki, formularze, e-US |
| KIS / interpretacje | [eureka.mf.gov.pl](https://eureka.mf.gov.pl) | Interpretacje indywidualne |
| CEIDG | [biznes.gov.pl/pl/firma/ceidg](https://www.biznes.gov.pl/pl/firma/ceidg) | Rejestracja JDG |
| ZUS | [zus.pl](https://www.zus.pl) | Składki, e-PUE, kalkulatory |
| NBP kursy | [nbp.pl/kursy](https://www.nbp.pl/kursy) | Kurs średni NBP |
| Biała lista VAT | [podatki.gov.pl/wykaz-podatnikow-vat-wyszukiwarka/](https://www.podatki.gov.pl/wykaz-podatnikow-vat-wyszukiwarka/) | Weryfikacja VAT |
| KSeF | [ksef.mf.gov.pl](https://ksef.mf.gov.pl) | Krajowy System e-Faktur |

## Zasady pracy

- **Weryfikuj stawki przy każdej kalkulacji.** Minimalne wynagrodzenie, prognozowane przeciętne wynagrodzenie, progi skali — zmieniają się corocznie. Weryfikować w obwieszczeniach MF i ustawie budżetowej na dany rok.
- **Polski Ład — liczne nowelizacje.** Od 2022:
  - **Polski Ład 1.0** (01.01.2022): 12% stawka PIT na skali, kwota wolna 30 000, ulga dla klasy średniej (potem uchylona), składka zdrowotna 9%/4,9%/zryczałtowana, brak odliczenia od podatku.
  - **Polski Ład 2.0** (01.07.2022): uchylenie ulgi dla klasy średniej; obniżenie stawki z 17% na 12% w skali; wspólne rozliczenie z samotnym rodzicem przywrócone.
  - **2023**: częściowe odliczenie składki zdrowotnej dla liniowego i ryczałtu.
  - **2024-2026**: dalsze korekty (weryfikować aktualny stan).
- **Dosłowność cytatów aktów prawnych.** Art. 30c, art. 30b, art. 21 ust. 1 ustawy o PIT — zawsze w redakcji z konkretnej daty.
- **Odniesienia obowiązkowe.** Do źródła pierwotnego (isap.sejm.gov.pl), do wyjaśnień MF (podatki.gov.pl), do interpretacji KIS (eureka.mf.gov.pl).
- **Nie wymyślać interpretacji.** Interpretacje indywidualne (IPI) KIS mają numer i datę; jeśli nie uda się znaleźć — nie odnosić się.
- **Dane osobowe.** Szablony — placeholdery (`[imię i nazwisko]`, `[PESEL]`, `[NIP]`, `[REGON]`, `[adres]`, `[numer konta]`).

## Agenci

Wąsko wyspecjalizowani subagenci w `agents/` (w katalogu głównym pluginu):

| Agent | Zastosowanie |
|---|---|
| `jdg-registrator` | Rejestracja JDG przez CEIDG; wybór PKD; zgłoszenie ZUS; VAT-R; KSeF |
| `tax-form-advisor` | Skala vs liniowy vs ryczałt vs karta; rekomendacja z uzasadnieniem |
| `jdg-tax-calculator` | Kalkulacja PIT / ZUS / składki zdrowotnej / VAT; zaliczki miesięczne / kwartalne |
| `jdg-reporting-agent` | Kalendarz sprawozdawczości; JPK_V7; PIT-36/36L/28; PIT-11; ZUS DRA |
| `jdg-closer` | Zamknięcie JDG; wyrejestrowanie VAT / ZUS; ostatnie deklaracje; remanent |
| `osoba-fizyczna-tax-advisor` | PIT-37 / PIT-39; spadki i darowizny; najem prywatny; sprzedaż majątku |
| `kapitalowe-investments-agent` | PIT-38; IBKR / Freedom24 / Wise / XTB; dywidendy; krypto; umowy o unikaniu podwójnego opodatkowania |
| `zus-agent` | Ulga na start / Mały ZUS / Mały ZUS Plus / Duży ZUS; chorobowa; zdrowotna |
| `vat-agent` | Rejestracja VAT; JPK_V7; WDT/WNT; MPP; biała lista; KSeF |
| `invoice-manager` | Wystawianie faktur VAT / rachunków / faktur walutowych (WDT, eksportowych), KSeF od 2026, faktury korygujące, MPP, GTU |
| `invoice-analyzer` | Rejestr faktur, aging, cash-flow, parsing wyciągów ING/mBank/Santander/Pekao/Millennium; uzgodnienie z JPK_V7; weryfikacja białej listy + VIES; odsetki i wezwania |

## Skille

Skille proceduralne / referencyjne w `skills/<name>/SKILL.md`:

| Skill | Zastosowanie |
|---|---|
| `calculating-pit-scale` | Skala 12%/32%; kwota wolna 30 000; kwota zmniejszająca; wspólne rozliczenie |
| `calculating-pit-liniowy` | Liniowy 19% art. 30c; odliczenie składki zdrowotnej do limitu rocznego |
| `calculating-ryczalt` | Ryczałt 2-17%; limity przychodów; odliczenie 50% składki zdrowotnej |
| `calculating-zus` | Składki społeczne; Ulga na start / Mały ZUS / Mały ZUS Plus; podstawa wymiaru |
| `calculating-skladka-zdrowotna` | 9% (skala) / 4,9% (liniowy) / zryczałtowana (ryczałt); minimum i roczne rozliczenie |
| `calculating-pit-38` | 19% od zysków kapitałowych; straty przenoszone 5 lat |
| `choosing-tax-form` | Drzewo decyzyjne; porównanie pod dochód, branżę, koszty, rodzinę |
| `pkd-codes-reference` | Kody PKD dla IT, konsultacje, handel, usługi; zakazane dla ryczałtu |
| `opening-jdg-checklist` | Lista otwarcia: CEIDG-1, PKD, ZUS, VAT-R, konto, KSeF |
| `closing-jdg-checklist` | Lista zamknięcia: CEIDG-1, VAT-Z, ZWUA, ostatnie deklaracje, remanent |
| `reporting-deadlines-pl` | Kalendarz JPK_V7 / PIT / ZUS / KSeF na rok |
| `filling-pit-36-liniowy` | Struktura PIT-36L; gdzie wprowadzić dane |
| `filling-jpk-v7` | JPK_V7M/K: sekcje, kody GTU, oznaczenia SW/EE/TP |
| `declaring-pit-38` | PIT-38: przychody, koszty, strata z lat ubiegłych, dywidendy |
| `declaring-crypto-pl` | Krypto w PIT-38 od 2019; FIFO; crypto→crypto i crypto→fiat |
| `converting-currency-nbp` | Kurs średni NBP z dnia roboczego poprzedzającego |
| `applying-umowa-o-unikaniu-podwojnego-opodatkowania` | Umowy z US, DE, UK, IE, NL; zaliczenie proporcjonalne |
| `fetching-podatki-gov-pl` | podatki.gov.pl, e-US, eureka interpretacje |
| `fetching-ceidg` | CEIDG rejestracja, zmiana, zawieszenie, wykreślenie |
| `issuing-invoice-pl` | Wzorce: faktura VAT, rachunek, faktura walutowa (WDT/eksport), uproszczona, zaliczkowa + końcowa; art. 106e, MPP, GTU |
| `parsing-ksef-xml` | FA_VAT v3 XML; parsing Podmiot1/2, Fa, FaWiersz; XSD walidacja; API KSeF |
| `faktura-korygujaca-workflow` | Korekty in minus / in plus / techniczne; rozliczenie JPK; czynny żal; liberalizacja art. 29a ust. 15 |
| `parsing-bank-statements-pl` | MT940 + CSV (ING, mBank, Santander, Pekao, Millennium, BNP, Nest); klasyfikacja; NBP konwersja |
| `reconciling-invoices-with-jpk-v7` | Uzgodnienie rejestru ↔ JPK_V7 (sprzedaż + zakupy); GTU / procedury; WDT vs VAT-UE; korekta JPK art. 81 |

## Struktura pluginu

```
plugins/pl/
├── CLAUDE.md
├── README.md
├── CHANGELOG.md
├── .claude-plugin/
│   └── plugin.json              # name: "pl", version: ...
├── agents/
│   ├── jdg-registrator.md
│   ├── tax-form-advisor.md
│   ├── jdg-tax-calculator.md
│   ├── jdg-reporting-agent.md
│   ├── jdg-closer.md
│   ├── osoba-fizyczna-tax-advisor.md
│   ├── kapitalowe-investments-agent.md
│   ├── zus-agent.md
│   ├── vat-agent.md
│   ├── invoice-manager.md
│   └── invoice-analyzer.md
└── skills/
    ├── calculating-pit-scale/SKILL.md
    ├── calculating-pit-liniowy/SKILL.md
    ├── calculating-ryczalt/SKILL.md
    ├── calculating-zus/SKILL.md
    ├── calculating-skladka-zdrowotna/SKILL.md
    ├── calculating-pit-38/SKILL.md
    ├── choosing-tax-form/SKILL.md
    ├── pkd-codes-reference/SKILL.md
    ├── opening-jdg-checklist/SKILL.md
    ├── closing-jdg-checklist/SKILL.md
    ├── reporting-deadlines-pl/SKILL.md
    ├── declaring-pit-38/SKILL.md
    ├── converting-currency-nbp/SKILL.md
    ├── applying-umowa-o-unikaniu-podwojnego-opodatkowania/SKILL.md
    ├── fetching-podatki-gov-pl/SKILL.md
    ├── fetching-ceidg/SKILL.md
    ├── issuing-invoice-pl/SKILL.md
    ├── parsing-ksef-xml/SKILL.md
    ├── faktura-korygujaca-workflow/SKILL.md
    ├── parsing-bank-statements-pl/SKILL.md
    └── reconciling-invoices-with-jpk-v7/SKILL.md
```

## Zasady nazewnictwa

- Pliki agentów/skillów — bez prefiksu (`jdg-registrator.md`, `skills/calculating-ryczalt/SKILL.md`). Prefiks `pl:` dodawany automatycznie z `name` w `plugin.json`.
- W dokumentacji — odwołania przez wywołanie (`pl:jdg-registrator`), aby użytkownik widział dokładną komendę.
