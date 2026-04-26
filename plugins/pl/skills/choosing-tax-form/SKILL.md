---
name: choosing-tax-form
description: Use when choosing Polish JDG tax form. Covers decision tree between skala, liniowy, ryczałt, and karta, considering revenue, cost ratio, PKD eligibility, family situation, ex-employer restriction, health insurance treatment.
---

# choosing-tax-form

Drzewo decyzyjne wyboru formy opodatkowania dla polskiej JDG. Skill uruchamia się gdy użytkownik prosi o **porównanie** wariantów (skala vs liniowy vs ryczałt) lub **rekomendację**.

## Kluczowe kryteria

1. **PKD/PKWiU** — czy dozwolony ryczałt (art. 8 ustawy o ryczałcie).
2. **Oczekiwany przychód roczny**.
3. **Stosunek kosztów do przychodu**.
4. **Sytuacja rodzinna** — małżonek, dzieci, samotny rodzic.
5. **Relacje z byłym pracodawcą** — 2-letni zakaz dla liniowego i ryczałtu.
6. **Plany** — zmiana branży, dodatkowe źródła dochodu.

## Parametry — odniesienie

> Aktualne wartości — pobierać przez kanoniczne skille.
> Jeśli skill nie odpowiedział, użyj fallback poniżej; ostrzeż: «⚠ Wartość [parametr] użyto ze stanem na [data].»

| Parametr | Kanoniczny skill | Fallback |
|---|---|---|
| Skala 12%/32%, kwota wolna 30 000, próg 120 000 | `calculating-pit-scale` | 12% / 32%; 30 000 zł; 120 000 zł _(01.01.2026)_ |
| Liniowy 19%, limit odliczenia zdrowotnej | `calculating-pit-liniowy` | 19%; ~10 200 zł _(01.01.2026)_ |
| Ryczałt stawki 2-17%, limit 2M EUR | `calculating-ryczalt` | art. 12; 2 000 000 EUR _(01.01.2026)_ |
| Składka zdrowotna 9%/4,9%/ryczałtowa | `calculating-skladka-zdrowotna` | 9% skala / 4,9% lin. / progi ryczałt _(01.01.2026)_ |
| Ulga na dziecko (kwoty) | `calculating-pit-scale` | 92,67 / 166,67 / 225 zł/mies _(01.01.2026)_ |

## Formy w skrócie

| Forma | Stawka | Baza | Koszty | Ulgi |
|---|---|---|---|---|
| Skala | 12% / 32% | Dochód | Tak | Wszystkie (dzieci, wspólne) |
| Liniowy | 19% | Dochód | Tak | Bez dzieci/wspólnego |
| Ryczałt | 2-17% | **Przychód** | **Nie** | Ograniczone |
| Karta | Stała | — | — | — (wygaszana) |

## Drzewo decyzyjne

```
1. PKD/PKWiU zakazany dla ryczałtu (art. 8)?
   ├─ Tak → skala / liniowy / karta (dla istniejących)
   └─ Nie → wszystkie opcje

2. Stosunek kosztów do przychodu?
   ├─ < 20% → ryczałt bardzo atrakcyjny (brak kosztów nie boli)
   ├─ 20-40% → porównanie (często liniowy)
   └─ > 40% → skala lub liniowy

3. Oczekiwany dochód roczny?
   ├─ < 120 000 zł → SKALA zwykle wygrywa (12%, kwota wolna)
   ├─ 120-200 000 zł → porównanie (skala vs liniowy vs ryczałt)
   └─ > 200 000 zł → LINIOWY lub ryczałt (skala 32% drugi próg)

4. Małżonek bez dochodu / z niskim dochodem?
   └─ Tak → SKALA (wspólne rozliczenie dzieli na 2)

5. 2+ dzieci na utrzymaniu?
   └─ Tak → SKALA (ulga na dzieci = do 2 700 zł/rok na 4+ dziecko)

6. Usługi dla byłego pracodawcy (w ostatnich 2 latach, ten sam PKD)?
   └─ Tak → 2-letni zakaz liniowego/ryczałtu → SKALA wymuszona

7. Branża:
   ├─ IT (62.01, 62.02, 63.11) → RYCZAŁT 12% (często najkorzystniejszy)
   ├─ Consulting (70.22) → SKALA/LINIOWY (14% ryczałt duzy)
   ├─ Usługi ogólne → RYCZAŁT 8,5%
   ├─ Handel / produkcja → RYCZAŁT 5,5%
   ├─ Gastronomia → RYCZAŁT 3% / 8,5%
   └─ Wolne zawody (prawnicy) → SKALA (niektóre zakazy)
```

## Porównanie liczbowe

### Scenariusz 1: IT developer, przychód 180 000 zł, 5% kosztów

**Dochód:** 180 000 − 9 000 = 171 000 zł.

| Forma | PIT | Zdrowotna | Odliczenie ZDR | Razem (bez ZUS) |
|---|---|---|---|---|
| Skala | 12% × 120k + 32% × 51k − 3 600 = 30 720 | 9% × 171 000 = 15 390 | 0 | 46 110 |
| Liniowy | 19% × 171 000 = 32 490 | 4,9% × 171k = 8 379 | 8 379 (do limitu 10 200) | 24 111 + 8 379 = 32 490 |
| Ryczałt 12% | 12% × 180 000 − 50% × 9 600 = 21 600 − 4 800 = 16 800 | 9 600 | 4 800 (już odliczone od przychodu) | 26 400 |

Dodaj ZUS (zakładam Mały ZUS): ~5 400 rocznie.

**Razem:**
- Skala: **51 510 zł** (28,6%).
- Liniowy: **37 890 zł** (21%).
- Ryczałt: **31 800 zł** (17,7%).

**Ryczałt wygrywa** dla tego scenariusza.

### Scenariusz 2: Konsultant, przychód 300 000 zł, 20% kosztów, żona bez dochodu, 2 dzieci

**Dochód:** 240 000 zł.

| Forma | PIT | Ulga dzieci | Wspólne | Zdrowotna | Razem |
|---|---|---|---|---|---|
| **Skala wspólne** | 2× (12% × 120k − 3 600 + 32% × 0) = 21 600 | −2 224 | TAK | 21 600 | 41 000 |
| **Liniowy** | 45 600 | — | NIE | 11 760 (limit 10 200) | 47 160 |
| **Ryczałt 14%** | 14% × 300k − 50% × 9 600 = 42 000 − 4 800 = 37 200 | — | — | 9 600 | 46 800 |

Dodaj ZUS: ~20 400 zł.

**Razem:**
- Skala wspólne: **61 400 zł**.
- Liniowy: **67 560 zł**.
- Ryczałt: **67 200 zł**.

**Skala wspólne wygrywa** dzięki dzieciom i żonie bez dochodu.

### Scenariusz 3: E-commerce, przychód 500 000 zł, 60% kosztów

**Dochód:** 200 000 zł.

| Forma | PIT | Zdrowotna | Razem |
|---|---|---|---|
| Skala | 10 800 + 32% × 80k = 36 400 | 18 000 | 54 400 |
| Liniowy | 19% × 200k = 38 000 − 10 200 = 27 800 | 9 800 | 37 600 |
| Ryczałt 5,5% | 5,5% × 500k − 50% × 17k = 27 500 − 8 500 = 19 000 | 17 280 | 36 280 |

**Ryczałt 5,5% i liniowy podobne**, oba znacznie lepsze od skali.

**Ryczałt wygrywa nieznacznie** dla e-commerce z tą strukturą.

### Scenariusz 4: Mała usługa, przychód 60 000 zł, 10% kosztów

**Dochód:** 54 000 zł.

| Forma | PIT | Ulga | Zdrowotna | Razem |
|---|---|---|---|---|
| Skala | 12% × 54k − 3 600 = 2 880 | — | 4 860 | 7 740 |
| Liniowy | 19% × 54k = 10 260 | 4 860 (limit większy niż kwota) | 2 646 (odliczone) | 10 260 + 2 646 − 2 646 = 10 260 |
| Ryczałt 8,5% | 8,5% × 60k = 5 100 | — | 5 760 (próg 1) | 10 860 |

**Skala wygrywa** dla niskich dochodów.

## Ograniczenia wyboru

### Art. 9a ustawy o PIT — 2-letni zakaz

Nie można ryczałtu / liniowego, jeśli w roku bieżącym lub poprzednim wykonywałeś **tożsame usługi** jako pracownik temu samemu podmiotowi.

### Art. 8 ustawy o ryczałcie — wyłączenia PKWiU

- Kantory walut.
- Lombardy.
- Apteki.
- Usługi prawne (adwokat / radca prawny / notariusz — tylko skala).
- Niektóre usługi finansowe.

### Karta podatkowa

- **Od 2022** — tylko dla osób, które były na karcie w 2021. Nie można nowo wybierać.

## Zmiana formy

**Do 20 lutego** kolejnego roku — aktualizacja CEIDG.

**Zmiany w trakcie roku** — zasadniczo niedopuszczalne (wyjątek: utrata prawa do ryczałtu).

### Gdy zmieniać

- **Skala → liniowy**: gdy dochód stabilnie >170-200k i brak ulg rodzinnych.
- **Skala → ryczałt**: gdy przychód > ~200k i koszty < 20%.
- **Liniowy → ryczałt**: gdy branża pozwala i koszty są niskie.
- **Ryczałt → skala**: gdy pojawia się dziecko, małżonek traci dochód, koszty rosną.

## Scenariusze pomocnicze

### Życiowy scenariusz IT-fli na kontrakcie B2B

**Profil:**
- Developer, ma umowę B2B z firmą.
- 15-20 000 zł/mies.
- Żadnych sprzętów, minimalne koszty (~500 zł/mies).

**Rekomendacja:** **RYCZAŁT 12%** (PKD 62.01.Z).

**Uzasadnienie:**
- Niskie koszty → ryczałt najkorzystniejszy.
- PKWiU 62.01.11 objęte stawką 12%.
- Prosta ewidencja przychodów.
- Kwota wolna w skali (30k) nie wystarczy, by wyprzedzić liniowy dla przychodu 180-240k.

### Scenariusz Mały biznes + rodzina

**Profil:**
- Sklep stacjonarny, przychód 300k.
- 60% koszty.
- Żona pracuje, ale na 1/4 etatu (20k rocznie).
- 3 dzieci.

**Rekomendacja:** **SKALA WSPÓLNE**.

**Uzasadnienie:**
- Dochód 120k → próg skali.
- Żona dochód 20k → dzielenie w wspólnym.
- Ulga na 3 dzieci: 4 224 zł.
- Ulga na termomodernizację możliwa.

### Scenariusz Freelancer tłumacz

**Profil:**
- Tłumaczenia freelancerskie.
- Przychód 80 000 zł.
- Żadnych stałych kosztów.

**Rekomendacja:** **RYCZAŁT 8,5%** (PKWiU 74.30).

**Uzasadnienie:**
- Niskie koszty.
- 8,5% × 80 000 = 6 800 + zdrowotna ~5 760 = 12 560.
- Na skali: 12% × 80k − 3 600 = 6 000 + zdrowotna 9% × 80k = 7 200 = 13 200.
- Ryczałt 8,5% nieco lepszy dla niskich kosztów.

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| "Wybiorę skalę bo domyślnie" | Przepłacanie | Analiza każdego roku |
| Ryczałt dla branży z wysokimi kosztami | Nadpłata | Gdy koszty > 40%, rozważ skalę/liniowy |
| Liniowy z 2 dziećmi na utrzymaniu | Brak ulgi na dzieci | Skala umożliwia ulgi |
| Usługi byłemu pracodawcy → ryczałt | Utrata prawa | 2-letni zakaz zawsze sprawdzić |
| Zmiana formy po 20 lutego | Wniosek nieuwzględniony | Decyzja w grudniu/styczniu |

## Wyjście skilu — rekomendacja

Format:

```
**Rekomendowana forma: RYCZAŁT 12%**

**Uzasadnienie:**
1. PKD 62.01.Z (IT) — nie ma wyłączeń; stawka 12%.
2. Przychód ~180k zł/rok, bez znaczących kosztów.
3. Liniowy 19% dałby ~28% obciążenia; ryczałt 12% ~18%.
4. Bez małżonka wspólnie rozliczającego (on również JDG).
5. Brak ulg na dzieci do wykorzystania.

**Orientacyjne obciążenie**: ~18% przychodu.

**Alternatywy:**
- Liniowy jeśli klienci wymagają wysokich kosztów uznania.
- Skala jeśli dochód roczny spadnie poniżej 120k i będziesz miał małżonka bez pensji.

**Ograniczenia ryczałtu:**
- Brak wspólnego rozliczenia.
- Brak ulgi na dzieci.
- Nie świadcz usług byłemu pracodawcy (2 lata).
```

## Ograniczenia

- Skill nie uwzględnia wszystkich niuansów (IP BOX, ulga B+R, rozliczenie zagraniczne).
- Stawki weryfikować corocznie.
- Dla branż regulowanych (prawnicy, lekarze) — osobne reguły.
