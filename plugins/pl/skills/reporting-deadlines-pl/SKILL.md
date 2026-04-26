---
name: reporting-deadlines-pl
description: Use when checking Polish tax reporting deadlines for JDG and individuals. Covers JPK_V7 monthly/quarterly, PIT advances, annual PIT-36/36L/28/38/39, PIT-11, ZUS DRA, annual składka zdrowotna reconciliation, penalties, czynny żal.
---

# reporting-deadlines-pl

Pełny kalendarz sprawozdawczości podatkowej JDG i osoby fizycznej w Polsce. Skill zbudowany na 2026; zasady takie same w kolejnych latach (przesuwają się tylko konkretne dni gdy wypadają na weekend/święto).

## Kluczowe źródła

- **Ordynacja podatkowa** (Dz.U. 1997 nr 137 poz. 926):
  - Art. 12 (przeniesienie na dzień roboczy).
  - Art. 53-56 (odsetki).
- **Ustawa o PIT** — art. 44, 45 (zaliczki i deklaracje).
- **Ustawa o VAT** — art. 99, 109 (JPK).
- **Ustawa o USUS** — art. 46-47 (ZUS).
- **KKS** — art. 56-60 (kary).

## Zasady przenoszenia

- Jeśli termin wypada na **sobotę, niedzielę lub święto** → przesunięcie na **kolejny dzień roboczy** (art. 12 Ordynacji).
- Święta 2026: 1 styczeń, 6 styczeń, Wielkanoc (5-6 kwietnia), 1 maj, 3 maj, 4 czerwca (Boże Ciało), 15 sierpnia, 1 listopada, 11 listopada, 25-26 grudnia.

## Kalendarz JDG — ogólny

| Dzień | Deklaracja / płatność | Dla kogo |
|---|---|---|
| **10-go** | ZUS DRA + składki (bez pracowników) | JDG bez pracowników |
| **15-go** | ZUS DRA + składki (z pracownikami); ZUS DRA z pracownikami | JDG z pracownikami |
| **20-go** | Zaliczka PIT za poprzedni miesiąc (miesięczna) lub po kwartale (kwartalna) | Wszyscy JDG |
| **20-go** | Zaliczka składka zdrowotna | Wszyscy JDG |
| **25-go** | JPK_V7M + VAT za poprzedni miesiąc | VAT-czynni |

## Kalendarz — deklaracje roczne

### Dla JDG

| Deklaracja | Termin | Forma |
|---|---|---|
| **PIT-36** (skala) | 30 kwietnia | e-US |
| **PIT-36L** (liniowy) | 30 kwietnia | e-US |
| **PIT-28** (ryczałt) | 30 kwietnia | e-US |
| **Rozliczenie roczne składki zdrowotnej** (DRA maj) | 20 maja | e-PUE ZUS |

### Dla osób fizycznych

| Deklaracja | Termin | Forma |
|---|---|---|
| **PIT-37** (pracownicy z jednym źródłem) | 30 kwietnia | "Twój e-PIT" lub e-US |
| **PIT-36** (wielość źródeł) | 30 kwietnia | e-US |
| **PIT-38** (kapitały) | 30 kwietnia | e-US |
| **PIT-39** (sprzedaż nieruchomości) | 30 kwietnia | e-US |
| **SD-Z2** (spadek/darowizna grupa 0) | 6 miesięcy od nabycia | US papierowo lub e-US |
| **SD-3** (spadek/darowizna grupa I-III) | 1 miesiąc od obowiązku | US |

### Dla pracodawców

| Deklaracja | Termin |
|---|---|
| **PIT-11** (informacja o dochodach pracownika) | 31 stycznia |
| **PIT-4R** (zaliczki PIT) | 31 stycznia |
| **ZUS IWA** (dane o wypadkach) | 31 stycznia |
| **PIT-8AR** (ryczałt pobrany) | 31 stycznia |

## Zaliczki PIT — miesięczne vs kwartalne

### Miesięczne (domyślnie)

- Do **20-go** następnego miesiąca.
- Np. za styczeń 2026 → do 20.02.2026.

### Kwartalne (dla małych podatników)

**Warunki:**
- Przychód w poprzednim roku < **2 mln EUR**.
- Oświadczenie w CEIDG.

**Terminy:**
- Za I kw. → 20.04.
- Za II kw. → 20.07.
- Za III kw. → 20.10.
- Za IV kw. → uwzględniany w PIT rocznym (30 kwietnia).

**Uwaga:** IV kw. **nie** jest zaliczką; rozliczana od razu w PIT rocznym.

## JPK_V7

### Miesięczny (domyślnie)

- Do **25-go** następnego miesiąca.
- JPK_V7M = deklaracja + ewidencja w jednym pliku.

### Kwartalny (mali podatnicy)

**Warunki:**
- Przychód < 2 mln EUR.
- Oświadczenie w US.

**Struktura:**
- Za pierwsze 2 miesiące kwartału → "tylko ewidencja" (mini-JPK).
- Za 3. miesiąc kwartału → pełny JPK_V7K z deklaracją.

**Terminy:**
- Za styczeń → 25.02 (tylko ewidencja).
- Za luty → 25.03 (tylko ewidencja).
- Za marzec (cały kwartał) → 25.04 (JPK_V7K pełny).

## ZUS

### Bez pracowników

- DRA + składki za miesiąc N → do **10-go** miesiąca N+1.

### Z pracownikami

- DRA + RCA + RSA za miesiąc N → do **15-go** miesiąca N+1.
- Składki za miesiąc N → do 15-go.

### Składka zdrowotna

- Miesięcznie: razem z DRA (10-go lub 15-go).
- **Rocznie: DRA za luty (rozliczeniowa) do 20 maja.**

## Specjalne terminy

### KSeF — Krajowy System e-Faktur

- **01.01.2026** (plan): VAT-czynni obowiązkowo.
- **01.07.2026** (plan): zwolnieni VAT.
- Faktury B2B wystawiane w KSeF w momencie wystawienia.

### Kasa fiskalna online

- Raport dobowy — automatycznie przesyłany po zamknięciu dnia.
- Raport miesięczny — do 25-go następnego miesiąca.

## Zestawiony kalendarz 2026

| Data | Obowiązek | Dla kogo |
|---|---|---|
| **2026-01-20** | Zaliczka PIT za grudzień 2025; ZUS DRA za styczeń | JDG |
| **2026-01-25** | JPK_V7M za grudzień 2025 | VAT |
| **2026-02-10** | ZUS DRA za styczeń (bez prac.) | JDG |
| **2026-02-20** | Zaliczka PIT za styczeń | JDG |
| **2026-02-25** | JPK_V7M za styczeń | VAT |
| **2026-03-10** | ZUS DRA za luty | JDG |
| **2026-04-10** | ZUS DRA za marzec | JDG |
| **2026-04-20** | Zaliczka PIT za marzec (kwartalne: za I kw.) | JDG |
| **2026-04-25** | JPK_V7M za marzec (lub V7K za I kw.) | VAT |
| **2026-04-30** | **PIT roczny 2025**: PIT-36, 36L, 28, 37, 38, 39 | Wszyscy |
| **2026-05-20** | **DRA za luty** (roczne rozliczenie składki zdrowotnej 2025) | JDG |
| **2026-07-20** | Zaliczka PIT za II kw. 2026 (kwartalne) | JDG |
| **2026-10-20** | Zaliczka PIT za III kw. | JDG |
| **2027-01-31** | **PIT-11** za 2026 dla pracowników | Pracodawcy |

## Kary i odsetki

### Odsetki za zwłokę (art. 53-56 Ordynacji)

```
Stawka = 200% × stopa redyskonta NBP + 2%
```

**Minimum:** 11,5% rocznie (szczególny przepis).

Odsetki nalicza się **od dnia następnego po terminie** do dnia zapłaty.

```
Odsetki = Zaległość × Stawka × Dni / 365
```

### Kary z KKS

- **Art. 56** — podanie nieprawdy: grzywna (do 500 stawek dziennych) lub ograniczenie wolności.
- **Art. 57** — brak wpłaty: grzywna.
- **Art. 60** — złożenie deklaracji po terminie: grzywna.

**Stawka dzienna 2026** (orient.): ~135 zł.
- Grzywna 500 stawek = ~67 500 zł.

### Czynny żal (art. 16 KKS)

Uchronienie przed odpowiedzialnością karnoskarbową, jeśli:
1. Korekta złożona przed wezwaniem US.
2. Zaległość wraz z odsetkami wpłacona niezwłocznie.
3. Pismo "Czynny żal" złożone z korektą.

## Co jeżeli pominę termin

### Jednorazowo, bez dużej zaległości

- Złóż deklarację + zapłać od razu.
- Odsetki naliczane automatycznie.
- Brak grzywny (przy dobrej wierze, niezwłocznie).

### Z opóźnieniem powyżej 1-2 miesięcy

- Złóż deklarację + zapłać.
- Złóż **czynny żal** do naczelnika US.
- Chroni przed KKS.

### Notoryczne opóźnienia

- Kontrola US.
- Grzywna.
- Utrata formy opodatkowania (np. automatyczne przejście na skalę z ryczałtu za 2 kwartały zaległości).

## Elektroniczne składanie

### e-US (e-Urząd Skarbowy)

- [podatki.gov.pl/e-urzad-skarbowy](https://www.podatki.gov.pl/e-urzad-skarbowy).
- Logowanie: profil zaufany / e-dowód / bank / podpis kwalifikowany.
- Składanie JPK_V7, PIT, VAT-R, VAT-Z.

### e-PUE ZUS

- [zus.pl → e-PUE](https://www.zus.pl).
- DRA, RCA, RSA, rozliczenie składki zdrowotnej.

### KSeF

- [ksef.mf.gov.pl](https://ksef.mf.gov.pl).
- Faktury B2B.

### Aplikacja Klient JPK

- Bezpłatne narzędzie MF do ręcznego JPK dla małych podatników.

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Złożenie JPK_V7 po 25-tym | Grzywna + odsetki | Wcześniej, najlepiej do 20-go |
| Opóźnienie zaliczki PIT | Odsetki od 21-go | Płacić na czas |
| Zapomniane PIT-11 dla pracownika | Kara 500 zł per pracownik | Do 31 stycznia |
| Brak rozliczenia rocznej zdrowotnej | Utrata zwrotu | DRA do 20 maja |
| PIT-38 pominięte, bo "nic nie zyskałem" | Brak możliwości przenoszenia straty | Składać nawet ze stratą |
| Błędne rozpoznanie "małego podatnika" dla kwartalnego JPK | Wezwanie do miesięcznego | Sprawdzać limit 2 mln EUR corocznie |

## Ograniczenia

- Kalendarze dla specyficznych branż (górnictwo, paliwa, hazard, akcyza) — różnią się.
- Intrastat, JPK_KR — dla większych podatników, osobne reguły.
- KSeF wprowadzenie — weryfikować aktualny stan (było przesuwane).
