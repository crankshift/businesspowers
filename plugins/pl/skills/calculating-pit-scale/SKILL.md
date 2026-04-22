---
name: calculating-pit-scale
description: Use when calculating Polish PIT on the progressive scale (skala podatkowa) — art. 27 ustawy o PIT. Two brackets: 12% up to 120 000 zł, 32% above. Tax-reducing amount 3 600 zł (implements 30 000 zł tax-free). Joint filing with spouse (art. 6) — doubles the threshold. Single-parent filing. Monthly advance payments calculated by cumulative method (zaliczka narastająco). Covers 2026 thresholds: kwota wolna 30 000 zł, ulga na dziecko (1 112,04 per child), PIT-0 dla rodziców 4+ (85 528 zł exemption), termomodernizacyjna. Ulga na dziecko only in PIT-36 (scale). No health insurance deduction under scale.
---

# calculating-pit-scale

Kalkulacja PIT wg skali podatkowej dla polskiego rezydenta — na JDG, z umowy o pracę, najmu (historycznie, od 2023 tylko ryczałt), innych źródeł.

## Kluczowe źródła

- **Ustawa o PIT** (Dz.U. 1991 nr 80 poz. 350):
  - Art. 27 — skala.
  - Art. 6 — wspólne rozliczenie z małżonkiem.
  - Art. 27f — ulga na dziecko.
  - Art. 27g — ulga PIT-0 dla rodziców 4+.
  - Art. 26 — odliczenia od dochodu.
  - Art. 27c — ulga na termomodernizację.

## Stawki (2026, potwierdzić w obwieszczeniu MF)

| Dochód roczny | Stawka |
|---|---|
| do 30 000 zł | **0%** (realizowane przez kwotę zmniejszającą) |
| 30 000 – 120 000 zł | **12%** |
| powyżej 120 000 zł | **32%** |

## Formuły

### Podstawowa

```
Dochód = Przychód − Koszty uzyskania − Odliczenia od dochodu

Jeśli Dochód ≤ 120 000 zł:
  Podatek = 12% × Dochód − 3 600
Jeśli Dochód > 120 000 zł:
  Podatek = 12% × 120 000 − 3 600 + 32% × (Dochód − 120 000)
         = 14 400 − 3 600 + 32% × (Dochód − 120 000)
         = 10 800 + 32% × (Dochód − 120 000)
```

### Kwota zmniejszająca (art. 27 ust. 1a)

**3 600 zł** — odpowiada 12% × 30 000 zł (kwota wolna).

Dla dochodu ≤ 30 000 zł — PIT = 12% × Dochód − 3 600, ale nie mniej niż 0:
- Dochód 10 000: 1 200 − 3 600 = negatywne → PIT = 0.
- Dochód 30 000: 3 600 − 3 600 = 0.
- Dochód 40 000: 4 800 − 3 600 = 1 200.

## Wspólne rozliczenie z małżonkiem (art. 6)

**Warunki:**
- Małżonkowie przez cały rok podatkowy.
- Wspólność majątkowa przez cały rok.
- Oboje na skali (nie liniowy, nie ryczałt dla JDG; dopuszcza ryczałt od najmu).
- Oświadczenie w PIT-36.

**Mechanizm:**

```
Wspólny_dochód = Dochód_A + Dochód_B
Podatek_łącznie = 2 × Podatek(Wspólny_dochód / 2)
```

### Kiedy wspólne jest korzystne

- Jeden z małżonków ma dochód 0 / bardzo niski.
- Drugi przekracza próg 120 000 (wchodzi w 32%).
- Dzięki wspólnemu — oboje w 12% progu.

### Przykład

**Sytuacja:**
- Mąż: dochód 200 000 zł (JDG na skali).
- Żona: dochód 30 000 zł (etat).

**Rozliczenie osobne:**
- Mąż: 12% × 120 000 − 3 600 + 32% × 80 000 = 10 800 + 25 600 = **36 400 zł**.
- Żona: 12% × 30 000 − 3 600 = 0 zł.
- **Razem: 36 400 zł**.

**Wspólne:**
- Suma: 230 000. Wspólny / 2 = 115 000.
- Podatek na osobę: 12% × 115 000 − 3 600 = 10 200 zł.
- × 2 = **20 400 zł**.

**Oszczędność:** 16 000 zł dzięki wspólnemu!

### Kiedy wspólne jest nieznaczące

- Oboje w podobnej grupie dochodowej i nie przekraczają 120 000.

### Ograniczenia

- Nie można wspólnie, gdy jeden z małżonków na liniowym lub ryczałcie z JDG.
- Nie można, gdy małżonek jest nierezydentem (z wyjątkami).

## Samotny rodzic (art. 6 ust. 4)

Podobna metoda do wspólnego z małżonkiem — dziecko jako "połowa" podatnika.

```
Podatek = 2 × Podatek(Dochód / 2)
```

Odliczenie: 1 500 zł dodatkowo (zmiana z 2022).

**Warunki:**
- Samotnie wychowujesz dziecko (bez drugiego rodzica).
- Dziecko do 18 lat, lub do 25 lat jeśli uczy się.

## Ulga na dziecko (art. 27f)

**Kwoty miesięczne:**

| Dziecko | Kwota mies. | Kwota roczna |
|---|---|---|
| 1. dziecko | 92,67 zł | **1 112,04 zł** |
| 2. dziecko | 92,67 zł | 1 112,04 zł |
| 3. dziecko | 166,67 zł | **2 000,04 zł** |
| 4. i kolejne dzieci | 225,00 zł | **2 700 zł** |

**Łącznie** dla rodziny z 3 dzieci: 1 112 + 1 112 + 2 000 = **4 224 zł**.

### Odliczenie

- **Od podatku**, nie dochodu.
- Jeśli podatek < ulga → zwrot w PIT nieraz nawet większy niż zapłacony.

### Warunki

- Dziecko do 18 lat, lub do 25 lat jeśli uczy się (art. 27f ust. 6).
- Dziecko nie osiągnęło dochodu ≥ 19 061 zł (2024; weryfikować 2026).

### Limit dochodowy rodziców (dla 1 dziecka)

- Rodzic samotny: dochód ≤ 112 000 zł.
- Małżonkowie: łączny dochód ≤ 112 000 zł.
- Dla **2+ dzieci** — **brak limitu dochodowego**.

## PIT-0 dla rodziców 4+ (art. 21 ust. 1 pkt 152)

**Od 2022 (Polski Ład):**

Rodzice co najmniej **4 dzieci** → zwolnienie z PIT **do 85 528 zł** rocznie.

**Warunki:**
- 4+ dzieci na utrzymaniu.
- Na skali (nie liniowy, nie ryczałt).

**Mechanizm:**
- Dochód do 85 528 zł → 0 PIT.
- Dochód 85 528 – 120 000 zł → 12% od nadwyżki.
- Dochód > 120 000 zł → 32% od nadwyżki > 120 000.

## Odliczenia od dochodu (art. 26)

### Składki ZUS zapłacone

- Pełne odliczenie.

### Składki zdrowotne

- **NIE odliczane na skali** (od 2022).

### Wpłaty na IKZE

- Do limitu rocznego (~8 322 zł 2024).

### Darowizny

- Do 6% dochodu.

### Ulga rehabilitacyjna

- Wydatki na sprzęt, leki, dojazdy.

### Ulga termomodernizacyjna (art. 26h)

- Do 53 000 zł w okresie 6 lat.

## Zaliczki miesięczne (narastająco, art. 44)

**Metoda narastająca:**

```
Zaliczka_miesiąc_N = 12% × Dochód_narastająco − 3 600 − Σ(Zaliczki_poprzednie) − 1/12 × Odliczenia
```

Po przekroczeniu 120 000 — stosujemy 32% od nadwyżki.

### Przykład

**JDG, skala, 2026:**

| Miesiąc | Dochód narastająco | Podatek narastająco (12% − 3600) | Zaliczka do zapłaty |
|---|---|---|---|
| Styczeń | 10 000 | 1 200 − 3 600 = max(0, -2 400) = 0 | 0 |
| Luty | 20 000 | 2 400 − 3 600 = 0 | 0 |
| Marzec | 30 000 | 3 600 − 3 600 = 0 | 0 |
| Kwiecień | 40 000 | 4 800 − 3 600 = 1 200 | 1 200 |
| Maj | 55 000 | 6 600 − 3 600 = 3 000 | 3 000 − 1 200 = 1 800 |
| ... | ... | ... | ... |
| Grudzień | 150 000 | 10 800 + 32% × 30 000 = 20 400 | — |

## Przykłady

### Przykład 1: Prosty dochód 100 000 zł

- Dochód: 100 000 zł.
- PIT: 12% × 100 000 − 3 600 = 8 400 zł.
- Efektywna stawka: 8,4%.

### Przykład 2: Dochód 200 000 zł (próg przekroczony)

- PIT: 10 800 + 32% × 80 000 = 10 800 + 25 600 = 36 400 zł.
- Efektywna stawka: 18,2%.

### Przykład 3: Wspólne + 3 dzieci

**Mąż:** dochód 150 000 zł.
**Żona:** dochód 30 000 zł.

**Wspólnie:**
- Suma: 180 000 → / 2 = 90 000.
- Na osobę: 12% × 90 000 − 3 600 = 7 200.
- × 2 = 14 400 zł.

**Ulga na 3 dzieci:** 4 224 zł.

**Końcowy PIT:** 14 400 − 4 224 = **10 176 zł**.

### Przykład 4: Rodzic 4+ (PIT-0)

**Samotny rodzic, 4 dzieci, dochód 80 000 zł.**

**PIT-0:** Dochód ≤ 85 528 → **PIT = 0**.

**Dochód 100 000 zł:**
- 0% × 85 528 = 0.
- 12% × (100 000 − 85 528) − kwota proporcjonalnie = 12% × 14 472 = 1 737 zł.
- Minus kwota zmniejszająca (proporcjonalnie): 3 600 × (14 472 / 30 000) = ~1 737.
- PIT ≈ 0 zł (lub minimalne).

Plus ulga na dziecko (4 dzieci): 1 112 × 2 + 2 000 + 2 700 = **6 924 zł**.

**Końcowy PIT:** 0 − 6 924 = ujemne → **zwrot 6 924 zł**.

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Odlicza składkę zdrowotną od dochodu | Błąd — nie ma prawa (od 2022) | Zdrowotna na skali nie jest odliczana |
| Wspólne rozliczenie na liniowym JDG | Wspólne zablokowane | Wspólne tylko gdy oboje na skali |
| Ulga na dziecko przy liniowym | Nie przysługuje | Ulga tylko na skali |
| Zapomina o kwocie zmniejszającej 3 600 | Nadpłata | W obliczeniu minus 3 600 |
| Myli próg (120k) z limitami ulg | Błąd | 120 000 zł to próg skali, nie limit ulg |

## Ograniczenia

- Skil dla 2026; kwoty weryfikować w obwieszczeniu MF na dany rok.
- Szczegółowe odliczenia (np. rehabilitacyjna dla różnych niepełnosprawności) — w konkretnej interpretacji.
- Rozliczenie z zagranicznymi dochodami — wymaga skillu `applying-umowa-o-unikaniu-podwojnego-opodatkowania`.
