---
name: calculating-zus
description: Use when calculating Polish ZUS social contributions for JDG. Covers four regimes (Ulga na start, Mały ZUS, Mały ZUS Plus, Duży ZUS), chorobowa, Fundusz Pracy, annual caps, DRA deadlines.
---

# calculating-zus

Kalkulacja ZUS społecznego dla JDG w Polsce. Cztery reżimy: Ulga na start, Mały ZUS, Mały ZUS Plus, Duży ZUS. Skill podaje wzory i orientacyjne kwoty 2026.

## Kluczowe źródła

- **Ustawa o systemie ubezpieczeń społecznych** (Dz.U. 1998 nr 137 poz. 887):
  - Art. 18 — podstawa wymiaru.
  - Art. 18a — Mały ZUS.
  - Art. 18c — Mały ZUS Plus.
  - Art. 22 — stopy składek.
- **Prawo przedsiębiorców** (Dz.U. 2018 poz. 646):
  - Art. 18 — Ulga na start.
- **Obwieszczenie MRiPS** na rok 2026 — aktualne wielkości.

## Składki ZUS — stopy

| Składka | Stopa | Obowiązek |
|---|---|---|
| Emerytalna | **19,52%** | Obowiązkowa |
| Rentowa | **8,00%** | Obowiązkowa |
| Wypadkowa | **1,67%** (średnia; od 0,67% do 3,33%) | Obowiązkowa |
| Chorobowa | **2,45%** | **Dobrowolna** |
| Fundusz Pracy | **2,45%** | Obowiązkowy (wyjątki: Mały ZUS) |
| Fundusz Solidarnościowy | **—** (wchodzi do Fundusz Pracy) | — |

### Fundusz Pracy — kiedy nie

- **Mały ZUS** (preferencyjny) — zwolnienie z FP.
- Osoby 60+ (kobiety) / 65+ (mężczyźni) — zwolnienie.

## Cztery reżimy

### 1. Ulga na start

**Warunki (art. 18 Prawa przedsiębiorców):**
- Pierwsza działalność lub upłynęło **60 miesięcy** od zamknięcia poprzedniej.
- Nie świadczy usług byłemu pracodawcy (2 lata wstecz).

**Czas:** **6 miesięcy**.

**Składki:**
- Społeczne: **0 zł**.
- **Zdrowotna obowiązkowa** (min. 9% × min. wynagr. lub wg dochodu).

**Zgłoszenie:** **ZUS ZZA** (tylko zdrowotna).

**Uwaga:**
- Nie liczy się do stażu emerytalnego.
- Brak chorobowej → brak zasiłków.

### 2. Mały ZUS (preferencyjny, art. 18a USUS)

**Warunki:**
- Po Uldze na start lub od razu (jeśli bez ulgi).
- Pierwsze **24 miesiące** działalności.
- Brak relacji z byłym pracodawcą.

**Podstawa wymiaru:**

```
Podstawa = 30% × Minimalne_wynagrodzenie
```

**2026 (orient., MZ = 4 800 zł):**
- Podstawa = 30% × 4 800 = **1 440 zł**.

**Składki miesięcznie (2026):**
- Emerytalna 19,52% × 1 440 = **281,09 zł**.
- Rentowa 8% × 1 440 = **115,20 zł**.
- Wypadkowa 1,67% × 1 440 = **24,05 zł**.
- Chorobowa 2,45% × 1 440 = **35,28 zł**.
- **Razem z chorobową: ~455,62 zł.**
- Bez chorobowej: ~420,34 zł.

**FP: nie pobiera się** (preferencja).

**Zgłoszenie:** **ZUS ZUA** (społeczne + chorobowa, jeśli dobrowolnie).

### 3. Mały ZUS Plus (art. 18c USUS)

**Warunki:**
- Przychód z JDG w poprzednim roku ≤ **120 000 zł** (2024; weryfikować 2026).
- Prowadzisz JDG co najmniej **60 dni** w poprzednim roku.
- Maksymalnie **36 miesięcy** w kolejnych **60 miesiącach**.
- Brak relacji z byłym pracodawcą (ostatnie 2 lata w zakresie tego samego PKWiU).

**Podstawa wymiaru:**

```
Podstawa = 50% × (Dochód_poprzedni_rok / 12)
```

**Ograniczenia:**
- Nie mniej niż **30% × MZ** (~1 440 zł) — czyli minimum jak Mały ZUS.
- Nie więcej niż **60% × przeciętnego wynagr.** (~5 335 zł) — czyli max jak Duży ZUS.

**Przykład (dochód 2024 = 80 000 zł):**
- Dochód miesięczny: 80 000 / 12 = 6 667 zł.
- Podstawa: 50% × 6 667 = 3 333 zł.
- Składki:
  - Emerytalna 19,52% × 3 333 = 650,60 zł.
  - Rentowa 8% × 3 333 = 266,64 zł.
  - Wypadkowa 1,67% × 3 333 = 55,66 zł.
  - Chorobowa 2,45% × 3 333 = 81,66 zł.
  - FP 2,45% × 3 333 = 81,66 zł (MZ Plus płaci FP, Mały ZUS zwolniony!).
  - **Razem: ~1 136 zł.**

**Zgłoszenie:** co roku w DRA z odpowiednim kodem tytułu ubezpieczenia (05 82).

### 4. Duży ZUS (standard)

**Podstawa:**

```
Podstawa = 60% × Prognozowane_przeciętne_wynagrodzenie
```

**2026 (orient., przeciętne ~8 900 zł):**
- Podstawa = 60% × 8 900 = **5 335 zł**.

**Składki miesięcznie:**
- Emerytalna 19,52% × 5 335 = **1 041,39 zł**.
- Rentowa 8% × 5 335 = **426,80 zł**.
- Wypadkowa 1,67% × 5 335 = **89,09 zł**.
- Chorobowa 2,45% × 5 335 = **130,71 zł** (dobrowolna).
- FP 2,45% × 5 335 = **130,71 zł**.
- **Razem z chorobową i FP: ~1 819 zł.**

## Roczne ograniczenie (kap na emerytalną i rentową)

**Art. 19 ust. 1 USUS:**

Suma podstaw wymiaru emerytalnej i rentowej w ciągu roku nie może przekroczyć **30-krotności przeciętnego wynagrodzenia**.

**2026 (orient.):** 30 × 8 900 = **267 000 zł**.

Po osiągnięciu tej kwoty → składki emerytalna i rentowa **zawieszone** dla pozostałej części roku.

Dla Dużego ZUS z podstawą 5 335 zł/mies × 12 = 64 020 zł rocznie — **daleko poniżej limitu**. Limit istotny dla tych, którzy zadeklarują wyższą podstawę.

## Chorobowa — koszty vs korzyści

### Koszt

- **2,45%** podstawy wymiaru.
- Duży ZUS: 130,71 zł/mies.
- Mały ZUS: 35,28 zł/mies.

### Korzyść

- Prawo do **zasiłku chorobowego** (po 90 dniach od zgłoszenia JDG).
- **Zasiłek macierzyński** (100% podstawy przez 20 tygodni + 32 rodzicielskiego).
- Zasiłek **opiekuńczy** (80% na opiekę nad dzieckiem).
- Świadczenie **rehabilitacyjne** (75-100% przez maks. 12 miesięcy po chorobie).

### Strategia "podniesienia podstawy"

Możesz zadeklarować **wyższą podstawę chorobowej** (do 250% × przeciętnego wynagrodzenia).

**Przykład przed ciążą (9 miesięcy):**
- Normalna podstawa chorobowej: 5 335 zł (Duży ZUS).
- Podniesiona do 100% × przeciętnego: **8 900 zł**.
- Chorobowa 2,45% × 8 900 = 218 zł/mies.
- Zasiłek macierzyński: 100% × 8 900 = **8 900 zł/mies** przez 12 miesięcy urlopu = **106 800 zł netto**.

vs normalnie: 5 335 zł × 12 = 64 020 zł.

**Dopłata**: 9 miesięcy × (218 − 131) = 783 zł.
**Zysk z zasiłku**: 106 800 − 64 020 = **42 780 zł**.

## Ograniczenia chorobowej

- **Obowiązkowe 90 dni** ciągłości składki chorobowej przed skorzystaniem z zasiłku.
- Jeśli pauza (nie płaciłeś chorobowej przez miesiąc) — trzeba od nowa 90 dni.

## ZUS przy drugim tytule ubezpieczenia (etat + JDG)

**Art. 9 USUS:**

Jeśli masz **drugi tytuł ubezpieczenia** (etat z wynagrodzeniem ≥ minimum) → z JDG **nie płacisz składek społecznych** (emerytalna, rentowa pobierana z etatu).

**Zdrowotna:**
- **Płacona z każdego tytułu** osobno!
- Etat → zdrowotna z pensji.
- JDG → zdrowotna wg formy (9% skala / 4,9% liniowy / zryczałtowana).

**Chorobowa:**
- Z etatu — obowiązkowa.
- Z JDG — zwykle się nie opłaca (wystarcza etat).

### Przykład

**Paweł: etat 8 000 zł + JDG ryczałt 12%.**
- Z etatu: ZUS pełny odprowadzany przez pracodawcę.
- Z JDG: **tylko zdrowotna** (~800 zł/mies próg 60-300k).
- Społeczne z JDG: **0 zł**.

**Oszczędność** vs pełny ZUS z JDG: ~1 700 zł/mies.

## Deklaracja ZUS — DRA

### Dla JDG bez pracowników

- **Miesięcznie** do **10-go** następnego miesiąca.
- Wypełnia sam JDG (jeśli pracownicy → do 15-go).
- Automatyczne pobieranie z konta bankowego po konfiguracji w e-PUE.

### Z pracownikami

- DRA — **do 15-go** (dla wszystkich).
- RCA — rozliczenie składek za każdego pracownika.
- RSA — informacja o świadczeniach.

## Odliczenie ZUS w PIT

### Skala

- Składki społeczne zapłacone (emerytalna + rentowa + wypadkowa + chorobowa + FP) → **odliczenie od dochodu**.
- **Zdrowotna nie odliczana.**

### Liniowy

- Społeczne → odliczenie od dochodu.
- Zdrowotna → do limitu rocznego (~10 200 zł 2026).

### Ryczałt

- Społeczne → **odliczenie od przychodu** (proporcjonalnie na stawki).
- 50% zdrowotnej → odliczenie od przychodu.

## Przykłady

### Przykład 1: Start JDG po 5 latach na etacie

**Sytuacja:** Kasia, developer, pierwsza JDG (wcześniej tylko umowa o pracę).

**Plan 2026-2028:**

**0-6 miesięcy (Ulga na start):**
- Społeczne: 0.
- Zdrowotna (ryczałt 12%, przychód 15k/mies, próg 60-300k): 800 zł.
- **Razem: 800 zł/mies × 6 = 4 800 zł.**

**Miesiące 7-30 (Mały ZUS, 24 mies.):**
- Społeczne: ~455 zł.
- Zdrowotna: 800 zł.
- **Razem: 1 255 zł/mies × 24 = 30 120 zł.**

**Miesiące 31+ (Duży ZUS):**
- Społeczne: ~1 820 zł.
- Zdrowotna: 800 zł.
- **Razem: 2 620 zł/mies.**

**Oszczędności przez 30 miesięcy preferencji vs Duży ZUS od razu:** ~45 000 zł.

### Przykład 2: Mały ZUS Plus

**Sytuacja:** Michał, 3 lata JDG (już po Małym ZUS 24 mies.), ryczałt 12%.

- Przychód 2024: 100 000 zł.
- Dochód dla celów ZUS (przychód minus odliczenia?): używa się **dochodu rzeczywistego** z rozliczenia 2024.
- Dochód: 100 000 (ryczałt = przychód ≈ dochód w uproszczeniu; weryfikować dokładne zasady).

**Podstawa Mały ZUS Plus:**
- Dochód mies: 100 000 / 12 = 8 333 zł.
- Podstawa: 50% × 8 333 = **4 167 zł**.
- Ale ograniczenie: nie więcej niż 60% przeciętnego wynagr. = 5 335 → 4 167 mieści się.

**Składki 2026:**
- Emerytalna: 19,52% × 4 167 = 813 zł.
- Rentowa: 8% × 4 167 = 333 zł.
- Wypadkowa: 1,67% × 4 167 = 70 zł.
- Chorobowa: 2,45% × 4 167 = 102 zł.
- FP: 2,45% × 4 167 = 102 zł.
- **Razem: 1 420 zł.**

vs Duży ZUS (1 820 zł) → **oszczędność 400 zł/mies = 4 800 zł/rok**.

### Przykład 3: Planowanie urlopu macierzyńskiego

**Katarzyna, JDG od 4 lat, Duży ZUS, myśli o dziecku.**

**Strategia (9 miesięcy przed ciążą):**
1. Podnieść podstawę chorobowej z 5 335 do 8 900 zł (100% przeciętnego).
2. Dopłata chorobowej: 2,45% × (8 900 − 5 335) = 87 zł/mies.
3. Utrzymanie 9 miesięcy → dopłata 783 zł.
4. Podstawa zasiłku macierzyńskiego: 8 900 zł.
5. 12 miesięcy urlopu (20 tyg macierzyński + 32 tyg rodzicielski): **106 800 zł zasiłku**.

**Korzyść netto:** ~43 000 zł (po potrąceniu normalnego zasiłku, który otrzymałaby bez strategii).

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Ulga na start dla byłego pracodawcy (te same usługi) | Utrata prawa + dopłata | Nie świadczyć temu samemu podmiotowi 2 lata |
| Przekroczenie 24 mies. Mały ZUS, zapomnienie zmiany | ZUS automatycznie podnosi, ale lepszy nadzór | Od 25 mies. — Duży ZUS (lub MZP jeśli dochód pozwala) |
| Mały ZUS Plus — brak rocznego zgłoszenia | Powrót do Dużego | Co roku potwierdzenie w DRA |
| Rezygnacja z chorobowej, potem ciąża | Brak zasiłku macierzyńskiego | Zawsze opłaca się chorobowa (małe koszty, duże korzyści) |
| FP przy Małym ZUS | Nadpłata | FP wyłączone przy Małym ZUS |
| Podstawa wyższa niż 250% przeciętnego → ZUS nie przyjmie | Korekta | Ograniczenie 250% dla chorobowej, 30x rocznie dla emerytalnej/rentowej |

## Ograniczenia

- Stopy wypadkowej różnicują się (0,67% – 3,33%) wg branży; dla JDG bez pracowników — zwykle 1,67%.
- Obywatele UE z siedzibą poza PL — różne zasady.
- Umowy o dzieło — nie podlegają ZUS (tylko PIT).
- Rolnicy — KRUS, nie ZUS.
