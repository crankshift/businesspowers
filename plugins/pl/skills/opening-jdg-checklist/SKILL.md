---
name: opening-jdg-checklist
description: Use when opening JDG in Poland. Covers step-by-step checklist for CEIDG-1 registration, PKD selection, tax form, ZUS regime, VAT-R, bank account, profil zaufany, KSeF setup, kasa fiskalna, post-registration verification.
---

# opening-jdg-checklist

Pełna checklista otwarcia JDG w Polsce. Skill podaje gotową listę zadań od przygotowania po pierwszy dzień działalności.

## Kluczowe źródła

- **Ustawa o CEIDG** (Dz.U. 2018 poz. 647).
- **Prawo przedsiębiorców** (Dz.U. 2018 poz. 646).
- **Ustawa o PIT**, **VAT**, **USUS**, **ustawa o ryczałcie**.

## Kanały rejestracji

| Kanał | Czas | Koszt | Wymagania |
|---|---|---|---|
| **CEIDG online** | 10 min + 1 dzień akceptacji | 0 zł | Profil zaufany / e-dowód / podpis kwalifikowany |
| **Urząd gminy** (papierowy) | 1 dzień roboczy | 0 zł | Dowód osobisty, PESEL |
| **Notariusz** | 1 dzień | 100-300 zł | Dowód + opłata |

## Etap 0. Przygotowanie (1-3 dni przed)

### Dokumenty i dane

- [ ] Dowód osobisty / e-dowód z NFC.
- [ ] PESEL.
- [ ] NIP (jeśli masz wcześniej).
- [ ] Adres zamieszkania (z meldunku).
- [ ] Adres głównego miejsca wykonywania działalności (może być tożsamy z zamieszkania).
- [ ] Numer telefonu, e-mail.

### Profil zaufany

- [ ] Jeśli nie masz — założyć przez **bankowość internetową** (większość banków obsługuje, np. mBank, ING, Pekao, PKO BP).
- [ ] Alternatywnie przez **mObywatel** + e-dowód.
- [ ] Alternatywnie stawiennictwo w urzędzie gminy.

### Wybór PKD

- [ ] Określić główny PKD.
- [ ] Dodatkowe PKD (dowolnie).
- [ ] Weryfikacja: czy są w wykluczeniach ryczałtu (art. 8)?

Skill: `pkd-codes-reference`.

### Wybór formy opodatkowania

Skill: `choosing-tax-form` lub agent: `pl:tax-form-advisor`.

- [ ] Skala / liniowy / ryczałt / karta?
- [ ] Dla ryczałtu — czy PKD dozwolony?
- [ ] Dla liniowego / ryczałtu — 2-letni zakaz z byłym pracodawcą?

### Wybór reżimu ZUS

Skill: `calculating-zus` lub agent: `pl:zus-agent`.

- [ ] Ulga na start (6 mies.): czy kwalifikuje się?
- [ ] Mały ZUS (24 mies.): tak / nie.
- [ ] Duży ZUS od razu: tak / nie.
- [ ] Chorobowa 2,45% dobrowolna: TAK (zalecam).

### Wybór VAT

- [ ] Zwolnienie podmiotowe do 200k (art. 113 ust. 1)?
- [ ] Dobrowolna rejestracja (duże zakupy z VAT)?
- [ ] Obowiązkowa (PKD wymagające VAT: doradztwo, prawne, jubilerstwo)?

### Bank

- [ ] Wybrać bank firmowy: ING, mBank, Millennium, Santander, Pekao, Nest, BNP Paribas, PKO BP.
- [ ] Porównać koszty: prowadzenie konta, przelewy, karty, waluty obce.

## Etap 1. Składanie wniosku

### Przez CEIDG online

1. [ ] Wejść na [biznes.gov.pl/pl/firma/ceidg](https://www.biznes.gov.pl/pl/firma/ceidg).
2. [ ] "Załóż firmę" lub "Rozpocznij działalność".
3. [ ] Zaloguj się profilem zaufanym / e-dowodem / podpisem kwalifikowanym.
4. [ ] Wypełnić wniosek **CEIDG-1**:
   - Dane osobowe (auto z PESEL).
   - Data rozpoczęcia działalności.
   - Adres głównego miejsca.
   - PKD (główny + dodatkowe).
   - **Forma opodatkowania** (ważne!).
   - **Zgłoszenie do ZUS** (odpowiedni reżim: ZUA / ZZA).
   - **VAT-R** (wersja uproszczona — można dołączyć albo osobno).
   - Numer rachunku bankowego (można uzupełnić później).
5. [ ] Podpis elektroniczny (profil zaufany / e-dowód / certyfikat).
6. [ ] Wyślij.
7. [ ] Wpis w CEIDG: zwykle w ciągu **1 dnia roboczego**.

### Przez urząd gminy

1. [ ] Umówić wizytę lub przyjść z dokumentami.
2. [ ] Wypełnić CEIDG-1 papierowy (może pomóc urzędnik).
3. [ ] Podpisać w obecności urzędnika.
4. [ ] Razem z CEIDG-1: opcjonalnie VAT-R i formularze ZUS.
5. [ ] Wpis w CEIDG: **1 dzień roboczy**.

## Etap 2. Weryfikacja rejestracji

### Sprawdzenie CEIDG

- [ ] Wpis w CEIDG: [biznes.gov.pl/pl/firma/ceidg](https://www.biznes.gov.pl/pl/firma/ceidg) → wyszukiwarka.
- [ ] Stan: "Aktywna".
- [ ] Poprawność danych: PKD, adres, forma opodatkowania.

### Sprawdzenie ZUS

- [ ] [zus.pl](https://www.zus.pl) → e-PUE ZUS → zalogowanie profilem zaufanym.
- [ ] Status ubezpieczeń: zarejestrowany od dnia X.
- [ ] Kody ubezpieczeń:
  - 05 10 — JDG z ubezpieczeniami społecznymi.
  - 05 11 — JDG + chorobowa.
  - 05 70 — JDG tylko zdrowotna (Ulga na start).
  - 05 82 — JDG Mały ZUS Plus.

### Sprawdzenie VAT (jeśli VAT-czynny)

- [ ] Biała lista VAT: [podatki.gov.pl/wykaz-podatnikow-vat-wyszukiwarka/](https://www.podatki.gov.pl/wykaz-podatnikow-vat-wyszukiwarka/).
- [ ] Wprowadzić NIP → sprawdzić status.

## Etap 3. Otwarcie rachunku bankowego

- [ ] Bank firmowy (lub osobisty z opcją JDG).
- [ ] Dokumenty: CEIDG-1 lub wpis z CEIDG, dowód.
- [ ] Można online (ING, mBank, Santander, Millennium) lub w oddziale.
- [ ] **Zgłosić numer rachunku** do CEIDG (aktualizacja wpisu) — automatycznie trafia na białą listę VAT.

### Biała lista VAT

- [ ] Po 1-7 dniach zweryfikować, czy rachunek jest na białej liście.
- [ ] Jeśli nie — **interwencja w banku** i US.

## Etap 4. Certyfikat / podpis

### Dla KSeF (od 2026) i deklaracji podatkowych

- [ ] **Profil zaufany** — wystarczy dla e-US i eksportu CEIDG.
- [ ] **Podpis kwalifikowany** — jeśli planujesz intensywne korzystanie z KSeF (integracja automatyczna).
- [ ] **Certyfikat KSeF** — pobierany z KSeF po autoryzacji profilem zaufanym lub podpisem.

## Etap 5. KSeF — Krajowy System e-Faktur

### Od 01.01.2026 (plan — weryfikować)

- [ ] Zarejestrować się w [ksef.mf.gov.pl](https://ksef.mf.gov.pl).
- [ ] Autoryzacja: profil zaufany / podpis kwalifikowany.
- [ ] Wybór metody wystawiania faktur:
  - Panel KSeF (ręczne).
  - API programu księgowego (Comarch, iFirma, wFirma, Fakturownia).

### Do momentu KSeF

- [ ] Wybór programu do fakturowania:
  - **iFirma, wFirma, Fakturownia** — popularne dla JDG.
  - **Comarch ERP Optima** — dla większych biznesów.
  - **InFakt** — dla freelancerów.
  - Bezpłatne: **Fakturownia** (do 3 faktur/mies), **wFirma demo**.

## Etap 6. Kasa fiskalna (jeśli obowiązkowa)

### Kiedy obowiązkowa

- Sprzedaż B2C > 20 000 zł rocznie.
- PKD obowiązkowe: taksówki, alkohol, tytoń, jubilerstwo, kosmetyka, elektronika.

### Wybór kasy

- **Kasa online** (z CRK) — obowiązkowa w większości branż od 2020-2023.
- **Koszt**: 2 000-5 000 zł + opłaty serwisowe.
- **Ulga na zakup**: **1 000 zł zwrotu** dla pierwszej kasy (art. 111 ust. 4 VAT).

### Rejestracja

1. Zakup kasy z autoryzowanego punktu.
2. Zgłoszenie do US (przed rozpoczęciem używania).
3. Fiskalizacja przez autoryzowany serwis.
4. Pierwsze użycie → zgłoszenie danych do CRK.

## Etap 7. Dodatkowe

### RODO / GIODO

- [ ] Jeśli przetwarzasz dane osobowe (klienci, pracownicy) — obowiązki RODO.
- [ ] Polityka prywatności, zgody, obowiązki informacyjne.
- [ ] Nie trzeba rejestrować do UODO (od 2018 obowiązek rejestracji zniesiony).

### Licencje i zezwolenia

- [ ] Jeśli PKD wymaga — oddzielne procedury (transport, alkohol, ochrona, etc.).

### Zezwolenia lokalowe

- [ ] Gastronomia — sanepid.
- [ ] Salon kosmetyczny — sanepid.
- [ ] Zakład produkcyjny — pozwolenia budowlane i środowiskowe.

## Etap 8. Pierwsze działania

- [ ] Wystawienie pierwszej faktury (test).
- [ ] Zapłacenie pierwszej składki ZUS (automatycznie pobierana z konta).
- [ ] Zapis pierwszej operacji w ewidencji (KPiR dla skali/liniowego, ewidencja przychodów dla ryczałtu).

## Check-list po pierwszym miesiącu

- [ ] Pierwsza faktura wystawiona i zapisana.
- [ ] Składki ZUS za pierwszy miesiąc zapłacone.
- [ ] VAT JPK za pierwszy miesiąc (jeśli VAT-czynny) przygotowany do wysłania do 25-go.
- [ ] Zaliczka PIT za pierwszy miesiąc (jeśli na zaliczkach miesięcznych) zapłacona do 20-go.

## Po pierwszym kwartale

- [ ] Przejrzeć ewidencję — czy wszystko się zgadza?
- [ ] Jeśli na kwartalnych zaliczkach PIT — zapłacić do 20-go po kwartale.

## Przykład hronologii IT-developera

| Dzień | Akcja |
|---|---|
| D-3 | Przygotowanie: weryfikacja PESEL, profil zaufany, wybór PKD 62.01.Z |
| D-2 | Decyzja o formie: ryczałt 12% |
| D-1 | Decyzja o ZUS: Mały ZUS (preferencyjny) + chorobowa |
| D0 | CEIDG-1 online (10 min) |
| D1 | Wpis w CEIDG; otrzymanie NIP jako JDG |
| D2 | Otwarcie rachunku firmowego w mBank Business |
| D3 | Zgłoszenie rachunku do CEIDG (aktualizacja wpisu) |
| D4 | Weryfikacja białej listy VAT (jeśli VAT-czynny) |
| D5 | Rejestracja w Fakturownia, wystawienie pierwszej faktury |
| D15 | Wpłata pierwszej składki ZUS |

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Nie wybrano formy w CEIDG-1 | Auto: skala (może nie być optymalne) | Świadomy wybór |
| Ryczałt dla PKD zakazanego (art. 8) | Wezwanie US + opodatkowanie skalą | Sprawdzić listę wyłączeń |
| Przychód >200k, bez VAT-R | Obowiązek + kara | VAT-R przed przekroczeniem limitu |
| Nie otwarto firmowego rachunku | Płatności >15k bez białej listy | Firmowy rachunek |
| Ulga na start dla usług byłemu pracodawcy | Utrata prawa + dopłata | 2-letni zakaz |
| Zapomniano chorobowa | Brak zasiłków | Wybór chorobowej 2,45% |
| Kasa fiskalna spóźniona | Kara 100-300% obrotu | Przed pierwszą sprzedażą B2C > 20k |

## Po rejestracji — miesięczne obowiązki

- **10-go**: ZUS DRA + składki (bez pracowników) lub **15-go** (z pracownikami).
- **20-go**: Zaliczka PIT (miesięczna) lub ewidencja przychodów kwartalna.
- **25-go**: JPK_V7M i zapłata VAT (jeśli VAT-czynny).
- **31 stycznia**: PIT-11 dla pracowników.
- **30 kwietnia**: PIT-36/36L/28 roczny.
- **20 maja**: DRA roczna z rozliczeniem składki zdrowotnej.

## Ograniczenia

- Nie obejmuje specjalnych form dla rolników, wolnych zawodów, spółek cywilnych.
- Dla zagranicznych rezydentów → różne wymagania.
- Wprowadzenie KSeF może być przesunięte — weryfikować.
