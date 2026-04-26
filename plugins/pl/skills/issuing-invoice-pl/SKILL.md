---
name: issuing-invoice-pl
description: Use when issuing Polish invoices. Covers faktura VAT, rachunek, faktura walutowa, WDT/export 0%, zaliczkowa, uproszczona, obligatory content, MPP, GTU codes, KSeF integration, templates.
---

# issuing-invoice-pl

Skill — praktyczny przewodnik wystawiania polskich dokumentów sprzedaży z uwzględnieniem różnych statusów VAT i rodzajów transakcji.

## Kluczowe źródła

- **Ustawa o VAT** (Dz.U. 2004 nr 54 poz. 535):
  - Art. 106a-106n — faktury.
  - Art. 106e — obowiązkowe elementy.
  - Art. 106i — termin wystawienia.
  - Art. 106j — faktury korygujące.
  - Art. 108a-108c — MPP.
  - Art. 113 — zwolnienie podmiotowe.
- **Ustawa o KSeF** (Dz.U. 2023 poz. 2047).
- **Ordynacja podatkowa** — art. 86 (5 lat przechowywania).

## Typ dokumentu — wybór

| Scenariusz | Dokument |
|---|---|
| VAT-czynny + B2B PL | **Faktura VAT** + KSeF (od 2026) |
| VAT-czynny + B2C PL | Faktura VAT lub faktura uproszczona |
| VAT-czynny + B2B UE | Faktura VAT 0% (WDT) + VAT-UE |
| VAT-czynny + eksport | Faktura 0% eksportowa |
| Zwolniony z VAT | **Rachunek** |
| Zaliczka od klienta | Faktura zaliczkowa → po dostarczeniu faktura końcowa |
| Drobna sprzedaż < 450 zł brutto | Faktura uproszczona |

## Obowiązkowe elementy faktury VAT (art. 106e)

1. Data wystawienia.
2. Numer kolejny.
3. Imię/nazwa i adres sprzedawcy i nabywcy.
4. NIP sprzedawcy (w przypadku B2B — NIP nabywcy).
5. Data dokonania / zakończenia dostawy/usługi (jeśli różna od daty wystawienia).
6. Nazwa (rodzaj) towaru/usługi.
7. Miara i ilość.
8. Cena jednostkowa netto.
9. Kwoty rabatów.
10. Wartość netto.
11. Stawka VAT (23%, 8%, 5%, 0%, zw.).
12. Suma wartości netto per stawka.
13. Kwota VAT per stawka.
14. Kwota brutto ogółem.
15. Adnotacje (jeśli dotyczą):
    - "Mechanizm podzielonej płatności" / "MPP".
    - "Odwrotne obciążenie".
    - "Metoda kasowa".
    - "Samofakturowanie".

## Termin wystawienia (art. 106i)

- **Zasadniczy:** do **15-go dnia miesiąca** następującego po miesiącu dostawy/usługi.
- **Wyjątki:** dla zaliczek — do 15-go po miesiącu otrzymania zaliczki.
- **Wcześniej:** dopuszczalne 60 dni przed datą dostawy.

## 1. Faktura VAT — wzorzec pełny

```
═════════════════════════════════════════════════════════════════════════════════

                                    FAKTURA

Numer: FV/2026/04/001                         Data wystawienia: 10.04.2026
Miejsce wystawienia: Warszawa                 Data sprzedaży:   10.04.2026
                                              Termin płatności: 24.04.2026
                                              Sposób płatności: przelew

─────────────────────────────────────────────────────────────────────────────────
SPRZEDAWCA:                                   NABYWCA:
─────────────────────────────────────────────────────────────────────────────────
Jan Kowalski — Jednoosobowa Działalność       ACME Sp. z o.o.
Gospodarcza                                   ul. Piłsudskiego 5
ul. Marszałkowska 100/15                      00-002 Warszawa
00-001 Warszawa                               NIP: 987-65-43-210
NIP: 123-45-67-890                            KRS: 0000000000
IBAN: PL 12 1234 5678 9012 3456 7890 1234
Bank: ING Bank Śląski S.A.

─────────────────────────────────────────────────────────────────────────────────

┌────┬──────────────────────────────────────────┬────┬──────┬────────────┬────────┬──────────────┬──────────────┐
│ #  │ Nazwa towaru / usługi                    │ J. │ Il.  │ Cena netto │ VAT    │ Wart. netto  │ Kwota VAT    │
├────┼──────────────────────────────────────────┼────┼──────┼────────────┼────────┼──────────────┼──────────────┤
│ 1  │ Usługi programistyczne — kwiecień 2026   │ h  │ 160  │   150,00   │  23%   │  24 000,00   │    5 520,00  │
│    │ (backend Node.js, framework NestJS)      │    │      │            │        │              │              │
└────┴──────────────────────────────────────────┴────┴──────┴────────────┴────────┴──────────────┴──────────────┘

                                              Razem netto:                   24 000,00 PLN
                                              VAT 23%:                        5 520,00 PLN
                                              ═══════════════════════════════════════════
                                              BRUTTO DO ZAPŁATY:             29 520,00 PLN

                                              Słownie: dwadzieścia dziewięć tysięcy
                                                       pięćset dwadzieścia złotych 00/100.

Tytuł przelewu: FV/2026/04/001
Rachunek na białej liście VAT: TAK (na dzień wystawienia).

Wystawił(a): Jan Kowalski            Otrzymał(a): __________________
              (podpis)                           (podpis nabywcy)
```

## 2. Rachunek (dla VAT-zwolnionego)

```
                                    RACHUNEK

Numer: R/2026/04/001                          Data wystawienia: 10.04.2026
                                              Miejsce: Warszawa

WYSTAWCA:
Jan Kowalski — JDG
NIP: 123-45-67-890
ul. Marszałkowska 100/15, 00-001 Warszawa
IBAN: PL 12 1234 5678 9012 3456 7890 1234
Zwolniony z VAT podmiotowo (art. 113 ust. 1 ustawy o VAT).

ODBIORCA:
ACME Sp. z o.o.
NIP: 987-65-43-210
ul. Piłsudskiego 5, 00-002 Warszawa

┌────┬──────────────────────────────────────────┬──────┬─────────────┬──────────────┐
│ #  │ Usługa                                   │ Il.  │ Cena        │ Wartość      │
├────┼──────────────────────────────────────────┼──────┼─────────────┼──────────────┤
│ 1  │ Usługi konsultingowe — kwiecień 2026     │  1   │ 10 000,00   │ 10 000,00    │
└────┴──────────────────────────────────────────┴──────┴─────────────┴──────────────┘

DO ZAPŁATY:                                   10 000,00 PLN

Słownie: dziesięć tysięcy złotych 00/100.

Termin płatności: 24.04.2026.
Tytuł przelewu: "Rachunek R/2026/04/001".

Wystawca: Jan Kowalski     ________________
```

## 3. Faktura walutowa (EUR, klient UE — WDT)

```
                                    FAKTURA / INVOICE

Numer: FV/2026/04/002                         Data wystawienia: 12.04.2026
                                              Data sprzedaży:   12.04.2026
                                              Termin płatności: 26.04.2026

─────────────────────────────────────────────────────────────────────────────────
SPRZEDAWCA / SELLER:                          NABYWCA / BUYER:
─────────────────────────────────────────────────────────────────────────────────
Jan Kowalski — JDG                            ACME GmbH
NIP: 123-45-67-890                            VAT-UE: DE123456789
VAT-UE: PL1234567890                          Hauptstraße 5
ul. Marszałkowska 100/15                      10115 Berlin
00-001 Warszawa, Poland                       Germany
IBAN: PL 12 1234 5678 9012 3456 7890 1234
SWIFT/BIC: INGBPLPW

─────────────────────────────────────────────────────────────────────────────────

┌────┬──────────────────────────────────────────┬────┬──────┬────────────┬────────┬──────────────┬────────────┐
│ #  │ Nazwa / Description                      │ J. │ Il.  │ Cena netto │ VAT    │ Wart. netto  │ Kwota VAT  │
├────┼──────────────────────────────────────────┼────┼──────┼────────────┼────────┼──────────────┼────────────┤
│ 1  │ Usługi programistyczne / Software dev    │ h  │ 160  │   50,00    │  0%    │  8 000,00    │    0,00    │
│    │ services (April 2026)                    │    │      │            │  WDT   │              │            │
└────┴──────────────────────────────────────────┴────┴──────┴────────────┴────────┴──────────────┴────────────┘

                              Waluta / Currency:                              EUR
                              Razem netto / Total net:                        8 000,00
                              VAT 0% (WDT, reverse charge, art. 28b VAT):         0,00
                              ═══════════════════════════════════════════════════════════
                              DO ZAPŁATY / TOTAL DUE:                         8 000,00 EUR

                              Przeliczenie na PLN dla celów ewidencji (kurs NBP z 11.04.2026):
                              8 000 × 4,30 = 34 400,00 PLN

Uwagi / Notes:
• Transakcja wewnątrzwspólnotowa (WDT) — nabywca rozlicza VAT w swoim kraju (reverse charge).
• Transakcja zgłoszona w Informacji Podsumowującej VAT-UE do 25.05.2026.
• Płatność: SWIFT na wskazany rachunek, tytuł "FV/2026/04/002".

Wystawił: Jan Kowalski          Otrzymał: __________________
          (podpis)                         (signature)
```

## 4. Faktura eksportowa (klient poza UE)

```
                                    INVOICE / FAKTURA EKSPORTOWA

Number: FV/2026/04/003                        Issue date:     15.04.2026
Place:  Warszawa                              Delivery date:  15.04.2026
                                              Due date:       29.04.2026

─────────────────────────────────────────────────────────────────────────────────
FROM / SPRZEDAWCA:                            TO / NABYWCA:
─────────────────────────────────────────────────────────────────────────────────
Jan Kowalski                                  ACME Corporation
Sole Proprietorship (JDG)                     123 Main Street
Polish Tax ID (NIP): 123-45-67-890            San Francisco, CA 94105
100/15 Marszałkowska St., 00-001 Warsaw       United States
Poland                                        EIN: 12-3456789
IBAN: PL 12 1234 5678 9012 3456 7890 1234
SWIFT: INGBPLPW

─────────────────────────────────────────────────────────────────────────────────

┌────┬──────────────────────────────────────────┬─────┬────────────┬──────────────┐
│ #  │ Description                              │ Qty │ Rate (USD) │ Amount       │
├────┼──────────────────────────────────────────┼─────┼────────────┼──────────────┤
│ 1  │ Software development services            │ 160 │   50.00    │  8,000.00    │
│    │ (April 2026)                             │     │            │              │
└────┴──────────────────────────────────────────┴─────┴────────────┴──────────────┘

                              Currency:                                       USD
                              Subtotal net:                                8,000.00
                              VAT 0% — supplied outside EU                     0.00
                              (art. 28b of Polish VAT Act)
                              ═══════════════════════════════════════════════════════════
                              TOTAL DUE:                                   8,000.00 USD

                              PLN equivalent (NBP rate from 14.04.2026, 4.00):
                              8,000 × 4.00 = 32,000.00 PLN

Payment instructions:
  Beneficiary:        JAN KOWALSKI, Sole Proprietorship
  IBAN:               PL12 1234 5678 9012 3456 7890 1234
  Bank:               ING Bank Śląski S.A., Poland
  SWIFT/BIC:          INGBPLPW

  Correspondent bank (for USD transfers):
    Bank:             JPMorgan Chase Bank N.A., New York
    SWIFT:            CHASUS33

  Reference:          "FV/2026/04/003"

Signature: ________________    Jan Kowalski
Date:      15.04.2026
```

## 5. Faktura uproszczona (< 450 zł brutto, B2C)

**Art. 106e ust. 5:** uproszczona forma dla sprzedaży < **450 zł brutto**.

**Zawiera minimum:**
1. Data wystawienia.
2. Numer kolejny.
3. Dane sprzedawcy (imię, nazwa, NIP).
4. Nazwa towaru/usługi.
5. Kwota brutto (bez rozdziału netto/VAT — tylko kwoty należne).
6. Adnotacja "Faktura uproszczona" (opc.) lub NIP nabywcy jeśli podany.

**Uwaga:** faktura uproszczona nie daje nabywcy prawa do odliczenia VAT (brak VAT w treści).

## 6. Faktura zaliczkowa + końcowa

### Faktura zaliczkowa

- Wystawiana po otrzymaniu zaliczki (przedpłaty).
- Kwota zaliczki + VAT od zaliczki.
- Numer osobny: `FV-ZAL/2026/04/001`.

### Faktura końcowa

- Po wykonaniu usługi.
- Cała wartość − zapłacona zaliczka.
- W treści referencja do faktury zaliczkowej.

### Przykład

- Zamówienie 30 000 netto + 6 900 VAT = 36 900 brutto.
- Zaliczka 10 000 brutto → FV-ZAL na 10 000 brutto (8 130 netto + 1 870 VAT).
- Po wykonaniu — FV-KOŃCOWA na 36 900 brutto, z odliczeniem 10 000 (do zapłaty 26 900).

## Numeracja

### Rekomendowane formaty

- `FV/[rok]/[miesiąc]/[kolejny]` → `FV/2026/04/001`.
- `FV-KOR/2026/04/001` — korekta.
- `FV-ZAL/2026/04/001` — zaliczkowa.
- `R/2026/04/001` — rachunek.

### Zasady

- **Ciągła**, bez luk.
- **Unikalna** per rodzaj.
- **Z datami zgodnymi** (FV/04/... w kwietniu, nie w marcu).

## Adnotacje obowiązkowe

### "Mechanizm podzielonej płatności" / "MPP"

- Gdy faktura > **15 000 zł brutto** + towar/usługa z **załącznika 15 ustawy o VAT**.

### "Odwrotne obciążenie"

- WDT (art. 28b) dla usług B2B świadczonych dla UE podatnika VAT-UE.

### "Metoda kasowa"

- Dla małych podatników stosujących metodę kasową rozliczania VAT.

### "Samofakturowanie"

- Gdy faktura wystawiana przez nabywcę w imieniu sprzedawcy (na podstawie umowy).

### "Procedura marży"

- Dla towarów używanych, dzieł sztuki, przedmiotów kolekcjonerskich.

## KSeF — od 2026 (plan)

### Jak wystawić w KSeF

1. Logowanie: [ksef.mf.gov.pl](https://ksef.mf.gov.pl).
2. Autoryzacja: profil zaufany, podpis kwalifikowany, lub certyfikat KSeF.
3. **Wystaw fakturę** — wypełnić formularz lub zaimportować XML.
4. System generuje:
   - **Numer KSeF** (unikalny, nadany przez system).
   - **UPO** (urzędowe poświadczenie odbioru).
5. Faktura trafia do **KSeF nabywcy automatycznie**.
6. Format danych: **XML** (FA_VAT lub FA_KOR).

### Integracja z programami

- **iFirma**, **wFirma**, **Fakturownia**, **InFakt** — wszystkie wspierają KSeF.

### Tryb awaryjny

- Gdy KSeF niedostępny — faktura wystawiana poza KSeF.
- Po przywróceniu — zgłoszenie do KSeF w ciągu 7 dni.

### Wyjątki

- Faktury B2C — opcjonalnie w KSeF (nie obowiązek).
- Małe niektóre przypadki transgraniczne.

## Faktura korygująca

### Treść

```
                          FAKTURA KORYGUJĄCA

Numer: FV-KOR/2026/04/001                    Data wystawienia: 20.04.2026

Dotyczy faktury: FV/2026/04/001 z 10.04.2026 r.

PRZYCZYNA KOREKTY:
Udzielenie rabatu 10% z tytułu terminowej płatności.

SPRZEDAWCA: [...]      NABYWCA: [...]

┌────┬──────────────────────────────────────────┬─────────────┬──────────────┬──────────────┐
│ #  │ Pozycja                                  │ Przed       │ Po           │ Różnica      │
├────┼──────────────────────────────────────────┼─────────────┼──────────────┼──────────────┤
│ 1  │ Usługi programistyczne — kwiecień 2026   │ 24 000,00   │ 21 600,00    │ -2 400,00    │
└────┴──────────────────────────────────────────┴─────────────┴──────────────┴──────────────┘

Netto przed:    24 000,00     Netto po:   21 600,00     Różnica: -2 400,00
VAT przed:       5 520,00     VAT po:      4 968,00     Różnica:   -552,00
Brutto przed:   29 520,00     Brutto po:  26 568,00     Różnica: -2 952,00

Wystawca: ________________    Nabywca: ________________
```

## Przeliczenie walut

**Art. 31a ust. 1 ustawy o VAT:** kurs średni NBP z **dnia poprzedzającego wystawienie faktury**.

**UWAGA:** inny niż dla PIT (tam poprzedzający dzień transakcji)!

```
Jeśli faktura wystawiona 10.04.2026:
  Dla VAT (kurs NBP) → z 09.04.2026.
```

## Archiwizacja

**5 lat** od końca roku podatkowego (art. 86 Ordynacji).

**Formy:**
- Papierowo z podpisami.
- Elektronicznie (PDF + podpis kwalifikowany + znacznik czasu).
- W KSeF — automatycznie.

## Typowe scenariusze

### Scenariusz 1: IT developer, pierwsza faktura dla klienta z USA

**Profil:** JDG na ryczałcie 12%, zwolniony podmiotowo z VAT.

**Decyzja:** **rachunek** (JDG bez VAT).

**Szablon:** "Rachunek" (powyżej) z tabelą w USD + przeliczenie PLN dla PIT-28.

### Scenariusz 2: VAT-czynny JDG, usługi dla niemieckiej spółki

**Decyzja:** **Faktura VAT 0% (WDT)**.

**Wymagania:**
- VAT-UE na stronie obu.
- Stawka 0%.
- Adnotacja "Reverse charge" lub "Odwrotne obciążenie".
- Zgłoszenie w informacji VAT-UE do 25-go.

### Scenariusz 3: Sprzedaż elektroniki B2B za 20 000 zł brutto

**MPP obowiązkowy!**

**Faktura:**
- Stawka 23%.
- Adnotacja "Mechanizm podzielonej płatności".
- GTU_06 w JPK_V7.

**Klient:** płaci komunikatem MPP (netto → zwykły rachunek, VAT → rachunek VAT).

### Scenariusz 4: Zaliczka 5 000 zł

- **FV-ZAL/2026/04/001** na 5 000 brutto.
- Po wykonaniu → **FV-KOŃCOWA** na całą wartość minus zaliczka.

### Scenariusz 5: Korekta in minus (rabat)

1. Wystaw FV-KOR.
2. Wyślij nabywcy.
3. **Czekaj na potwierdzenie odbioru** (podpis, UPO KSeF, e-mail).
4. Rozlicz korektę w JPK_V7 w miesiącu potwierdzenia odbioru.

## Programy do wystawiania

### Bezpłatne (lub tanie)

- **Fakturownia** — bezpłatnie do 3 faktur/mies.
- **InFakt** — od 29 zł/mies; pełna obsługa.
- **wFirma** — popularna, od 35 zł/mies.
- **iFirma** — od 29 zł/mies.

### Dla większych

- **Comarch ERP Optima** — bogata funkcjonalność, od 100 zł/mies.
- **Comarch ERP XT** — dla średnich.
- **Sage Symfonia** — duża.

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Brak NIP nabywcy w B2B | Nieważna faktura | Zawsze NIP dla VAT-czynnych B2B |
| Brak adnotacji MPP przy > 15k + zał. 15 | Sankcja 30% VAT | Zawsze oznaczać |
| Brak VAT-UE przy WDT | Opodatkowanie 23% | Zgłosić VAT-UE przed transakcją |
| Rachunek z adnotacją "VAT 0%" | Myląca treść | Rachunek = bez VAT (nie 0%) |
| Numeracja z przerwami | Kontrola US | Ciągła |
| Kurs NBP z dnia transakcji dla VAT | Błąd | Dla VAT — dzień poprzedzający wystawienie |
| Korekta in minus bez potwierdzenia odbioru | Nieskuteczna | Zbierać potwierdzenia |

## Ograniczenia

- Dla specyficznych branż (nieruchomości, VAT marża, VAT turystyka) — odrębne reguły.
- KSeF wciąż ewoluuje — weryfikować aktualny stan.
- Import/eksport fizyczny towarów — dodatkowe dokumenty (CMR, SAD).
