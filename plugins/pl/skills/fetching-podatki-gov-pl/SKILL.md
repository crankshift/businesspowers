---
name: fetching-podatki-gov-pl
description: Use when retrieving information from podatki.gov.pl and e-Urząd Skarbowy. Covers tax rates, forms, interpretacje KIS, mikrorachunek lookup, biała lista VAT, taxpayer verification, URL patterns.
---

# fetching-podatki-gov-pl

Skill — praca z oficjalnym portalem Ministerstwa Finansów (`podatki.gov.pl`), e-Urzędem Skarbowym (e-US) i portalem interpretacji KIS (`eureka.mf.gov.pl`).

## Główne zasoby

### 1. podatki.gov.pl — główny portal MF

**Adres:** [podatki.gov.pl](https://www.podatki.gov.pl).

Struktura:
- **Aktualności** — nowości, zmiany prawa.
- **Podatki** (PIT, CIT, VAT, akcyza, ...) — wyjaśnienia per rodzaj.
- **Informator podatnika** — przewodniki dla osób fizycznych, JDG.
- **e-Urząd Skarbowy** — logowanie do e-US.
- **KSeF** — portal e-Faktur.
- **Biała lista VAT** — wyszukiwarka.
- **Formularze** — wszystkie PIT-y, VAT-y, ZUS...

### 2. e-Urząd Skarbowy

**Adres:** [podatki.gov.pl/e-urzad-skarbowy](https://www.podatki.gov.pl/e-urzad-skarbowy).

**Funkcje:**
- Składanie deklaracji PIT, JPK_V7, VAT-R, VAT-Z.
- "Twój e-PIT" — wstępnie wypełnione zeznania.
- Konto podatkowe (bilans, mikrorachunek).
- Wiadomości z US.
- Wnioski o zaświadczenia.

### 3. eureka.mf.gov.pl — KIS interpretacje

**Adres:** [eureka.mf.gov.pl](https://eureka.mf.gov.pl).

**Co tu jest:**
- **Interpretacje indywidualne** (IPI) wydawane przez Dyrektora Krajowej Informacji Skarbowej (KIS).
- **Interpretacje ogólne** MF.
- **Broszury informacyjne**.

**Jak szukać:**
- Wyszukiwarka po słowach kluczowych.
- Filtrowanie: rodzaj podatku, data.
- Pełny tekst interpretacji.

### 4. KSeF — Krajowy System e-Faktur

**Adres:** [ksef.mf.gov.pl](https://ksef.mf.gov.pl).

**Funkcje:**
- Wystawianie i odbiór faktur B2B.
- Autoryzacja (profil zaufany, podpis, certyfikat KSeF).
- Integracja z programami księgowymi (Comarch, iFirma, wFirma...).

### 5. Biała lista VAT

**Adres:** [podatki.gov.pl/wykaz-podatnikow-vat-wyszukiwarka/](https://www.podatki.gov.pl/wykaz-podatnikow-vat-wyszukiwarka/).

**Funkcja:**
- Weryfikacja kontrahenta po NIP / REGON / nazwie.
- Status VAT (czynny / zwolniony / wykreślony).
- **Numer rachunku** zgłoszony przez podatnika.

**Użycie:**
- Przelewy > 15 000 zł **muszą** trafić na rachunek z białej listy (pod rygorem utraty kosztu).

## Częste scenariusze

### Scenariusz 1: Sprawdzić aktualną stawkę PIT

**Pytanie:** "Jaka jest kwota wolna w PIT na 2026?"

**Akcja:**
1. `podatki.gov.pl` → "PIT" → "Skala podatkowa 2026".
2. Alternatywa: ustawa o PIT art. 27 → isap.sejm.gov.pl.

**Odpowiedź 2026:** 30 000 zł (kwota wolna), 12% / 32% próg 120 000 zł.

### Scenariusz 2: Pobrać formularz

**Pytanie:** "Potrzebuję PIT-36L za 2025."

**Akcja:**
1. `podatki.gov.pl` → Formularze → PIT → PIT-36L.
2. Formularz interaktywny (e-US) lub PDF do wypełnienia ręcznego.

### Scenariusz 3: Znaleźć interpretację

**Pytanie:** "Jak KIS traktuje mining BTC u osoby fizycznej?"

**Akcja:**
1. `eureka.mf.gov.pl` → wyszukiwarka.
2. Słowa kluczowe: "mining bitcoin", "waluta wirtualna", "kopanie".
3. Filtrowanie: PIT, ostatnie 3 lata.
4. Przeczytać kilka interpretacji (ocena tendencji).

### Scenariusz 4: Weryfikacja kontrahenta

**Pytanie:** "Czy firma ABC NIP 123-45-67-890 jest VAT-czynna?"

**Akcja:**
1. [Biała lista VAT](https://www.podatki.gov.pl/wykaz-podatnikow-vat-wyszukiwarka/).
2. NIP → wyszukaj.
3. Wynik:
   - Status (czynny / wykreślony / zwolniony).
   - Numer rachunku bankowego.
   - Data rejestracji VAT.

**Wydruk:** PDF (dowód weryfikacji — do archiwizacji, dla ochrony przed spornymi transakcjami > 15k).

### Scenariusz 5: Sprawdzić mikrorachunek podatkowy

**Pytanie:** "Na jaki rachunek wpłacić zaliczkę PIT?"

**Akcja:**
1. [podatki.gov.pl/indywidualne-konto-podatkowe/](https://www.podatki.gov.pl/indywidualne-konto-podatkowe/).
2. Wpisać PESEL lub NIP.
3. Wynik: indywidualny rachunek (20 znaków).

**Wzorzec:** `10 10 1000 [PESEL lub NIP] [cyfra kontrolna]`.

Wszystkie wpłaty (PIT, VAT, akcyza) **na ten rachunek** — ZUS osobnym kontem.

### Scenariusz 6: Złożyć PIT-38 roczny

**Akcja:**
1. Zalogować do e-US (podatki.gov.pl).
2. Autentykacja: profil zaufany / e-dowód / bank / podpis kwalifikowany.
3. "Złóż deklarację" → PIT-38.
4. Wypełnić ręcznie (PIT-38 nie jest wstępnie wypełniany).
5. Podpisać.
6. Wysłać.
7. Otrzymać UPO (urzędowe poświadczenie odbioru).

## Status interpretacji KIS

### Interpretacje indywidualne (IPI)

- **Wiążą tylko wnioskodawcę** (art. 14b § 1 Ordynacji).
- Dla innych — rekomendacyjne (pokazują aktualną praktykę).
- Pobieranie na konkretny stan faktyczny.

### Interpretacje ogólne MF

- Skierowane do **wszystkich** podatników.
- Wiążące dla organów w analogicznych sprawach.

### Broszury, wyjaśnienia

- **Nie** mają mocy prawnej.
- Kierunkowe — wskazują praktykę.

### Hierarchia zaufania

1. **Ustawa** (isap.sejm.gov.pl) — zawsze nadrzędna.
2. **Interpretacja ogólna MF**.
3. **IPI dla konkretnego podatnika** (jeśli ty jesteś wnioskodawcą).
4. **IPI innych** — praktyka orientacyjna.
5. **Broszury, wyjaśnienia** — dodatkowe.

**Uwaga:** interpretacje mogą być **zmienione, uchylone, zaktualizowane**. Sprawdzać datę.

## Typowe URL-e

### Formularze

```
https://www.podatki.gov.pl/pit/formularze/
https://www.podatki.gov.pl/vat/formularze/
```

### Interpretacje

```
https://eureka.mf.gov.pl/ — start
https://eureka.mf.gov.pl/informacje/podglad/[id] — konkretna interpretacja
```

### Stawki

```
https://www.podatki.gov.pl/pit/abc-pit/skala-podatkowa/
https://www.podatki.gov.pl/vat/abc-vat/stawki-vat/
```

### Wyjaśnienia KSeF

```
https://www.podatki.gov.pl/ksef/
```

### Mikrorachunek

```
https://www.podatki.gov.pl/indywidualne-konto-podatkowe/
```

## Weryfikacja informacji

### Dla stawek bieżących

- **Ustawa** (isap.sejm.gov.pl) — zawsze.
- **Obwieszczenia MF** (np. o minimalnym wynagrodzeniu) — corocznie.
- Oficjalne wyjaśnienia MF — aktualne.

### Dla interpretacji

- **Data** interpretacji.
- Czy **nie uchylona** (zakładka "zmiany").
- Czy **zgodna z aktualnym orzecznictwem NSA** (dla podatków, gdzie sądy często korygują KIS).

### Gdy niepewny

- **Interpretacja indywidualna** — wniosek do KIS (40 zł opłaty, 3 miesiące).
- **Konsultant podatkowy** — dla złożonych spraw.

## Co zawsze weryfikować

1. **Stawki** — corocznie się zmieniają.
2. **Progi ulg** (kwota wolna, minimalne wynagrodzenie, przeciętne).
3. **Termin obowiązywania** interpretacji.
4. **Status kontrahenta** w białej liście (na dzień transakcji).

## Mikrorachunek podatkowy — szczegóły

**Każdy podatnik** ma **jeden indywidualny rachunek** w US dla wszystkich rodzajów podatków (PIT, VAT, akcyza, CIT dla spółek).

**Format:**
```
10 10 1000 XXXX XXXX XXXX XXXX XX
```

Pierwsze 11 znaków: kod banku NBP (10 10 1000).
Następne: PESEL (11 cyfr) lub NIP (10 cyfr).
Cyfra kontrolna IBAN.

**Uwaga:** dla VAT ponad 15k — dodatkowo **split payment** (MPP) na osobny rachunek.

## Obsługa US przez e-US

### Komunikacja

- **Wiadomości** w e-US: US odpowiada na pisma tam.
- **Zaświadczenia** (o niezaleganiu, dochodach) — wniosek online, wynik zwykle w 7 dni.

### Zaległości

- Podgląd w "Stan rozliczeń".
- Odsetki naliczane automatycznie.

### Korekty

- "Złóż korektę deklaracji" — e-US udostępnia.
- Załączyć **czynny żal** (jeśli dotyczy — ochrona przed KKS).

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Polega się na interpretacji sprzed 5 lat | Starzeje się; może być uchylona | Weryfikować aktualną praktykę |
| Sprawdza biała listę przed transakcją, nie dokumentuje | Brak dowodu na dzień wpłaty | Pobrać wydruk / PDF |
| Korzysta z interpretacji innego podatnika | Nie wiąże US w twoim przypadku | Własna IPI dla pewności |
| Wpłaty na "ogólne konto US" | Nie do mikrorachunku → utracona | Zawsze na indywidualny mikrorachunek |
| Złożenie PIT w papierze | Odrzucone od 2021 (dla JDG) | Elektronicznie przez e-US |

## Ograniczenia

- `podatki.gov.pl` nie jest źródłem **normy prawnej** — norma w ustawach (isap.sejm.gov.pl).
- Interpretacje KIS mogą być **uchylone** przez sądy administracyjne (NSA, WSA).
- Niektóre formularze mają wiele wersji — używać **aktualnej** na dany rok.
- e-US czasem niedostępny (konserwacja weekend) — planować.
