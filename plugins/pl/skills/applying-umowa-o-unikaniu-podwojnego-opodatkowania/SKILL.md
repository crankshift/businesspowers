---
name: applying-umowa-o-unikaniu-podwojnego-opodatkowania
description: Use when applying Polish double taxation treaties (UPO). Covers dividends, interest, royalties, capital gains, key bilateral treaties, W-8BEN, tax credit method, certificate of residency CFR-1, MLI and PPT.
---

# applying-umowa-o-unikaniu-podwojnego-opodatkowania

Stosowanie polskich umów o unikaniu podwójnego opodatkowania (UPO) dla osób fizycznych-rezydentów Polski uzyskujących dochody zagraniczne.

## Kluczowe źródła

- **Ustawa o PIT** (Dz.U. 1991 nr 80 poz. 350):
  - Art. 4a — umowy międzynarodowe pierwszeństwo.
  - Art. 30a ust. 9 — zaliczenie proporcjonalne (max 19%).
  - Art. 27 ust. 8 — metoda wyłączenia z progresją (rzadko).
- **Umowy UPO** — poszczególne, dostępne na isap.sejm.gov.pl i podatki.gov.pl.
- **MLI** (Multilateral Instrument, ratyfikowana przez PL 2018) — wpływa na wszystkie umowy.
- **Certyfikat rezydencji** (CFR-1) — wydawany przez KAS.

## Zasada ogólna

```
Polska (rezydent) ma prawo opodatkować całość dochodu rezydenta.
Umowa UPO daje metodę zapobiegania podwójnemu opodatkowaniu:
- Metoda zaliczenia proporcjonalnego (credit method) — najczęściej.
- Metoda wyłączenia z progresją (exemption method) — rzadko.
```

## Metoda zaliczenia proporcjonalnego

**Art. 30a ust. 9 ustawy o PIT + art. 23 większości UPO:**

```
PIT_PL_nalicz = 19% × Dochód_brutto_w_PLN
Zaliczenie = min(Podatek_u_źródła_w_PLN, PIT_PL_nalicz)
PIT_do_zapłaty = PIT_PL_nalicz − Zaliczenie
```

**Kluczowe:** zaliczenie **max do polskiego PIT** (19%). Jeśli za granicą zapłacisz więcej (np. 30% bez W-8BEN w USA) — nadpłata **nie jest zwracana**.

## Metoda wyłączenia z progresją

**Art. 27 ust. 8 ustawy o PIT:**

Dochód zagraniczny **wyłączony z podstawy opodatkowania w PL**, ale **uwzględniony do ustalenia stawki progresywnej dla pozostałych dochodów**.

Obecnie **rzadko stosowana** dla osób fizycznych; przeważa metoda zaliczenia (MLI zastąpił wyłączenie w wielu umowach).

## Kluczowe umowy UPO

### USA-Polska 1974 (+ protokół 2013)

[zakon.rada... znaczy w Polsce — isap.sejm.gov.pl] — Dz.U. 1976 nr 31 poz. 178.

**Stawki u źródła (USA na rzecz rezydenta PL):**

| Dochód | US wh | PL |
|---|---|---|
| Dywidendy (art. 11) | **15%** (z W-8BEN); 30% bez | 19% z zaliczeniem |
| Odsetki (art. 12) | **0%** | 19% |
| Należności licencyjne (art. 13) | 10% | 19% |
| Capital gains (art. 14) | Tylko w PL (0% w USA) | 19% |
| Zarobek (art. 15) | Tylko w PL (jeśli poniżej 183 dni w USA) | Skala / liniowy / ryczałt |

**W-8BEN** — formularz składany w brokerze US (IBKR, Freedom24, Wise, Revolut) by otrzymać stawkę traktatową 15% zamiast 30% dla dywidend.

### Wielka Brytania-Polska 2006

Dz.U. 2006 nr 250 poz. 1840.

| Dochód | UK wh | PL |
|---|---|---|
| Dywidendy (art. 10) | **10%** (dla ≥10% udziałów) / 15% | 19% |
| Odsetki (art. 11) | **5%** (zwykle 0% dla rezydentów banków) | 19% |
| Royalties (art. 12) | **0%** / 5% | 19% |
| Capital gains (art. 13) | Tylko w PL | 19% |

**UK** standardowo **nie pobiera 10% dla UE rezydentów** (tradycyjnie). Weryfikować.

### Niemcy-Polska 2003

Dz.U. 2005 nr 12 poz. 90.

| Dochód | DE wh | PL |
|---|---|---|
| Dywidendy (art. 10) | **5%** (dla ≥10% udziałów) / 15% | 19% |
| Odsetki (art. 11) | 5% | 19% |
| Royalties | 5% | 19% |
| Capital gains | Tylko w PL | 19% |

### Irlandia-Polska 1995 (ważne dla ETF UCITS)

Dz.U. 1996 nr 29 poz. 129.

| Dochód | IE wh | PL |
|---|---|---|
| Dywidendy | **15%** | 19% |
| Odsetki | 10% | 19% |
| Royalties | 10% | 19% |

**Ważne dla UCITS ETF** (większość ETF Ireland zarejestrowanych):
- **Acumulacyjne klasy (Acc)** — reinwestują dywidendy, bez wypłaty; brak podatku u źródła na poziomie inwestora.
- **Dystrybucyjne klasy (Dist)** — wypłacają netto, z podatkiem IE 0%/15% w zależności od typu dywidendy źródłowej.

### Holandia-Polska 2002

Dz.U. 2003 nr 216 poz. 2120.

| Dochód | NL wh | PL |
|---|---|---|
| Dywidendy (art. 10) | **5%** (≥10% udziałów) / 15% | 19% |
| Odsetki | 5% | 19% |
| Royalties | 5% | 19% |

### Emiraty Arabskie-Polska 2004

Dz.U. 2005 nr 197 poz. 1630.

| Dochód | AE wh | PL |
|---|---|---|
| Dywidendy | **5%** (≥10%) / 15% | 19% |
| Odsetki | 5% | 19% |
| Royalties | **0%** (!) | 19% |

**AE 0% dla royalties** — popularne w strukturach IP.

### Francja-Polska 1975

Dz.U. 1977 nr 1 poz. 5.

| Dochód | FR wh | PL |
|---|---|---|
| Dywidendy | **5%** / 15% | 19% |
| Odsetki | 0% | 19% |
| Royalties | **0%** (!) / 10% | 19% |

### Luxembourg-Polska 1995

Dz.U. 1996 nr 110 poz. 527.

| Dochód | LU wh | PL |
|---|---|---|
| Dywidendy | **0%** (≥25%) / 15% | 19% |
| Odsetki | 5% | 19% |

## MLI (Multilateral Instrument)

Ratyfikowany przez Polskę 2018, zmienia postanowienia UPO.

### Principal Purpose Test (PPT)

Jeśli **główną przyczyną** struktury lub transakcji było uzyskanie korzyści z umowy — korzyści są **odmówione**.

**Dla osoby fizycznej inwestor przez brokera** — zwykle brak problemu PPT.

**Dla struktur** (holding w niskopodatkowej jurysdykcji bez faktycznej działalności) — PPT stosowany przez organy.

## Mechanizm uzyskania korzyści

### W kraju źródła (przed potrąceniem)

**Wymaga certyfikatu rezydencji** — dokumentu potwierdzającego status rezydenta PL.

#### Certyfikat rezydencji (CFR-1)

- Wydawany przez Naczelnika US (lub organ wyspecjalizowany).
- Wniosek: przez e-US.
- Termin: zwykle 30 dni.
- Ważny: 1 rok (zwykle).
- Koszt: **17 zł** (opłata skarbowa).

#### Forma W-8BEN (dla US)

- Alternatywa do pełnego certyfikatu.
- Wypełniana w panelu brokera (IBKR, Freedom24).
- Ważna 3 lata.

### W PL (zaliczenie po pobraniu)

Jeśli źródło pobrało wyższy podatek niż stawka umowna → **zaliczenie w PIT** (do max 19%).

**Dowody:**
- Wyciąg brokera z podatkiem u źródła.
- Form 1042-S (USA).
- Rocznie zestawienie od brokera.

## Praktyczne przykłady

### Przykład 1: Dywidenda Apple (USA)

**Sytuacja:**
- $120 dywidenda 15.05.2025.
- IBKR z W-8BEN → USA pobrało 15% ($18).
- Kurs NBP 14.05 (śr): 3,95.

**Kalkulacja:**
- Brutto PLN: 120 × 3,95 = 474.
- Pobrany US PLN: 18 × 3,95 = 71,10.
- PIT PL 19%: 474 × 19% = 90,06.
- Zaliczenie: min(90,06; 71,10) = 71,10.
- **PIT do zapłaty: 18,96 PLN.**

### Przykład 2: Brak W-8BEN (USA 30%)

- $120 dywidenda, USA 30% = $36.
- Brutto: 474 PLN, pobrane US: 142,20.
- PIT PL 19%: 90,06.
- Zaliczenie: min(90,06; 142,20) = 90,06.
- **PIT do zapłaty: 0.**
- **Strata bezzwrotna:** 142,20 − 90,06 = 52,14 PLN.

### Przykład 3: Dywidenda niemiecka

**Sytuacja:**
- 1 000 EUR dywidenda z BMW.
- DE pobrało 15%.
- Kurs NBP 4,30.

**Kalkulacja:**
- Brutto PLN: 4 300.
- Pobrane DE: 645.
- PIT PL 19%: 817.
- Zaliczenie: min(817; 645) = 645.
- **PIT do zapłaty: 172 PLN.**

### Przykład 4: Royalties z ZEA

**Sytuacja:**
- $10 000 royalties z UAE firma (za licencję oprogramowania).
- UAE pobrało 0% (umowa).
- Kurs NBP 4,05.

**Kalkulacja:**
- Brutto PLN: 40 500.
- Pobrane UAE: 0.
- PIT PL 19%: 7 695.
- Zaliczenie: 0.
- **PIT do zapłaty: 7 695 PLN.**

### Przykład 5: Praca zdalna dla US klienta (JDG)

**Sytuacja:**
- Polski JDG, dostawca usług IT dla US klienta.
- USA nie pobiera (art. 14 UPO — zarobek opodatkowany tylko w PL, bo nie ma permanent establishment w US).
- JDG wystawił fakturę $5 000.

**Kalkulacja (ryczałt 12%):**
- Przychód PLN: 5 000 × 4,00 = 20 000.
- Ryczałt: 12% × 20 000 = 2 400 PLN.
- **Brak podatku u źródła w USA.**

## Permanent Establishment (PE)

**Art. 5 UPO:** jeśli prowadzisz zagraniczną działalność przez stałe miejsce:
- Biuro.
- Filia.
- Magazyn > 6 miesięcy.
- Przedstawiciel z uprawnieniem zawierania kontraktów.

→ kraj źródła może opodatkować jak własnego rezydenta.

**Dla JDG/osoby fizycznej zdalnie:**
- Bez PE — tylko rezydentura PL opodatkowuje.

## Rezydencja podatkowa — art. 3 UPO

**Tiebreaker (art. 4 UPO):** gdy podwójna rezydencja:
1. Miejsce stałego zamieszkania.
2. Jeśli oba kraje — centrum życiowych interesów.
3. Miejsce zwykłego pobytu.
4. Obywatelstwo.
5. Porozumienie organów (rzadko).

## W-8BEN — szczegóły

### Dla kogo

- Nierezydent USA otrzymujący dochody ze źródeł US.
- Pozwala zastosować stawkę umowną.

### Jak

1. Wejść na panel brokera.
2. "Tax forms" / "Dokumenty podatkowe".
3. Wypełnić W-8BEN:
   - Imię, nazwisko (dokładnie jak w paszporcie).
   - Country of residence: Poland.
   - Tax identification number: PESEL lub NIP (opcjonalne).
   - Treaty Article: 11 (dywidendy), 12 (odsetki — zwykle nie potrzebne), 13 (royalties — rzadko).
   - Rate: 15% (dywidendy).
4. Podpisać, dołączyć datę.
5. Broker stosuje od razu.

**Ważność:** 3 lata. Odnowienie automatycznie przez brokera lub ręczne.

### Konsekwencje niepodpisania

- Stawka **30%** (maksymalna US).
- W PL zaliczenie **max 19%**.
- **11% bezzwrotne**.

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Brak W-8BEN w US brokerze | 11% bezzwrotne | Podpisać przy rejestracji |
| Certyfikat rezydencji nieważny | Broker stosuje pełną stawkę | Odnawiać corocznie |
| Zaliczenie w ZUS / VAT | Nie ma takiego mechanizmu | Tylko w PIT |
| Zaliczenie całej kwoty bez limitu | Korekta US | Max 19% = polska stawka |
| Dywidenda z UK 10% pod PL 19% — bez zaliczenia | Podwójny podatek | Zawsze odnotować w PIT-38 |
| Pominięcie sekcji E w PIT-38 | Niedopłata | Obowiązkowo sekcja E |

## Lista najkorzystniejszych UPO dla inwestora

Najniższe stawki u źródła dla dywidend rezydenta PL (z umownym ≥10% portfolio):

1. **Luxembourg**: 0%.
2. **Niemcy**: 5%.
3. **Holandia**: 5%.
4. **Kuwejt**: 5%.
5. **ZEA**: 5%.
6. **Francja**: 5%.
7. **Belgia**: 5%.

Dla dywidend drobnych (nie ≥10%):

- **UK**: 10%.
- **USA (z W-8BEN)**: 15%.
- **Niemcy**: 15%.
- **Irlandia**: 15%.
- **Francja**: 15%.

## Ograniczenia

- Skill dla typowych scenariuszy; złożone struktury (holding, PE, IP BOX) — konsultant specjalistyczny.
- MLI i PPT — dynamicznie zmieniają umowy.
- Dla podatników z podwójną rezydencją — dokładna analiza tiebreakerów.
- UCITS ETF — specyficzne reguły z uwagi na strukturę Irlandii.
