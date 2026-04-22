---
name: fetching-ceidg
description: Use when interacting with Polish CEIDG (Centralna Ewidencja i Informacja o Działalności Gospodarczej) — rejestracja (CEIDG-1), aktualizacja wpisu (zmiana adresu, PKD, formy opodatkowania, rachunku bankowego), zawieszenie (do 24 miesięcy bez pracowników; nieograniczone dla JDG bez pracowników), wznowienie, wykreślenie. Portal biznes.gov.pl/pl/firma/ceidg. Wyszukiwanie przedsiębiorców po NIP, nazwie lub PESEL (choć PESEL nie publicznie). Uprawnienie odbioru pism do CEIDG (elektroniczne korespondencje z urzędami przez profil zaufany). Integracja z e-US, ZUS, VAT-R — dane z CEIDG-1 idą automatycznie do organów.
---

# fetching-ceidg

Skill — praca z CEIDG (Centralna Ewidencja i Informacja o Działalności Gospodarczej), portalem biznes.gov.pl i wyszukiwarką przedsiębiorców.

## Kluczowe źródła

- **Ustawa o CEIDG** (Dz.U. 2018 poz. 647).
- **Prawo przedsiębiorców** (Dz.U. 2018 poz. 646).
- Portal: [biznes.gov.pl/pl/firma/ceidg](https://www.biznes.gov.pl/pl/firma/ceidg).
- API CEIDG: [dane.biznes.gov.pl](https://dane.biznes.gov.pl) (otwarte dane).

## Funkcje CEIDG

### 1. Rejestracja — CEIDG-1 (nowa działalność)

**Dla kogo:** osoba fizyczna rozpoczynająca JDG.

**Krok po kroku:**

1. [biznes.gov.pl/pl/firma/ceidg](https://www.biznes.gov.pl/pl/firma/ceidg).
2. "Rozpocznij działalność" / "Załóż firmę".
3. Zaloguj się — profil zaufany / e-dowód / podpis kwalifikowany.
4. Wypełnij formularz:
   - Dane osobowe (auto z PESEL).
   - Data rozpoczęcia.
   - Główny adres działalności.
   - Dodatkowe miejsca (opcjonalnie).
   - PKD (główny + dodatkowe).
   - **Forma opodatkowania** (skala / liniowy / ryczałt / karta).
   - **Zgłoszenie do ZUS** (kod reżimu).
   - **VAT-R** (jeśli VAT-czynny od początku).
   - Numer rachunku bankowego (można dodać później).
5. Podpis elektroniczny.
6. Wyślij.
7. **Wpis w CEIDG: 1 dzień roboczy.**

### 2. Aktualizacja — CEIDG-1 (zmiana)

**Kiedy:**
- Zmiana adresu (zamieszkania, głównego miejsca działalności).
- Dodanie / usunięcie PKD.
- Zmiana formy opodatkowania (do 20 lutego kolejnego roku).
- Zmiana nazwy firmy.
- Zmiana rachunku bankowego.
- Zmiana statusu VAT.
- Zgłoszenie pełnomocnika.

**Jak:**
1. Zalogować.
2. "Zmień wpis" / "Aktualizuj dane".
3. Wypełnić tylko pola do zmiany.
4. Podpis.
5. Wpis zmieniony: 1 dzień roboczy.

### 3. Zawieszenie

**Dla kogo:**
- JDG **bez pracowników** — nieograniczony czas.
- JDG **z pracownikami** — do **24 miesięcy**.

**Warunki:**
- Nie masz otwartych zobowiązań wobec pracowników.
- Nie planujesz wykonywać działalności.

**Jak:**
1. CEIDG-1 → "Zawieszenie działalności".
2. Data rozpoczęcia zawieszenia.
3. Podpis.
4. Wpis: następnego dnia roboczego.

**Skutki:**
- **Zwolnienie z ZUS społecznego** (emerytalna, rentowa).
- **Zdrowotna niepłacona** z JDG (ale potrzebujesz innego tytułu ubezpieczenia — etat, KRUS, rodzina).
- VAT nadal aktywny (JPK z zerami).
- Nie wystawiasz faktur.

### 4. Wznowienie

- CEIDG-1 → "Wznowienie".
- Data wznowienia.
- Wpis: natychmiastowy.

### 5. Wykreślenie (zamknięcie)

- CEIDG-1 → "Wykreślenie".
- Data zakończenia działalności.
- Wpis: 1 dzień roboczy.

### 6. Dziedziczenie działalności — zarząd sukcesyjny

**Ustawa o zarządzie sukcesyjnym** (Dz.U. 2018 poz. 1629).

- Spadkodawca wyznacza zarządcę sukcesyjnego za życia.
- Spadkobiercy mogą dalej prowadzić JDG po śmierci (max 2 lata).
- Procedura przez CEIDG.

## Wyszukiwanie w CEIDG

### Publiczna wyszukiwarka

[prod.ceidg.gov.pl/ceidg/ceidg.public.ui/Search.aspx](https://prod.ceidg.gov.pl/ceidg/ceidg.public.ui/Search.aspx)

**Szukanie po:**
- NIP (dokładnie).
- REGON.
- Nazwa firmy.
- Imię i nazwisko (tylko ogólnie, nie szczegółowo dostępne dla każdego).
- Adres.
- PKD.

**Widoczne dane:**
- NIP, REGON, nazwa firmy.
- Status (aktywna / zawieszona / wykreślona).
- Adres głównego miejsca działalności.
- PKD (główny + dodatkowe).
- Data rozpoczęcia / zawieszenia / wykreślenia.

**Ukryte dane:**
- PESEL.
- Adres zamieszkania (w wielu przypadkach).
- Szczegóły zgłoszeń do ZUS / VAT (te są w innych rejestrach).

### Alternatywne bazy

- **Biała lista VAT** ([podatki.gov.pl](https://www.podatki.gov.pl/wykaz-podatnikow-vat-wyszukiwarka/)) — status VAT + rachunek.
- **REGON** ([stat.gov.pl](https://bip.stat.gov.pl)) — inny widok.
- **VIES** (UE) — weryfikacja VAT-UE.

### API CEIDG (open data)

- [dane.biznes.gov.pl](https://dane.biznes.gov.pl) — bulk data.
- API dla masowego pobierania (wymaga rejestracji).
- Nieużywane dla pojedynczych weryfikacji.

## Autentykacja

### Profil zaufany

**Najbardziej uniwersalny, bezpłatny.**

**Założenie:**
- Przez bankowość internetową (mBank, ING, Pekao, PKO BP, Santander i inne).
- Przez urząd gminy (stacjonarnie).

**Ważność:** 3 lata, odnawiany automatycznie.

### e-dowód

**Dowód osobisty z warstwą elektroniczną** (od 2019).

**Wymagania:**
- Czytnik NFC (w telefonie).
- Aplikacja mObywatel.
- Kod PIN (wybrany przy wydaniu).

### Podpis kwalifikowany

**Płatny** (~300 zł/rok).

**Dla kogo:**
- Osoby prawne (spółki) — wymagany.
- JDG — tylko jeśli intensywnie korzystasz z KSeF lub innych systemów wymagających.

### Bankowość internetowa (dla logowania)

Banki obsługują logowanie do gov.pl / podatki.gov.pl:
- mBank, ING, Pekao, PKO BP, Santander, Millennium, BNP Paribas, Citi, Credit Agricole.

## Integracja CEIDG z innymi rejestrami

Z CEIDG-1 dane są przekazywane **automatycznie**:

1. **US (Urząd Skarbowy)** — nadanie NIP (jeśli nie ma) + wybór formy opodatkowania.
2. **ZUS** — zgłoszenie ubezpieczeniowe.
3. **GUS (REGON)** — wpis w rejestrze statystycznym.
4. **VAT** (jeśli VAT-R) — rejestracja VAT.

**Efekt:** jednokrotne złożenie CEIDG-1 = rejestracja w 4 systemach.

## Dodatkowe funkcje biznes.gov.pl

### Szablony umów

[biznes.gov.pl/pl/firma](https://www.biznes.gov.pl/pl/firma) → Wzory umów.

**Dostępne:**
- Umowa o pracę.
- Umowa B2B.
- Umowa zlecenia.
- Umowa o dzieło.
- NDA.
- Umowa spółki cywilnej.

### Kalkulator kosztów JDG

- Szacowanie składek ZUS, PIT, składki zdrowotnej.
- Dostępny dla skali, liniowego, ryczałtu.

### Wniosek o interpretację indywidualną KIS

- Prezentacja stanu faktycznego → interpretacja.
- Koszt: 40 zł opłaty.
- Termin odpowiedzi: 3 miesiące.

### Grantfoundy i dofinansowania

- Przegląd aktualnych programów wsparcia.
- "Doskonały Start", "Wsparcie Bezzwrotne", dotacje z PARP.

## Wsparcie

### Telefon

- **Centrum Informacji dla Przedsiębiorcy**: **801 055 055** (z PL) lub **+48 22 765 67 32** (z zagranicy).
- **Dni robocze 8:00-18:00**.

### Czat online

- [biznes.gov.pl](https://www.biznes.gov.pl) → czat w prawym dolnym rogu (w godzinach pracy).

### E-mail

- Dedykowane formularze kontaktowe.

## Typowe scenariusze

### Scenariusz 1: Rejestracja JDG

- Patrz skill `opening-jdg-checklist`.

### Scenariusz 2: Zmiana adresu

1. Zalogowanie w biznes.gov.pl.
2. Mój biznes → Mój wpis.
3. Aktualizuj dane → zmiana adresu.
4. Nowy adres → podpis → wyślij.
5. Aktualizacja: 1 dzień roboczy.

**Uwaga:** zmiana adresu **dostarcza** organom (US, ZUS) automatycznie.

### Scenariusz 3: Dodanie PKD

1. Zalogowanie.
2. Mój biznes → Aktualizuj dane → PKD.
3. Dodaj nowy kod.
4. Podpis → wyślij.

**Uwaga:** jeśli dodasz PKD zakazany dla ryczałtu — utracisz ryczałt.

### Scenariusz 4: Zmiana formy opodatkowania

1. **Tylko do 20 lutego** kolejnego roku.
2. Mój biznes → Aktualizuj dane → Forma opodatkowania.
3. Wybór: skala / liniowy / ryczałt.
4. Podpis → wyślij.

### Scenariusz 5: Weryfikacja kontrahenta

1. Wyszukiwarka CEIDG: [prod.ceidg.gov.pl](https://prod.ceidg.gov.pl/ceidg/ceidg.public.ui/Search.aspx).
2. Wpisz NIP.
3. Status: "Aktywna" / "Wykreślona" / "Zawieszona".

### Scenariusz 6: Odbiór pism przez CEIDG

**Od 2018** — elektroniczne doręczenia w CEIDG (za zgodą):

1. Zgoda w CEIDG-1 na elektroniczne doręczenia.
2. Pisma z US, ZUS przychodzą do CEIDG (link w profilu zaufanym / e-mail).
3. Odbiór: kliknięcie "Odbierz" w portalu.
4. **Nie odbiór przez 14 dni = "fikcja doręczenia"** (uznaje się za doręczone).

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Brak aktualizacji adresu po przeprowadzce | Pisma idą na stary adres → pominięcie terminów | Zaktualizować w CEIDG |
| Dodanie PKD zakazanego dla ryczałtu | Utrata prawa do ryczałtu | Sprawdzić art. 8 ustawy o ryczałcie |
| Zmiana formy po 20 lutego | Wniosek nieuwzględniony | Tylko w styczniu / do 20 lutego |
| Zawieszenie przy aktywnych pracownikach | Ograniczenie 24 miesiące | Zawieszenie po zwolnieniu pracowników |
| Brak weryfikacji kontrahenta | Ryzyko fikcyjnego NIP | Zawsze sprawdzić biała lista VAT + CEIDG |

## Różnice — CEIDG vs KRS

- **CEIDG** — osoby fizyczne (JDG).
- **KRS** (Krajowy Rejestr Sądowy) — spółki (z o.o., S.A., jawne, komandytowe).

JDG **nie** zmienia się w spółkę przez CEIDG — to osobna procedura (zamknięcie JDG + otwarcie spółki w KRS).

## Ograniczenia

- CEIDG dla **osób fizycznych**; spółki → KRS.
- Nie obsługuje skomplikowanych sytuacji prawnych (spór, windykacja).
- Ustawy sukcesyjne — osobna procedura w CEIDG.
