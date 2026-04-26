---
name: calculating-pit-38
description: Use when calculating Polish capital gains tax on PIT-38. Covers securities, derivatives, crypto, foreign dividends, FIFO matching, loss carry-forward, NBP currency conversion, annual settlement.
---

# calculating-pit-38

Kalkulacja podatku od zysków kapitałowych (PIT-38) dla polskich rezydentów osób fizycznych.

## Kluczowe źródła

- **Ustawa o PIT** (Dz.U. 1991 nr 80 poz. 350):
  - Art. 30b — stawka 19%.
  - Art. 30a — dywidendy.
  - Art. 9 ust. 3 — przeniesienie strat przez 5 lat.
  - Art. 11a — kurs NBP.
  - Art. 24a — krypto.

## Stawka

**19%** od dochodu (proste).

## Formuła

### Dochód ze sprzedaży papierów wartościowych

```
Dochód = Przychód_ze_sprzedaży − (Koszt_nabycia + Prowizje + Koszty_transakcyjne)
Podatek = 19% × Dochód
```

### Dywidendy zagraniczne

```
PIT_PL = 19% × Dywidenda_brutto_PLN
Zaliczenie = min(PIT_PL, Podatek_u_źródła_PLN)
PIT_do_zapłaty = PIT_PL − Zaliczenie
```

### Krypto (od 2019, art. 30b ust. 1 pkt 4)

```
Dochód_krypto = Σ(Przychód z każdej transakcji) − Σ(Koszt nabycia)
Podatek_krypto = 19% × Dochód_krypto
```

(Każda wymiana crypto/crypto to sprzedaż + kupno!)

## Sumowanie strat i zysków w PIT-38

Wewnątrz roku **sumujemy wszystkie transakcje** — zyskowne i stratne.

```
Roczny_wynik = Σ(Dochód z każdej transakcji) − Σ(Strata z każdej transakcji)
```

### Wynik < 0

- Strata roczna → brak podatku.
- Strata **przenoszona na kolejne 5 lat** (art. 9 ust. 3).

### Wynik > 0

- Podatek 19% × wynik.

## Przenoszenie strat (art. 9 ust. 3)

**Reguły:**
1. Strata przenoszona do **5 kolejnych lat**.
2. W jednym roku można odliczyć max **50%** straty z danego roku.

### Przykład

**2022 strata 100 000 zł.**

**2023: zysk 30 000.**
- Odliczenie: max 50% × 100 000 = 50 000.
- Ale zysk 30 000 < 50 000 → odliczenie 30 000 (do zera).
- Pozostało straty 2022: 70 000 zł.

**2024: zysk 80 000.**
- Odliczenie: max 50% × 100 000 = 50 000.
- Dochód po odliczeniu: 80 000 − 50 000 = 30 000.
- Podatek 19%: 5 700 zł.
- Pozostało straty 2022: 20 000 zł (do wykorzystania w 2025-2027).

**2025: zysk 0.**
- Nie wykorzystano.

**2026: zysk 30 000.**
- Dostępne: 20 000 (z 2022).
- Odliczenie: 20 000.
- Dochód po odliczeniu: 10 000.
- Podatek 19%: 1 900 zł.

**2027: strata 2022 — przedawnienie.**

## FIFO dla identycznych papierów

**Przy wielu zakupach tych samych akcji** — pierwsze kupione jako pierwsze sprzedane.

### Przykład Apple przez IBKR

**Transakcje:**
- 10.01.2025: kupno 10 × AAPL @ $180 = $1 800. Kurs NBP 9.01 = 4,00 → **7 200 PLN**.
- 15.06.2025: kupno 10 × AAPL @ $200 = $2 000. Kurs NBP 14.06 = 4,05 → **8 100 PLN**.
- 20.09.2025: sprzedaż 8 × AAPL @ $220 = $1 760. Kurs NBP 19.09 = 4,10 → **7 216 PLN**.

**FIFO:** sprzedane 8 akcji — z pierwszej transzy (10 × AAPL @ $180).
- Koszt nabycia: 8 / 10 × 7 200 = **5 760 PLN**.
- Przychód: 7 216 PLN.
- Dochód: 7 216 − 5 760 = **1 456 PLN**.

**Pozostały stan:**
- 2 × AAPL z pierwszej transzy (koszt 1 440 PLN).
- 10 × AAPL z drugiej transzy (koszt 8 100 PLN).
- Łącznie 12 × AAPL, koszt 9 540 PLN.

## Dywidendy zagraniczne — zaliczenie podatku

**Wzór (art. 30a ust. 9):**

```
PIT_PL = 19% × Dywidenda_brutto_PLN
Zaliczenie = min(PIT_PL, Podatek_u_źródła_w_PLN)
PIT_do_zapłaty = max(0, PIT_PL − Zaliczenie)
```

### Kluczowe: zaliczenie **max 19%** (nie pełne 30% jeśli zapłacono za dużo w kraju źródła).

### Przykład — Apple dywidendy $120

- Dywidenda brutto: $120.
- Podatek USA (z W-8BEN 15%): $18.
- Kurs NBP dnia przed wypłatą (14.05.2025 czw): **4,00**.
- Brutto PLN: $120 × 4,00 = **480 PLN**.
- Podatek USA w PLN: $18 × 4,00 = **72 PLN**.
- PIT PL 19%: 480 × 19% = **91,20 PLN**.
- Zaliczenie: min(91,20, 72) = **72 PLN**.
- PIT do zapłaty: 91,20 − 72 = **19,20 PLN** (zaokrąglane do 19).

### Przykład — brak W-8BEN (USA potrąciło 30%)

- Brutto $120, podatek USA $36 (30%).
- Brutto PLN: 480.
- Podatek USA: $36 × 4 = 144 PLN.
- PIT PL 19%: 91,20.
- Zaliczenie: min(91,20, 144) = 91,20.
- PIT do zapłaty: 0.
- **Ale:** 91,20 − 144 = -52,80 PLN — **nie zwraca się**! "Przekroczona" kwota 52,80 jest **stratą bezzwrotną**.

## Kursy NBP

### Zasada (art. 11a ust. 1)

- **Kurs średni NBP z dnia roboczego poprzedzającego** operację.
- Operacja dla dochodu: dzień wpływu środków lub data transakcji (trade date).
- Operacja dla kosztu: dzień poniesienia wydatku (data transakcji zakupu).

### Źródło

[nbp.pl/kursy](https://www.nbp.pl/kursy/kursya.html) — tabela A (średnie).

### API NBP (bez klucza)

```
https://api.nbp.pl/api/exchangerates/rates/a/USD/2025-05-14/?format=json
```

Zwraca kurs na konkretny dzień.

Jeśli na zadany dzień brak tabeli (święto) — API zwraca 404; użyj ostatniego dnia roboczego poprzedzającego.

## Krypto — specyfika

### Art. 30b ust. 1 pkt 4 (od 01.01.2019)

- Dochód z odpłatnego zbycia waluty wirtualnej.
- 19% od dochodu.

### Zasady

- **Każda wymiana = zdarzenie podatkowe.**
- FIFO obowiązkowa.
- Stakowanie, mining — przychód z momentu otrzymania (art. 10 ust. 1 pkt 9).

### Przykład crypto → crypto

- 01.03.2025: kupiłem 1 BTC za $60 000. Kurs NBP 4,00 → 240 000 PLN.
- 15.09.2025: wymieniłem 1 BTC na 0,05 BTC (marketplace). Kurs NBP 3,95. 1 BTC rynkowo = $70 000.
  - **Przychód ze sprzedaży BTC**: $70 000 × 3,95 = **276 500 PLN**.
  - **Dochód na BTC**: 276 500 − 240 000 = 36 500 PLN.
  - **Koszt nabycia nowego papieru** (0,05 BTC na ETH — zmiana hipotetyczna): 276 500 PLN.

## PIT-38 — wypełnianie

### Sekcja C (sprzedaż papierów wartościowych)

- Poz. 22 — przychody.
- Poz. 23 — koszty uzyskania.
- Poz. 24 — dochód (22 − 23).
- Poz. 25 — strata z lat ubiegłych (do odliczenia).
- Poz. 26 — dochód po odliczeniach.
- Poz. 27 — podatek (19% × 26).

### Sekcja C1 (krypto)

- Osobna sekcja od 2019.
- Przychody, koszty, dochód krypto.

### Sekcja E (dywidendy zagraniczne)

- Poz. 45 — przychody z dywidend zagranicznych (PLN).
- Poz. 46 — podatek 19% naliczony.
- Poz. 47 — zaliczenie podatku u źródła.
- Poz. 48 — PIT do zapłaty.

### Sekcja F (dywidendy inne — polskie, od akcji niepublicznych)

- Rzadko; zwykle rozliczone przez płatnika.

## Termin

**30 kwietnia** kolejnego roku.

**Brak zaliczek miesięcznych** dla PIT-38 — tylko roczne rozliczenie.

## Przykłady

### Przykład 1: Prosty inwestor

**2025:**
- AAPL: zysk $2 000 × kurs 4 → 8 000 PLN.
- MSFT: strata $500 × 4 = −2 000 PLN.
- TSLA: zysk $1 000 × 4 = 4 000 PLN.
- Dywidendy AAPL: $150 × 4,05 = 607,50 PLN, pot. USA 15% = $22,50 × 4,05 = 91,13 PLN.

**PIT-38:**

Sekcja C:
- Poz. 22: 12 000 PLN (suma przychodów po sprzedaży).
- Poz. 23: 2 000 PLN (strata, ale nie — poz. 23 = koszty!).

Inaczej: przeliczamy ponownie.
- Wszystkie transakcje: zyski 8 000 + 4 000 = 12 000 PLN. Strata 2 000.
- Wynik netto: 12 000 − 2 000 = 10 000 PLN.
- Podatek: 19% × 10 000 = **1 900 PLN**.

Sekcja E (dywidendy):
- Poz. 45: 607,50.
- Poz. 46: 115,43.
- Poz. 47: 91,13.
- Poz. 48: 24,30.

**Razem PIT-38:** 1 900 + 24,30 = **1 924,30 PLN**.

### Przykład 2: Day-trader z stratą

**2024:**
- Roczna strata: 200 000 PLN (kilka złych pozycji).

**2025:**
- Roczny zysk: 150 000 PLN.

**2025 PIT-38:**
- Dochód: 150 000.
- Odliczenie straty 2024: min(50% × 200 000, 150 000) = 100 000.
- Dochód po odliczeniu: 50 000.
- Podatek: 19% × 50 000 = **9 500 PLN**.
- Pozostało straty 2024: 100 000 (do 2029).

### Przykład 3: Crypto

**2025:**
- Kupno 2 BTC za 460 000 PLN łącznie.
- Sprzedaż 1 BTC za 300 000 PLN.
- Wymiana 1 BTC na 20 ETH (wartość BTC w momencie wymiany: 290 000 PLN).

**Operacja 1: sprzedaż 1 BTC.**
- Przychód: 300 000.
- Koszt (FIFO — pierwszy BTC): 230 000.
- Dochód: 70 000.

**Operacja 2: wymiana 1 BTC na 20 ETH.**
- Przychód z BTC: 290 000.
- Koszt (drugi BTC): 230 000.
- Dochód: 60 000.
- Nabycie 20 ETH: koszt 290 000.

**Razem zysk krypto 2025:** 130 000 PLN.
**Podatek:** 19% × 130 000 = **24 700 PLN**.

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Brak W-8BEN → USA 30% | 11% straconych | Podpisać W-8BEN |
| Kurs NBP z dnia operacji | Błędny wynik | Z dnia roboczego **poprzedzającego** |
| Nie rozliczenie crypto→crypto | Niedopłata + odsetki | Każda wymiana = zdarzenie |
| Odliczenie całej straty w jednym roku | Korekta US | Max 50% z jednego roku |
| Dywidendy UK pod stawką UK 10%, zaliczenie 19% | Wymaga korekty | Zaliczenie max = podatek u źródła |
| Nie składa PIT-38 bo "nic nie zyskał" | Kara | Nawet z zerem/stratą — składać, by przenosić stratę |

## Ograniczenia

- Opcje, kontrakty terminowe — specjalne zasady.
- Fundusze inwestycyjne (TFI) polskie — rozliczane przez TFI jako płatnika.
- Sprzedaż udziałów w spółkach — PIT-38 (nie PIT-36).
- IP BOX — nie dotyczy PIT-38 (to dla JDG).
