---
name: faktura-korygujaca-workflow
description: Use when issuing Polish faktura korygująca. Covers in-minus corrections (rabat, zwrot), in-plus corrections, technical corrections, mandatory content, confirmation rules, KSeF handling, JPK_V7 treatment.
---

# faktura-korygująca-workflow

Skill — kompletny procedurowy przewodnik wystawiania i obsługi faktur korygujących w Polsce.

## Kluczowe źródła

- **Ustawa o VAT**:
  - Art. 29a ust. 13-16 — obniżenie podstawy opodatkowania.
  - Art. 106j — faktury korygujące.
  - Art. 88 ust. 3a pkt 4 — utrata prawa do odliczenia VAT przy niezgodnej korekcie.

## Kiedy wystawia się korektę

### In minus (zmniejszenie podstawy)

- **Zwrot towaru** przez nabywcę.
- **Rabat** / bonus po wystawieniu faktury.
- **Obniżenie ceny** z uzasadnionych przyczyn.
- **Zwrot zaliczki**.
- **Błąd w kwocie** (zawyżenie).

### In plus (zwiększenie podstawy)

- **Podwyższenie ceny** (zmiana umowy).
- **Dodatkowa usługa / towar** objęty tą samą fakturą.
- **Błąd w kwocie** (zaniżenie).

### Techniczna korekta (bez zmiany VAT)

- Błąd w nazwie / adresie / NIP nabywcy.
- Błąd w numerze faktury.
- Błąd w datach.

## Obowiązkowe elementy (art. 106j ust. 2)

1. **"KOREKTA"** lub **"FAKTURA KORYGUJĄCA"**.
2. Numer kolejny.
3. Data wystawienia.
4. **Dane pierwotnej faktury**: numer + data.
5. **Imiona / nazwy i adresy** sprzedawcy i nabywcy (jak w pierwotnej).
6. **Przyczyna korekty**.
7. **Kwoty przed**, **po**, **różnica** — dla każdej pozycji i ogółem.
8. Podpis (tradycyjnie; elektronicznie — przez KSeF lub podpis kwalifikowany).

## Moment rozliczenia w JPK_V7

### In minus (najważniejsze!)

**Art. 29a ust. 13 VAT:** obniżenie podstawy rozlicza się w okresie, w którym **sprzedawca uzyskał potwierdzenie odbioru** korekty przez nabywcę.

**Formy potwierdzenia:**
- Podpis nabywcy na papierowej kopii korekty.
- E-mail z potwierdzeniem otrzymania.
- UPO KSeF (urzędowe poświadczenie odbioru) — dla korekt w KSeF.
- Posiadanie **dokumentów uzasadniających** (art. 29a ust. 15 — przepisy od 2022 zliberalizowały).

**Wyjątek:** dla eksportu, WDT, usług dla UE B2B — bez potwierdzenia (od razu w okresie wystawienia).

### In plus

**Art. 29a ust. 17:** rozliczenie w okresie wystawienia korekty (gdy sprzedawca dowiedział się o okoliczności).

Jeśli przyczyna korekty **istniała już wtedy** (błąd w pierwotnej) → rozliczenie za okres **pierwotnej faktury** (korekta JPK wstecz).

Jeśli przyczyna **powstała później** (zmiana warunków umowy) → rozliczenie za okres **korekty**.

### Techniczna (bez VAT)

- Bez zmiany VAT — tylko poprawienie danych.
- Zazwyczaj nie wymaga korekty JPK.

## Liberalizacja od 2022 — potwierdzenie odbioru

**Od 01.01.2022** art. 29a ust. 15 zmieniony:

Nie wymaga się **fizycznego potwierdzenia odbioru** korekty, jeśli sprzedawca ma:
- Dokumenty potwierdzające uzgodnienie warunków obniżenia (e-mail, podpisany aneks, zapis w systemie).
- Dokumenty potwierdzające fakt obniżenia (np. przelew zwrotny, nota kredytowa).
- Potwierdzenie otrzymania towaru zwrotnego / świadczenia usług (w zakresie umożliwiającym weryfikację).

**Efekt:** rozliczenie korekty możliwe **bez czekania** na formalne potwierdzenie — jeśli masz dowody uzgodnienia.

## Wzorzec korekty in minus

```
                          FAKTURA KORYGUJĄCA

Numer:  FV-KOR/2026/04/001                    Data wystawienia: 20.04.2026

Dotyczy faktury:  FV/2026/04/001 z dnia 10.04.2026

PRZYCZYNA KOREKTY:
Udzielenie rabatu 10% z tytułu zapłaty przed terminem.

SPRZEDAWCA: [jak w fakturze pierwotnej]
NABYWCA:    [jak w fakturze pierwotnej]

┌────┬──────────────────────────────────────────┬─────────────┬──────────────┬──────────────┐
│ #  │ Pozycja                                  │ Przed       │ Po           │ Różnica      │
├────┼──────────────────────────────────────────┼─────────────┼──────────────┼──────────────┤
│ 1  │ Usługi programistyczne — kwiecień 2026   │ 24 000,00   │ 21 600,00    │ -2 400,00    │
└────┴──────────────────────────────────────────┴─────────────┴──────────────┴──────────────┘

Podsumowanie:
                               Przed           Po              Różnica
Netto (23%)                    24 000,00       21 600,00       -2 400,00
VAT 23%                         5 520,00        4 968,00         -552,00
Brutto                         29 520,00       26 568,00       -2 952,00

ROZLICZENIE:
Zmniejszenie podstawy opodatkowania: 2 400,00 PLN
Zmniejszenie VAT należnego:            552,00 PLN
Do zwrotu nabywcy:                   2 952,00 PLN

Potwierdzenie:
• Warunki obniżenia uzgodnione: e-mail z dnia 18.04.2026.
• Zwrot kwoty: przelew na rachunek nabywcy z dnia 21.04.2026.

Wystawił: Jan Kowalski              Otrzymał: __________________
         (podpis)                           (podpis nabywcy)
```

## Wzorzec korekty in plus

```
                          FAKTURA KORYGUJĄCA

Numer:  FV-KOR/2026/05/001                    Data wystawienia: 05.05.2026

Dotyczy faktury:  FV/2026/04/001 z dnia 10.04.2026

PRZYCZYNA KOREKTY:
Podwyższenie wynagrodzenia o dodatkowe 40 godzin pracy zrealizowanej
w ramach tego samego zlecenia, uzgodnione aneksem nr 2 z dnia 02.05.2026.

SPRZEDAWCA: [...]
NABYWCA:    [...]

┌────┬──────────────────────────────────────────┬─────────────┬──────────────┬──────────────┐
│ #  │ Pozycja                                  │ Przed       │ Po           │ Różnica      │
├────┼──────────────────────────────────────────┼─────────────┼──────────────┼──────────────┤
│ 1  │ Usługi programistyczne — kwiecień 2026   │ 24 000,00   │ 30 000,00    │ +6 000,00    │
│    │ (podwyższenie o 40 godzin × 150 zł)      │             │              │              │
└────┴──────────────────────────────────────────┴─────────────┴──────────────┴──────────────┘

                               Przed           Po              Różnica
Netto (23%)                    24 000,00       30 000,00       +6 000,00
VAT 23%                         5 520,00        6 900,00       +1 380,00
Brutto                         29 520,00       36 900,00       +7 380,00

DOPŁATA do zapłaty: 7 380,00 PLN.
Termin zapłaty: 19.05.2026.

Wystawił: Jan Kowalski
```

## Wzorzec korekty technicznej (bez zmiany kwoty)

```
                          FAKTURA KORYGUJĄCA

Numer:  FV-KOR/2026/04/002                    Data wystawienia: 25.04.2026

Dotyczy faktury:  FV/2026/04/001 z dnia 10.04.2026

PRZYCZYNA KOREKTY:
Błąd w nazwie nabywcy — poprawienie "ACME Sp. z o." na "ACME Sp. z o.o.".

Pozycje i kwoty bez zmian.

Dane sprzedawcy:    [bez zmian]
Dane nabywcy (po korekcie): ACME Sp. z o.o. (NIP 987-65-43-210)

Wystawił: Jan Kowalski
```

## KSeF i korekty

### Dla faktur w KSeF

1. W panelu KSeF → "Wystaw korektę".
2. Wybrać pierwotną fakturę.
3. Wprowadzić zmiany.
4. Podać przyczynę.
5. System nadaje **numer KSeF korekty** + **UPO**.
6. Nabywca otrzymuje w swoim KSeF automatycznie.

### UPO jako potwierdzenie odbioru

- **UPO KSeF** to **urzędowe poświadczenie odbioru** faktury/korekty.
- Traktowane przez MF jako potwierdzenie odbioru przez nabywcę.
- **Nie wymaga osobnego potwierdzenia** od nabywcy.

### Dla pierwotnej poza KSeF, korekta w KSeF

- Możliwe, ale komplikacja.
- Wzorzec referencji: `Dotyczy faktury nr [...] z dnia [...], wystawionej poza KSeF`.

## Rozliczenie w JPK_V7

### In minus — w miesiącu potwierdzenia odbioru

JPK_V7 zawiera pole **K_27 (Korekta sprzedaży in minus)**:

```
<SprzedazWiersz>
  ...
  <K_19>-2400.00</K_19>  <!-- netto (z minusem!) -->
  <K_20>-552.00</K_20>   <!-- VAT -->
  <TypDokumentu>KOREKTA</TypDokumentu>
</SprzedazWiersz>
```

Lub w deklaracyjnej części: pole K_27.

### In plus — w miesiącu wystawienia (lub pierwotnej, jeśli błąd od początku)

Analogicznie, z dodatnimi kwotami.

### Korekta JPK wstecz

Jeśli przyczyna korekty istniała od początku (np. błąd obliczeniowy) → **korekta JPK_V7** za miesiąc pierwotnej faktury.

Składamy korektę JPK w e-US.

## Korekta a czynny żal

Jeśli korekta ujawnia niedopłatę podatku (in plus → dopłata VAT):

- Złożyć **czynny żal** (art. 16 § 1 KKS) razem z korektą.
- Wpłacić niedopłatę + odsetki.
- Chroni przed grzywną.

Szablon czynnego żalu — w skillu `pl:reporting-deadlines-pl`.

## Scenariusze

### Scenariusz 1: Rabat po zapłacie

**Sytuacja:**
- 10.04.2026: wystawiona FV/2026/04/001 na 29 520 brutto (24 000 netto + 5 520 VAT 23%).
- 18.04.2026: klient zapłacił całą kwotę.
- 20.04.2026: udzielasz rabat 10% retroaktywnie.

**Kroki:**
1. Wystaw FV-KOR/2026/04/001 na −2 952 brutto.
2. Wyślij nabywcy (e-mail, KSeF).
3. Zwróć 2 952 na jego rachunek.
4. Zbieraj dowody:
   - E-mail z warunkami rabatu.
   - Potwierdzenie wykonania zwrotu.
5. Rozlicz korektę w JPK_V7 za **kwiecień** (lub maj, w zależności od daty uzyskania dowodów).

### Scenariusz 2: Zwrot towaru

**Sytuacja:**
- Kwiecień: sprzedaż towaru za 10 000 netto + 2 300 VAT = 12 300 brutto.
- Maj: klient zwraca z powodu wady.

**Kroki:**
1. Otrzymaj towar z dokumentem WZ / protokółem zwrotu.
2. Wystaw FV-KOR na −10 000 netto (pełna korekta).
3. Zwróć 12 300 klientowi.
4. Zbieraj dowody:
   - Protokół zwrotu.
   - Przelew zwrotny.
5. Rozlicz in minus w JPK_V7 za maj.

### Scenariusz 3: Błąd w NIP nabywcy

**Sytuacja:**
- FV/2026/04/001 wystawiona z NIP 987-65-43-210 (prawidłowy).
- ale w adresie błąd literowy.

**Decyzja:** techniczna korekta (nie zmienia VAT).

**Kroki:**
1. FV-KOR z poprawnym adresem.
2. Bez zmian kwotowych.
3. Bez korekty JPK (VAT się nie zmienia).

**Alternatywa:** **nota korygująca** (wystawia nabywca, nie sprzedawca) — dla drobnych błędów bez wpływu na VAT. Ale dla błędów sprzedawcy (po jego stronie) — korekta faktury, nie nota.

### Scenariusz 4: Zawyżenie ceny (in plus)

**Sytuacja:**
- Kwiecień: FV/2026/04/001 na 24 000 netto.
- Maj: aneks → dodatkowo 40 godzin × 150 zł = 6 000 netto więcej.

**Kroki:**
1. Wystaw FV-KOR/2026/05/001 na +6 000 netto.
2. Klient dopłaca 7 380 brutto.
3. Rozlicz w JPK_V7 za maj (okres wystawienia korekty, przyczyna powstała później).

**Alternatywa:** zamiast korekty — wystawić **osobną fakturę** FV/2026/05/042 na dodatkową usługę. Często prostsze.

### Scenariusz 5: Wielokrotne korekty tej samej faktury

Każda korekta odnosi się do **pierwotnej** faktury (FV/2026/04/001), nie do poprzedniej korekty.

Każda korekta zmienia wartości kumulatywnie.

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Korekta in minus bez dowodów / potwierdzenia | US odmawia korekty VAT | Zbierać dowody uzgodnienia |
| Referencja do pierwszej korekty zamiast pierwotnej | Zagmatwanie | Zawsze do pierwotnej faktury |
| Brak przyczyny korekty | Niezgodna z art. 106j | Obowiązkowa treść |
| Rozliczenie in minus w miesiącu wystawienia (bez potwierdzenia) | Nieprawidłowe | W miesiącu uzyskania dowodów |
| Korekta dla błędu typu in plus wstecznie bez korekty JPK | Kontrola | Jeśli błąd od początku — korekta JPK |
| Wystawienie korekty bez zwrotu pieniędzy / przelewu dowodowego | Utrudnienie udowodnienia | Zawsze zwrot / potwierdzenie |

## Narzędzia

### Programy księgowe

- **iFirma, wFirma, Fakturownia, InFakt** — wszystkie mają moduł faktur korygujących.
- Automatyzacja: wybieranie pierwotnej → edycja → nowa korekta.

### KSeF

- "Wystaw korektę" po wybraniu pierwotnej.
- System generuje XML FA_KOR.

## Ograniczenia

- Nota korygująca vs faktura korygująca — rozróżniać (nota = po stronie nabywcy, dla drobnych błędów bez VAT).
- Dla faktur pro forma (proforma) — nie ma korekty, tylko nowa proforma.
- Dla B2C (bez NIP) — reguły odmienne, często bez formalnej korekty.
- Dla faktur VAT marża — specjalne reguły.
