---
name: declaring-pit-38
description: Use when filling out PIT-38 declaration form. Covers sections C (securities/derivatives), C1 (crypto), E (foreign dividends), loss carry-forward, broker data extraction, NBP currency conversion, filing workflow.
---

# declaring-pit-38

Skill — wypełnianie polskiej rocznej deklaracji podatku od zysków kapitałowych (PIT-38).

## Kluczowe źródła

- **Ustawa o PIT** (Dz.U. 1991 nr 80 poz. 350):
  - Art. 30b — 19% od kapitałów.
  - Art. 30a — dywidendy.
  - Art. 9 ust. 3 — przenoszenie strat.
- **Rozporządzenie MF** w sprawie wzoru PIT-38 — aktualny wzór na podatki.gov.pl.

## Parametry — odniesienie

> Aktualne wartości — pobierać przez kanoniczne skille.
> Jeśli skill nie odpowiedział, użyj fallback poniżej; ostrzeż: «⚠ Wartość [parametr] użyto ze stanem na [data].»

| Parametr | Kanoniczny skill | Fallback |
|---|---|---|
| Stawka 19% od kapitałów (art. 30b) | `calculating-pit-38` | 19% _(01.01.2026)_ |
| Stawka 19% od dywidend (art. 30a) | `calculating-pit-38` | 19% _(01.01.2026)_ |
| Limit przenoszenia strat (50%, 5 lat) | `calculating-pit-38` | 50% / 5 lat _(01.01.2026)_ |

## Termin

**30 kwietnia** roku następnego (dla rozliczenia 2025 → do 30.04.2026).

## Sekcje formularza PIT-38

### Sekcja A — dane podatnika

- Imię, nazwisko, PESEL / NIP.
- Adres.
- Urząd skarbowy właściwy.

### Sekcja B — okres (rok podatkowy)

### Sekcja C — przychody z odpłatnego zbycia (podstawa)

Dotyczy:
- Sprzedaż akcji.
- Sprzedaż ETF.
- Sprzedaż obligacji.
- Sprzedaż udziałów w spółkach.
- Instrumenty pochodne (opcje, kontrakty terminowe, CFD).

**Kluczowe pola:**

| Pole | Opis |
|---|---|
| **22. Przychód** | Suma kwot otrzymanych ze sprzedaży (brutto, w PLN) |
| **23. Koszty uzyskania przychodów** | Suma kwot za nabycie + prowizje (PLN) |
| **24. Dochód** (22 − 23) | Różnica |
| **25. Strata** (23 > 22) | Jeśli więcej wydano niż uzyskano |
| **26. Strata z lat ubiegłych** | Do 50% straty z każdego z ostatnich 5 lat |
| **27. Dochód po odliczeniach** | 24 − 26 |
| **29. Podatek (19%)** | 19% × 27 |

### Sekcja C1 — krypto (od 2019)

Osobna sekcja dla wirtualnych walut (art. 30b ust. 1 pkt 4).

- **32. Przychód z krypto** (PLN).
- **33. Koszty uzyskania krypto** (PLN).
- **34. Dochód krypto** (32 − 33).
- **35. Podatek 19%** od 34.

### Sekcja E — dywidendy zagraniczne

- **45. Przychód z zagranicznych dywidend** (brutto w PLN).
- **46. Podatek naliczony (19%)** = 45 × 19%.
- **47. Zaliczenie podatku u źródła** (w PLN).
- **48. PIT do zapłaty** = 46 − 47 (min. 0).

### Sekcja F — dywidendy bez poboru podatku w źródle

- Rzadka sytuacja (np. błąd płatnika).
- Wypełniać z własnej inicjatywy.

### Sekcja G — podsumowanie

- **54. Łączny podatek** (C + C1 + E + F).
- **55. Zaliczki wpłacone** (zwykle 0 — PIT-38 nie ma zaliczek).
- **56. Do zapłaty** = 54 − 55.
- **57. Nadpłata** (jeśli −).

## Proces wypełniania

### Krok 1. Zebrać dane

- **Raporty roczne** ze wszystkich brokerów.
- **Raporty crypto** (CSV z bierż).
- **Kursy NBP** dla każdej transakcji.

### Krok 2. Obliczyć FIFO

Dla identycznych papierów — pierwsze kupione → pierwsze sprzedane.

### Krok 3. Przeliczenie walut

**Art. 11a ust. 1:** kurs średni NBP z dnia roboczego **poprzedzającego** operację.

Skill: `converting-currency-nbp`.

### Krok 4. Obliczyć fin. wynik

Sekcja C (sprzedaż):
```
Wynik = Σ Przychodów − Σ Kosztów
```

Sekcja C1 (krypto):
```
Wynik = Σ Przychody krypto − Σ Koszty krypto
```

Sekcja E (dywidendy zagr.):
```
Wynik = Σ Dywidend brutto − Σ Podatku zagranicznego (do limitu 19%)
```

### Krok 5. Odliczyć straty z lat ubiegłych

Max 50% straty z pojedynczego roku.

### Krok 6. Obliczyć podatek

19% od dochodu netto (po odliczeniach).

### Krok 7. Wysłać do 30 kwietnia

Przez e-US z podpisem profilem zaufanym.

## Raporty brokerów

### Interactive Brokers (IBKR)

**Activity Statement** (PDF) — przegląd.

**Flex Query** (CSV/XML) — do celów podatkowych.

**Pola krytyczne:**
- Trade Date.
- Symbol.
- Buy/Sell.
- Quantity.
- Trade Price.
- Proceeds (przychód).
- Basis (koszt).
- Commission.
- Currency.

**Form 1042-S** — podatek u źródła US dla nierezydentów.

### XTB

**Raport dla celów PIT-38** (gotowy w panelu klienta).

- Przychody, koszty, prowizje.
- Przeliczenie na PLN wg kursu NBP.
- Uwaga: weryfikować — czasem XTB traktuje dywidendy z CFD jako inne świadczenia.

### eToro

**Raport roczny** z sekcją sprzedaży i dywidend.

- "Copy trading" generuje wiele drobnych transakcji.
- Można złożyć prośbę o uproszczony raport CSV.

### Freedom24

**Broker Statement** (CSV).

- Może mieć gotowy "raport dla PIT-38" — **weryfikować kursy NBP**.

### Revolut Stocks / Wise Assets / Trading212

- Raporty roczne w panelu.
- Może wymagać eksportu CSV i własnej kalkulacji.

### Polscy brokerzy (Bossa, mBrokers, XTB, DM BOŚ, CDM Pekao)

- Często **są płatnikami** — pobierają 19% od dywidend krajowych (art. 41 ust. 4).
- Klient otrzymuje **PIT-8C** — informację o dochodach z kapitałów.
- W PIT-38 wprowadzasz dane z PIT-8C.

## Dywidendy — szczegóły

### Krajowe

- 19% pobierane przez spółkę (płatnik).
- **Nie wpisujesz w PIT-38** (chyba że błąd płatnika).

### Zagraniczne (art. 30a ust. 9)

**Zaliczenie** podatku u źródła do **max 19%**.

### Stawki u źródła (wybrane)

| Kraj | Dywidendy | Odsetki |
|---|---|---|
| USA (z W-8BEN) | 15% | 0% |
| Niemcy | 15% | — |
| UK | 10% | — |
| Irlandia (UCITS) | 15% (nominalnie, praktycznie 0% dla ETF) | — |
| Holandia | 15% | — |
| Austria | 15% | — |

### Przykład — $500 dywidend Apple

- Brutto: $500 × 4,05 = **2 025 PLN**.
- Podatek USA 15% (W-8BEN): $75 × 4,05 = **303,75 PLN**.
- PIT PL 19%: 2 025 × 19% = **384,75 PLN**.
- Zaliczenie: min(384,75; 303,75) = **303,75**.
- Do zapłaty w PL: 384,75 − 303,75 = **81 PLN**.

## Przenoszenie strat

**Art. 9 ust. 3:** strata z lat poprzednich przenoszona do **5 kolejnych lat**; max **50%** z danego roku.

### Tabela strat do przeniesienia

Warto prowadzić rejestr:

| Rok straty | Kwota straty | Wykorzystano 2024 | 2025 | 2026 | 2027 | Pozostało |
|---|---|---|---|---|---|---|
| 2022 | 100 000 | 30 000 | 40 000 | — | — | 30 000 (do 2027) |
| 2023 | 50 000 | — | 25 000 | — | — | 25 000 (do 2028) |

## Przykłady kompletne

### Przykład 1: Spokojny inwestor

**2025:**
- Sprzedaż AAPL z zyskiem: $2 000 → 8 000 PLN.
- Sprzedaż MSFT z stratą: −$500 → −2 000 PLN.
- Dywidendy AAPL: $200 × 4,05 = 810 PLN, US potrąciło $30 × 4,05 = 121,50 PLN.

**PIT-38:**

Sekcja C:
- Poz. 22 (przychody): 10 500 PLN (sum sprzedaży brutto).
- Poz. 23 (koszty): 4 500 PLN (sum kosztów nabycia).
- Poz. 24 (dochód): 6 000.
- Poz. 26 (strata z lat): 0.
- Poz. 27: 6 000.
- Poz. 29 (podatek): 19% × 6 000 = **1 140 PLN**.

Sekcja E:
- Poz. 45: 810.
- Poz. 46: 153,90.
- Poz. 47: 121,50.
- Poz. 48: 32,40.

**Razem podatek: 1 140 + 32 = 1 172 PLN.**

### Przykład 2: Day-trader ze stratą 2024

**2024:** strata 80 000 PLN.

**2025:** zysk 60 000 PLN.

**PIT-38 2025:**
- Poz. 24: 60 000.
- Poz. 26 (odliczenie 50% × 80 000 = 40 000): 40 000.
- Poz. 27: 20 000.
- Poz. 29: 3 800 PLN.

**Pozostało straty 2024 do wykorzystania 2026-2029: 40 000 PLN.**

### Przykład 3: Crypto-trader

**2025:**
- Wiele transakcji BTC/USDT.
- Koinly wygenerował raport: zysk netto 50 000 PLN.

**PIT-38 C1:**
- Poz. 34 (dochód krypto): 50 000.
- Poz. 35 (podatek): **9 500 PLN**.

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Brak W-8BEN → 30% USA | 11% bezzwrotne | Podpisać W-8BEN |
| Kurs NBP z dnia operacji | Błąd | Z dnia roboczego **poprzedzającego** |
| Nie deklarujesz crypto/crypto | Niedopłata | Każda wymiana = zdarzenie |
| Strata od dywidend w sekcji C | Źle | Dywidendy w sekcji E, nie mogą mieć "straty" |
| Nie składasz PIT-38 ze stratą | Tracisz możliwość przeniesienia | Składać zawsze |
| Mylisz dywidendy krajowe z zagranicznymi | Podwójny podatek | Krajowe z 19% już pobranym — nie do PIT-38 |

## Ograniczenia

- Dla setek transakcji — **Koinly** (crypto), **Excel z makro** lub **specjalistyczne narzędzie** (np. kalkulatorPIT-38).
- Instrumenty pochodne (CFD, forex) — wymagają szczególnej analizy.
- Fundusze inwestycyjne polskie (TFI) — rozliczane przez TFI jako płatnika, **nie** w PIT-38.
- IP BOX, ulga IP — nie dotyczy PIT-38.
