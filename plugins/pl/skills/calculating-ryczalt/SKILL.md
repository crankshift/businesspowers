---
name: calculating-ryczalt
description: Use when calculating Polish ryczałt od przychodów ewidencjonowanych for JDG. Covers multiple stawki by PKWiU activity type, revenue-only base, annual limit, health insurance deduction, monthly advances, PIT-28, exclusions.
---

# calculating-ryczalt

Kalkulacja ryczałtu od przychodów ewidencjonowanych dla JDG w Polsce. Forma opodatkowania charakteryzująca się:
- **Brakiem kosztów** — podstawą jest przychód, nie dochód.
- **Niższymi stawkami** (2%-17%) niż skala / liniowy.
- **Prostotą** — tylko ewidencja przychodów, bez KPiR.

## Kluczowe źródła

- **Ustawa o ryczałcie** z 20.11.1998 (Dz.U. 1998 nr 144 poz. 930):
  - Art. 12 — stawki.
  - Art. 8 — wyłączenia.
  - Art. 6 — limity.
  - Art. 11 — odliczenia (w tym 50% składki zdrowotnej).
- **PKWiU** — klasyfikacja usług/towarów (przypisanie stawki).

## Stawki ryczałtu (art. 12)

| Stawka | Zakres |
|---|---|
| **2%** | Sprzedaż produktów rolnych nieprzetworzonych |
| **3%** | Gastronomia (bez alkoholu 8,5%); sprzedaż detaliczna oleju opałowego; transport taksówkami, wodnymi |
| **5,5%** | Produkcja (wyroby gotowe), roboty budowlane, transport o ładowności > 2 ton |
| **8,5%** | **Usługi ogólne, najem do 100 000 zł, gastronomia z alkoholem**, usługi związane ze sprzedażą detaliczną odzieży |
| **10%** | Usługi związane z obrotem nieruchomościami na własny rachunek |
| **12%** | **Usługi IT (PKWiU 62.01, 62.02, 63.11.1, 63.11.2), doradztwo w informatyce** |
| **12,5%** | Najem powyżej 100 000 zł |
| **14%** | **Usługi doradcze (70.21, 70.22), usługi medyczne prywatne, usługi architektoniczne**, usługi finansowe (z wyjątkami) |
| **15%** | Usługi pośrednictwa w handlu hurtowym; usługi kadrowe; usługi w zakresie ochrony zdrowia |
| **17%** | **Wolne zawody** (prawnicy adwokaci — nie ryczałt wcale; ale niektóre aspekty): wolny zawód jako definicja obejmuje lekarzy, dentystów, weterynarzy, nauczycieli, tłumaczy przysięgłych, inżynierów |

### Stawka dla IT — 12% (najczęstsza)

**Kwalifikujące PKWiU (od 2022 korekta):**
- **62.01.11** — usługi związane z projektowaniem i rozwojem oprogramowania.
- **62.01.12** — usługi związane z projektowaniem i rozwojem technologii informatycznych.
- **62.02.10** — usługi związane z doradztwem w zakresie sprzętu komputerowego.
- **62.02.20** — usługi związane z doradztwem w zakresie oprogramowania.
- **62.02.30** — usługi pomocy technicznej.
- **62.03.11**, **62.03.12** — zarządzanie sieciami, systemami.
- **62.09** — inne IT.
- **63.11.11** — przetwarzanie danych.
- **63.11.12** — usługi baz danych.

### Stawka 14% — doradztwo biznesowe, konsulting

- **70.22** — doradztwo w zakresie działalności gospodarczej.
- **70.21** — doradztwo w zakresie PR, komunikacji.

### Stawka 8,5% — usługi "resztowe"

- Większość usług niezaklasyfikowanych do innych stawek → 8,5%.
- Najem / dzierżawa nieruchomości (do 100 000 zł / rok).

### Stawka 17% — wolne zawody

- Wymaga dobrowolnego zatrudnienia (samodzielna praktyka).

## Limit obrotu

**Art. 6 ust. 4:** limit **2 mln EUR** (przeliczane po kursie NBP z 1 października roku poprzedzającego).

**2026 (orient.):** 2 mln × 4,35 = **8,7 mln zł**.

Po przekroczeniu — automatyczne przejście na skalę od kolejnego roku.

## Formuła

### Bez składki zdrowotnej

```
Podatek = Stawka × Przychód
```

### Z odliczeniem składki zdrowotnej

**Art. 11 ust. 1a:** **50% zapłaconej składki zdrowotnej** odliczane od przychodu (ryczałt od pozostałego przychodu).

```
Przychód_po_odliczeniu = Przychód − 50% × Składka_zdrow_zapłacona
Podatek = Stawka × Przychód_po_odliczeniu
```

## Składka zdrowotna na ryczałcie

**Ryczałtowa (3 progi — obwieszczenie MRPiPS).**

**2026 (orient.):**

| Przychód roczny | Podstawa składki | Miesięczna składka |
|---|---|---|
| ≤ 60 000 zł | 60% × przeciętnego wynagr. (~5 335) | ~480 zł |
| 60 000 – 300 000 zł | 100% × przeciętnego wynagr. (~8 900) | ~800 zł |
| > 300 000 zł | 180% × przeciętnego wynagr. (~16 000) | ~1 440 zł |

### Dynamika miesięczna

- Pierwsze miesiące — według spodziewanego progu (wpisywane do DRA).
- Jeśli w ciągu roku przekraczasz próg → od kolejnego miesiąca wyższa składka.
- Roczne rozliczenie (DRA majowa) — dopłata / nadpłata.

### Odliczenie

**50% zapłaconej rocznej składki zdrowotnej** → odliczenie od przychodu (nie od podatku).

```
Jeśli zapłacona składka = 12 × 800 = 9 600 zł:
  Odliczenie = 50% × 9 600 = 4 800 zł
  Nowy przychód po odliczeniu = Przychód − 4 800
```

## Zaliczki miesięczne

**Miesięcznie do 20-go następnego miesiąca.**

```
Zaliczka_mies_N = Stawka × (Przychód_narast. − 1/12 × Roczna_zdrowotna × 50%) − Zaliczki_poprzednie
```

### Przykład

**Developer IT (12%), przychód 15 000 zł/mies, składka zdrowotna 800 zł/mies:**

| Miesiąc | Przychód narast. | 50% skł. zdrow. narast. | Przychód po odl. | Podatek 12% narast. | Zaliczka mies. |
|---|---|---|---|---|---|
| Styczeń | 15 000 | 400 | 14 600 | 1 752 | 1 752 |
| Luty | 30 000 | 800 | 29 200 | 3 504 | 3 504 − 1 752 = 1 752 |
| Marzec | 45 000 | 1 200 | 43 800 | 5 256 | 5 256 − 3 504 = 1 752 |
| ... | ... | ... | ... | ... | ... |
| Grudzień | 180 000 | 4 800 | 175 200 | 21 024 | ~1 752 |

**Roczny ryczałt**: ~21 024 zł.

## Wyłączenia z ryczałtu (art. 8)

### Podmiotowe wyłączenia

- Apteki.
- Kantory wymiany walut.
- Lombardy.
- Prowadzenie ksiąg rachunkowych (niektóre formy).
- Adwokaci, radcy prawni, notariusze (odrębne zasady; nie ryczałt).

### Przedmiotowe wyłączenia

- Sprzedaż podlegająca VAT obowiązkowemu (handel metalami szlachetnymi, wyrobami tytoniowymi).
- Wytwarzanie i handel środkami płatniczymi.
- Handel nieruchomościami powyżej certain limitów.

### Zakaz 2-letni z byłym pracodawcą (art. 8 ust. 2)

Jeśli w roku bieżącym lub poprzednim świadczyłeś usługi jako pracownik temu samemu podmiotowi w tym samym zakresie PKWiU → **nie możesz** wybrać ryczałtu. Dotyczy także liniowego.

## Ewidencja przychodów

**Obowiązkowa** — prowadzenie **ewidencji przychodów**:
- Data, numer faktury, przychód.
- W podziale na stawki ryczałtu.
- Może być papierowa lub elektroniczna.

**Nie obowiązkowa KPiR** (jak dla skali/liniowego), bo nie ma kosztów.

## PIT-28

**Roczna deklaracja**: do **30 kwietnia** kolejnego roku.

**Struktura:**

- Przychody z podziałem na stawki (każda stawka osobno).
- Składki ZUS zapłacone (odliczenie proporcjonalne na stawki).
- **50% składki zdrowotnej** odliczonej od przychodu.
- Ulgi: IKZE, termomodernizacyjna (ograniczone dla ryczałtu).
- Ryczałt = Σ(stawka × przychód po odliczeniach).
- Minus zaliczki → dopłata lub zwrot.

## Przykłady

### Przykład 1: IT 12%, przychód 180 000 zł

- Przychód: 180 000.
- Składka zdrowotna roczna (próg 60-300k): 12 × 800 = **9 600 zł**.
- Odliczenie (50%): 4 800 zł.
- Przychód po odliczeniu: 175 200.
- Ryczałt 12% × 175 200 = **21 024 zł**.
- ZUS społeczny (Mały ZUS przy 2 latach): ~5 400 zł.
- **Razem roczne: 21 024 + 9 600 + 5 400 = 36 024 zł** (20% obciążenia).

vs liniowy przy tym samym:
- PIT: 19% × 180 000 = 34 200 (minus zdrowotna do limitu).
- Zdrowotna: 4,9% × 180 000 = 8 820 (limit 10 200 → całe odliczone).
- PIT netto: 34 200 − 8 820 = 25 380.
- ZUS: 5 400.
- **Razem: 25 380 + 8 820 + 5 400 = 39 600 zł**.

**Ryczałt oszczędza ~3 600 zł rocznie.**

### Przykład 2: Konsultant 14%, przychód 300 000 zł

- Przychód: 300 000.
- Składka zdrowotna (próg 60-300k; przy przychodzie dokładnie 300k — graniczny): 12 × 800 = **9 600 zł**.
- Odliczenie (50%): 4 800.
- Przychód po odliczeniu: 295 200.
- Ryczałt 14% × 295 200 = **41 328 zł**.
- ZUS: 20 400 (duży).
- **Razem: 41 328 + 9 600 + 20 400 = 71 328 zł** (23,8%).

vs liniowy:
- PIT: 19% × 300 000 = 57 000 (koszty brak w scenariuszu).
- Zdrowotna: 4,9% × 300 000 = 14 700 (limit 10 200).
- PIT netto: 57 000 − 10 200 = 46 800.
- ZUS: 20 400.
- Zdrowotna: 14 700.
- **Razem: 46 800 + 14 700 + 20 400 = 81 900 zł** (27,3%).

**Ryczałt oszczędza 10 500 zł.**

### Przykład 3: Skala vs ryczałt dla konsultanta z rodziną

**Konsultant 14% ryczałt, przychód 250 000 zł, małżonek dochód 0, 2 dzieci.**

**Ryczałt 14%:**
- Przychód: 250 000.
- Zdrowotna: 9 600 (średni próg).
- Odl.: 4 800.
- Po odl.: 245 200.
- Podatek: 34 328 zł.
- ZUS + zdrowotna: 30 000.
- **Razem: ~64 000 zł.**

**Skala wspólna + 2 dzieci:**
- Wspólny dochód 250 000 → / 2 = 125 000.
- Na osobę: 12% × 120k + 32% × 5k − 3 600 = 11 200.
- × 2 = 22 400.
- Ulga 2 dzieci: 2 224 zł.
- PIT netto: 20 176 zł.
- ZUS 20 400 + zdrowotna 9% × 250 000 = 22 500.
- **Razem: 20 176 + 20 400 + 22 500 = 63 076 zł.**

**Skala wspólnie** jest ~1 000 zł lepsza dla rodziny. Gdyby małżonek miał dochód równy, ryczałt byłby lepszy.

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Błędne przypisanie PKWiU → zła stawka | Dopłata lub nadpłata | Sprawdzić PKWiU 2015 lub zapytać KIS |
| Rozlicza koszty | Błąd — ryczałt nie zna kosztów | Rozważyć skalę/liniowy, jeśli duże koszty |
| Przekroczenie 2 mln EUR limit → zostaje na ryczałcie | Automatyczne przejście na skalę | Śledzić przychód; zmiana formy wymuszone |
| Wybór ryczałtu przy usługach byłemu pracodawcy | Utrata prawa za 2 lata | Art. 8 ust. 2 — zawsze zbadać |
| Zapomina o 50% zdrowotnej | Nadpłata | W deklaracji odliczyć 50% zapłaconej |
| Myli ewidencję przychodów z KPiR | Formalnie tylko ewidencja | KPiR niepotrzebna dla ryczałtu |

## Zmiana formy

- **Do 20 lutego** kolejnego roku — zmiana w CEIDG.
- Z ryczałtu na skalę / liniowy: zawsze można.
- Ze skali / liniowego na ryczałt: można, jeśli nie ma wyłączeń (art. 8).

## Ograniczenia

- Ulgi (na dziecko, PIT-0 4+, wspólne rozliczenie) — **niedostępne** na ryczałcie.
- IKZE — można, ale odliczenie ograniczone.
- Termomodernizacyjna — można, do 53 000 zł.
- Stawki miesięczne składki zdrowotnej — weryfikować corocznie obwieszczenia.
- Niektóre branże (usługi medyczne prywatne) — 14%, nie 17% (od 2022).
