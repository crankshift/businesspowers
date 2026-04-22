---
name: calculating-skladka-zdrowotna
description: Use when calculating Polish health insurance contribution (składka zdrowotna) — reformed multiple times since Polski Ład 2022. Currently (2026, verify): for scale PIT = 9% of dochód, minimum 9% × minimum wage; for liniowy = 4.9% of dochód, minimum 9% × min wage, deductible up to annual limit (~10 200 zł 2026 verify); for ryczałt = flat amount in 3 brackets by annual revenue (≤60k: ~480 zł/mo, 60-300k: ~800 zł/mo, >300k: ~1440 zł/mo — orient. 2026). Annual reconciliation due 20 May (DRA) — true-up to actual yearly income. Health contribution was not deductible at all 2022-2022; partially restored for liniowy/ryczałt from 2023. Deductible only as a reduction of income under liniowy (up to limit) and ryczałt (50% paid deducted from revenue); NOT deductible under scale.
---

# calculating-skladka-zdrowotna

Składka zdrowotna dla JDG w Polsce. Najbardziej dynamicznie zmieniająca się składka: Polski Ład 2022 wprowadził obecne reguły, częściowo korygowane w 2023, 2024, 2025. Skill opisuje stan na 2026 (weryfikować aktualną redakcję ustawy).

## Kluczowe źródła

- **Ustawa o świadczeniach opieki zdrowotnej finansowanych ze środków publicznych** (Dz.U. 2004 nr 210 poz. 2135):
  - Art. 79-82 — podstawa, stopy, odliczenia.
- Nowelizacje Polskiego Ładu (2022, 2023, 2024) — weryfikować.
- Obwieszczenia MRiPS — minimalne wynagrodzenie, przeciętne wynagrodzenie.

## Ogólny mechanizm

**Składka zdrowotna:**
- Miesięczna — płatna razem z DRA.
- **Roczne rozliczenie** — w DRA majowej (do 20 maja).

**Podstawa zależy od formy opodatkowania JDG.**

## Dla skali PIT

### Stopa

**9%** dochodu miesięcznego.

### Minimum

**9% × minimalne wynagrodzenie.**

**2026 (MZ = 4 800 zł, orient.):** min. 432 zł/mies.

### Wzór miesięczny

```
Zdrowotna_mies = max(9% × Dochód_mies, 9% × MZ)
```

### Wzór roczny

```
Zdrowotna_roczna = max(9% × Dochód_roczny, 12 × 9% × MZ)
```

### Roczne rozliczenie (DRA maj)

```
Korekta = Zdrowotna_roczna_faktyczna − Σ(Zdrowotna_miesięczna)
```

- Dodatnia → dopłata.
- Ujemna → zwrot.

### Odliczenie od podatku

**Nie przysługuje** na skali! (od 2022 Polski Ład).

### Przykład

**Skala, dochód 100 000 zł rocznie:**
- Zdrowotna: 9% × 100 000 = **9 000 zł**.
- Miesięcznie: 750 zł.

## Dla liniowego PIT

### Stopa

**4,9%** dochodu.

### Minimum

**9% × minimalne wynagrodzenie** (jak dla skali).

**2026:** min. 432 zł/mies.

### Wzór

```
Zdrowotna_mies = max(4,9% × Dochód_mies, 9% × MZ)
```

### Odliczenie od podatku

**Do limitu rocznego.**

**Limit roczny 2026:** **~10 200 zł** (weryfikować obwieszczenie; w 2024 wynosił 10 200 zł; zwykle podnoszony o wskaźnik inflacji).

**Wzór odliczenia:**
```
Odliczenie = min(Zdrowotna_zapłacona_rocznie, Limit_roczny)
PIT_liniowy_netto = 19% × Dochód − Odliczenie
```

### Przykład

**Liniowy, dochód 300 000 zł rocznie:**
- Zdrowotna: 4,9% × 300 000 = **14 700 zł**.
- Miesięcznie: 1 225 zł.
- Odliczenie w PIT: min(14 700, 10 200) = **10 200 zł**.
- PIT: 19% × 300 000 − 10 200 = 57 000 − 10 200 = 46 800 zł.
- **Koszt zdrowotnej netto**: 14 700 − 10 200 = 4 500 zł.

## Dla ryczałtu

### Ryczałtowa (3 progi)

**2026 (orient., przeciętne wynagr. ~8 900 zł):**

| Roczny przychód | Podstawa | Miesięczna składka |
|---|---|---|
| ≤ 60 000 zł | 60% × przeciętnego wynagr. (5 335 zł) | ~480 zł |
| 60 000 – 300 000 zł | 100% × przeciętnego wynagr. (8 900 zł) | ~800 zł |
| > 300 000 zł | 180% × przeciętnego wynagr. (16 020 zł) | ~1 440 zł |

**Wzór:** miesięczna = 9% × podstawa.

### Dynamika w trakcie roku

- Pierwsze miesiące — według spodziewanego progu (wpisywane do DRA).
- Jeśli w trakcie roku przekroczysz próg → od kolejnego miesiąca **wyższa składka**.
- W DRA majowej — korekta za pierwsze miesiące.

### Przykład

**Ryczałt IT 12%, przychód zaczyna rok 10 000/mies, w lipcu przychód rośnie do 30 000/mies:**

- Styczeń-lipiec: szacunek < 60 000 → składka 480 zł/mies.
- Od sierpnia: skumulowane 7 × 10 000 + 30 000 = 100 000 > 60 000 → **od sierpnia** składka 800 zł.
- Koniec roku przychód: 70 000 + 30 000 × 5 = 220 000 → wchodzi w drugi próg.
- **Rozliczenie roczne (DRA maj):**
  - Faktyczna miesięczna (3 próg nie): 800 × 12 = **9 600 zł**.
  - Zapłacono: 7 × 480 + 5 × 800 = 3 360 + 4 000 = 7 360 zł.
  - **Dopłata: 9 600 − 7 360 = 2 240 zł.**

### Odliczenie na ryczałcie

**50% zapłaconej rocznej składki zdrowotnej** → odliczenie od przychodu.

**Wzór:**
```
Odliczenie = 50% × Składka_zapłacona_rocznie
Przychód_po_odliczeniu = Przychód − Odliczenie
Ryczałt = Stawka × Przychód_po_odliczeniu
```

### Przykład

**Ryczałt 12%, przychód 180 000 zł:**
- Zdrowotna roczna (próg 2): 12 × 800 = **9 600 zł**.
- Odliczenie (50%): 4 800 zł.
- Przychód po odl.: 175 200 zł.
- Ryczałt: 12% × 175 200 = **21 024 zł**.

## Dla karty podatkowej

**Karta wygaszana.** Tylko dla osób na karcie w 2021. Zdrowotna:
- **9% × podstawa = 9% × minimalne wynagrodzenie** (stała).
- Miesięcznie ~432 zł.

## Minimum miesięczne

**Zawsze** (niezależnie od formy): **9% × minimalne wynagrodzenie**.

**2026:** 9% × 4 800 = **432 zł/mies**.

Jeśli twój dochód za miesiąc jest niski (np. 1 000 zł) — i tak płacisz minimum 432 zł.

## Roczne rozliczenie

### Termin

**DRA za styczeń** (rozliczeniowa) — do **20 maja** kolejnego roku.

### Co zawiera

1. **Zadeklarowana składka** (suma 12 miesięcy).
2. **Faktyczna składka** (obliczona od rocznego dochodu / przychodu).
3. **Różnica**:
   - Dodatnia → dopłata do 20 maja.
   - Ujemna → nadpłata, ZUS zwraca automatycznie lub pozostaje na rachunku.

### Przykład rozliczenia (skala)

**Dochód roczny 2025:** 100 000 zł.
**Miesięczne składki 2025 płacone na bazie oczekiwanego dochodu 80k:**
- 9% × (80 000/12) = 600 zł/mies × 12 = 7 200 zł.

**Faktyczna roczna:**
- 9% × 100 000 = 9 000 zł.

**Dopłata:** 9 000 − 7 200 = **1 800 zł** do 20 maja 2026.

## Historia zmian (2022-2026)

**Dla kontekstu tylko** — nie mylić z aktualnymi stawkami.

- **Do 2021:** 9% × podstawa (ograniczona do ~3 900 zł); odliczenie od podatku (w PIT).
- **2022 (Polski Ład 1.0):** 9% × dochód na skali; 4,9% na liniowym; zryczałtowana na ryczałcie (3 progi); **zniknęło odliczenie od podatku**.
- **2023:** częściowe odliczenie dla liniowego (limit roczny) i ryczałtu (50%); nadal bez odliczenia na skali.
- **2024-2026:** kolejne korekty — limity podnoszone; reguły stabilne w ogólnym zarysie.

## Ile kosztuje zdrowotna w ciągu roku (orient. 2026)

### Skala

- Dochód 60k: 5 400 zł (750 zł × 7 mies × przybliżenie; uproszczenie 9% × 60 000 = 5 400). **Nieodliczalne.**
- Dochód 120k: 10 800 zł. Nieodliczalne.
- Dochód 300k: 27 000 zł. Nieodliczalne.

### Liniowy

- Dochód 60k: 2 940 (4,9% × 60 000). Odliczenie całe. Netto: ~0 (ponad limit, ale limit 10 200).
- Dochód 120k: 5 880. Odliczenie całe.
- Dochód 300k: 14 700. Odliczenie 10 200. Netto: 4 500.

### Ryczałt

- Przychód 60k: 5 760 (12 × 480). Odliczenie 50% = 2 880 od przychodu.
- Przychód 180k: 9 600 (12 × 800). Odliczenie 4 800.
- Przychód 400k: 17 280 (12 × 1 440). Odliczenie 8 640.

## Kiedy płacić wyższą podstawę na zdrowotnej

### Dobrowolna wyższa podstawa dla Dużego ZUS → wpływa na **emerytalna, rentowa** (nie zdrowotna).

Zdrowotna zawsze wg **dochodu / przychodu** (nie deklarowanej podstawy).

### Wyjątek: Mały ZUS Plus

- Dla MZP podstawa = 50% × dochód → wpływa na **społeczne**, ale zdrowotna nadal liczona osobno wg dochodu pełnego.

## Zdrowotna i wieloma źródłami

**Art. 82 ust. 4a ustawy o świadczeniach:** jeśli masz dwa źródła opodatkowania (np. etat + JDG):
- Zdrowotna z każdego tytułu **osobno**.
- **Minimum 9% × MZ** nie obowiązuje dla drugiego tytułu (tylko wg dochodu).

**Przykład:**
- Etat 8 000 zł → zdrowotna 9% × 8 000 = 720 zł.
- JDG liniowy, dochód mies 15 000 zł → 4,9% × 15 000 = 735 zł.
- **Razem: 1 455 zł/mies.**

## Roczne rozliczenie miesięczne vs roczne

**Ważne:** w ciągu roku płacisz "zaliczkę" na zdrowotną. Roczne rozliczenie dokonuje true-up.

**Baza miesięczna (skala / liniowy):**
- "Dochód poprzedniego miesiąca" — np. zdrowotna za marzec liczona od dochodu za luty.

(Uproszczone; w praktyce "dochód narastająco od początku roku" bywa używane w niektórych interpretacjach.)

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Odliczenie zdrowotnej od podatku na skali | US koryguje | Na skali — brak odliczenia |
| Odliczenie całej zdrowotnej na liniowym (powyżej limitu) | Korekta | Max 10 200 zł 2026 (weryfikować) |
| Odliczenie 100% zdrowotnej na ryczałcie | Korekta | Tylko 50% zapłaconej |
| Zapomnienie rozliczenia rocznego (DRA maj) | Utrata zwrotu nadpłaty | Do 20 maja |
| Przyjęcie pierwszego progu ryczałtu, gdy przekracza 60k | Niedopłata | Podnieść do 2 progu od miesiąca przekroczenia |
| Mylenie minimum 9% × MZ z 9% dochodu | Błąd | Zawsze max z dwu |
| Zdrowotna z JDG zapomniana przy etacie | Niedopłata | Każdy tytuł osobno |

## Przykłady kompletne

### Przykład 1: Skala, dochód 120 000 zł

- Miesięczna zdrowotna: 9% × (120 000/12) = 900 zł.
- Roczna: 10 800 zł.
- PIT: 12% × 120 000 − 3 600 = 10 800 zł.
- **Brak odliczenia** → płacisz oba w całości.

### Przykład 2: Liniowy, dochód 250 000 zł

- Miesięczna zdrowotna: 4,9% × (250 000/12) ≈ 1 021 zł.
- Roczna: 12 250 zł.
- PIT bez odliczenia: 19% × 250 000 = 47 500 zł.
- Odliczenie: min(12 250, 10 200) = 10 200 zł.
- PIT netto: 47 500 − 10 200 = 37 300 zł.
- Koszt zdrowotnej netto: 12 250 − 10 200 = 2 050 zł.

### Przykład 3: Ryczałt 12%, przychód 200 000 zł

- Zdrowotna roczna (próg 60-300k): 12 × 800 = 9 600 zł.
- Odliczenie (50%): 4 800 zł.
- Przychód po odliczeniu: 195 200 zł.
- Ryczałt: 12% × 195 200 = 23 424 zł.
- Razem (ryczałt + zdrowotna): 23 424 + 9 600 = **33 024 zł** (16,5% przychodu).

## Ograniczenia

- Wszystkie kwoty 2026 są **orientacyjne**; obwieszczenia MRiPS i KAS należy weryfikować.
- Dla osób z niepełnosprawnością — możliwe zwolnienia z minimum; specyficzne przypadki.
- Rolnicy — KRUS z innymi zasadami.
- Międzynarodowi przedsiębiorcy — zastosowanie zależy od rezydencji.
