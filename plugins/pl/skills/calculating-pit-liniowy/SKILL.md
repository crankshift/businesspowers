---
name: calculating-pit-liniowy
description: Use when calculating Polish PIT linear 19% for JDG — art. 30c ustawy o PIT. Flat 19% on dochód (przychód − koszty uzyskania). No tax-free amount (no kwota wolna 30 000 zł). No joint filing with spouse. No ulga na dziecko. Health insurance deductible up to annual limit (~10 200 zł in 2026, verify). Monthly advance payments calculated simply (19% × dochód narastająco − previous advances − proportional health deduction). Election timing: at CEIDG registration or by 20 February of the subsequent year. Advantage over scale when dochód exceeds ~156 000 zł and no family tax benefits needed. Cannot perform services to former employer for 2 years.
---

# calculating-pit-liniowy

Kalkulacja PIT liniowego 19% dla JDG w Polsce.

## Kluczowe źródła

- **Ustawa o PIT** (Dz.U. 1991 nr 80 poz. 350):
  - Art. 30c — stawka liniowa 19%.
  - Art. 9a — warunki wyboru.
  - Art. 26 — odliczenia od dochodu.
  - Art. 27b — odliczenie składki zdrowotnej.

## Stawka

**19%** od całego dochodu. **Brak progów.**

## Formuła

### Podstawowa

```
Dochód = Przychód − Koszty uzyskania
PIT = 19% × Dochód
```

### Z odliczeniem składki zdrowotnej

**Art. 30c ust. 2** (po korekcie Polskiego Ładu 2023):

```
Składka_zdrowotna_zaplacona = 4,9% × Dochód (min. 9% × min. wynagr.)
Limit_roczny_odliczenia_2026 = ~10 200 zł  (weryfikować obwieszczenie)
Odliczenie = min(Składka_zapłacona, Limit_roczny)

PIT_netto = 19% × Dochód − Odliczenie
```

**Limit roczny** od 2023 podwyższany rocznie o wskaźnik; 2026 — weryfikować.

## Odliczenia

### Dozwolone

- Składki ZUS społeczne (od dochodu).
- Składka zdrowotna — do limitu 10 200 zł rocznie (od podatku przez mechanizm "odliczenia" w art. 30c).
- IKZE — do 8 322 zł rocznie (2024; 2026 weryfikować).
- Darowizny (ograniczone).
- Ulga termomodernizacyjna (art. 26h) — do 53 000 zł.

### Zabronione

- Kwota wolna 30 000 zł — nie przysługuje.
- Ulga na dziecko — nie przysługuje.
- PIT-0 dla rodziców 4+ — nie przysługuje.
- Wspólne rozliczenie z małżonkiem — zablokowane.
- Rozliczenie samotnego rodzica — zablokowane.

## Zaliczki miesięczne

**Metoda uproszczona** (art. 44 ust. 3f):

```
Zaliczka_miesiąc_N = 19% × Dochód_narastająco − Odliczenie_proporcjonalne − Zaliczki_poprzednie
```

**Odliczenie proporcjonalne składki zdrowotnej:**
```
Odliczenie_mies = min(Składka_zapłacona_narastająco, Limit_roczny × (N/12))
```

### Przykład

**JDG liniowy, 2026, limit 10 200 zł:**

| Miesiąc | Dochód narastająco | PIT bez zdrowotnej | Składka zdrow. zapł. narast. | Limit prop. | Odl. | PIT po odl. | Zaliczka |
|---|---|---|---|---|---|---|---|
| Styczeń | 10 000 | 1 900 | 490 | 850 | 490 | 1 410 | 1 410 |
| Luty | 25 000 | 4 750 | 1 225 | 1 700 | 1 225 | 3 525 | 3 525 − 1 410 = 2 115 |
| Marzec | 45 000 | 8 550 | 2 205 | 2 550 | 2 205 | 6 345 | 6 345 − 3 525 = 2 820 |
| ... | ... | ... | ... | ... | ... | ... | ... |
| Grudzień | 250 000 | 47 500 | 12 250 | 10 200 | 10 200 (max limit) | 37 300 | |

## Wybór liniowego — kiedy

### Korzystne

- Dochód roczny > **~156 000 zł** — w tym przedziale na skali drugi próg 32%.
- Bez małżonka rozliczającego się wspólnie (lub małżonek ma własny wysoki dochód).
- Brak dzieci uprawniających do ulgi.
- Koszty pokrywają większość wydatków, ale nie dominujące (wtedy ryczałt by wygrał).

### Niekorzystne

- Dochód < 156 000 — skala tańsza.
- Rodzina z 2+ dzieci — ulga na skali wygrywa.
- Małżonek bez dochodu — wspólne rozliczenie na skali wygrywa.
- Duże przychody + niskie koszty → ryczałt wygrywa.

## Ograniczenia wyboru (art. 9a)

### 2-letni zakaz z byłym pracodawcą

**Art. 9a ust. 3:** nie można być na liniowym, jeśli w bieżącym lub poprzednim roku świadczyłeś tożsame usługi jako pracownik temu samemu podmiotowi.

### Deadline wyboru

- **Przy rejestracji JDG** — w CEIDG-1.
- **Zmiana formy** — do **20 lutego** kolejnego roku przez aktualizację CEIDG.

## Porównanie z innymi formami

### Liniowy vs Skala

| Dochód roczny | Skala PIT | Liniowy PIT | Komu korzystniej |
|---|---|---|---|
| 80 000 zł | 6 000 zł | 15 200 zł | **Skala** (9,6% vs 19%) |
| 120 000 zł | 10 800 zł | 22 800 zł | **Skala** |
| 160 000 zł | 23 600 zł | 30 400 zł | **Skala** |
| 200 000 zł | 36 400 zł | 38 000 zł | Prawie równy |
| 250 000 zł | 52 400 zł | 47 500 zł | **Liniowy** |
| 500 000 zł | 132 400 zł | 95 000 zł | **Liniowy** |

(Przykłady bez uwzględnienia zdrowotnej i odliczeń; dla orientacji.)

**Break-even** ~200 000 – 210 000 zł dochodu.

Z uwzględnieniem odliczenia składki zdrowotnej limit liniowego podnosi się; bez kosztów i bez rodziny liniowy staje się korzystny już od ~180 000 zł dochodu.

### Liniowy vs Ryczałt (np. IT 12%)

- Liniowy 19% × dochód.
- Ryczałt 12% × przychód (bez kosztów).

**Break-even** zależy od stosunku kosztów do przychodu. Jeśli koszty < 37% przychodu → ryczałt prawie zawsze wygrywa.

### Przykład

**Dochód 200 000 zł (przychód 220 000, koszty 20 000):**
- Liniowy: 19% × 200 000 = 38 000.
- Ryczałt 12%: 12% × 220 000 = 26 400.
- Oszczędność z ryczałtem: 11 600 zł.

## Składka zdrowotna na liniowym

**4,9% × Dochód**, min. **9% × minimalne wynagrodzenie**.

**2026 (orient.):**
- Min. mies. = 9% × 4 800 = **432 zł**.
- Dla dochodu 100 000 → miesięczna 4,9% × (100 000/12) = **408 zł/mies** → podnoszona do min. 432 zł.
- Dla dochodu 300 000 → 4,9% × 25 000 = **1 225 zł/mies**.

### Roczne rozliczenie

W **DRA majowej** — korekta na podstawie faktycznego rocznego dochodu (z PIT-36L).

## Przykłady kompletne

### Przykład 1: Developer, liniowy, dochód 200 000 zł

**2026, orient.:**
- PIT 19% × 200 000 = 38 000.
- Składka zdrowotna roczna: 4,9% × 200 000 = **9 800** (minus 10 200 limit → wszystko odliczone).
- PIT netto: 38 000 − 9 800 = **28 200**.
- ZUS społeczny: ~20 400.
- **Razem roczne obciążenie: 28 200 + 9 800 + 20 400 = 58 400 zł** (29,2% dochodu).

### Przykład 2: Konsultant, liniowy vs skala

**Dochód 250 000 zł, małżonek bez dochodu.**

**Liniowy:**
- PIT: 19% × 250 000 = 47 500.
- Zdrowotna: 4,9% × 250 000 = 12 250 (limit 10 200).
- Odliczenie: 10 200.
- PIT netto: 37 300.
- **+ ZUS 20 400 + zdrowotna 12 250 = 69 950 zł.**

**Skala wspólne:**
- Wspólny dochód: 250 000 → / 2 = 125 000.
- Na osobę: 12% × 120 000 − 3 600 + 32% × 5 000 = 11 200 + 1 600 = 12 800 zł.
- × 2 = **25 600**.
- ZUS 20 400 + zdrowotna skala 9% × 250 000 = 22 500.
- **Razem: 25 600 + 20 400 + 22 500 = 68 500 zł.**

**Prawie równo!** Różnica 1 450 zł. Liniowy traci na braku wspólnego rozliczenia.

Gdyby małżonek zarabiał 40 000 — wspólne byłoby jeszcze lepsze.

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Odliczenie składki zdrowotnej powyżej limitu | Korekta US | Max 10 200 zł rocznie (2026, weryfikować) |
| Próba wspólnego rozliczenia | Odrzucenie | Wspólne tylko na skali |
| Ulga na dziecko w PIT-36L | Nie przysługuje | Liniowy bez ulgi na dziecko |
| Usługi byłemu pracodawcy | Utrata prawa do liniowego | 2-letni zakaz |
| Zmiana formy po 20 lutego | Wniosek nieuwzględniony | Do 20 lutego |

## Ograniczenia

- Limit odliczenia zdrowotnej — weryfikować corocznie.
- Specyficzne odliczenia (IP BOX — obniżka do 5% dla praw własności intelektualnej) — poza zakresem skilu.
- Relacje z byłym pracodawcą — szczegółowo zbadać.
