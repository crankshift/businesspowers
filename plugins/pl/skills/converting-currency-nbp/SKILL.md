---
name: converting-currency-nbp
description: Use when converting foreign currency to PLN for Polish tax purposes — art. 11a (PIT general) and art. 24a (PIT for crypto) require NBP average rate from the preceding business day. Covers official NBP rate archive, API pattern (api.nbp.pl), handling weekends and holidays (use last working day rate), historical rates lookup. Common mistake of using transaction-day rate, average yearly rate, or year-end rate instead of preceding-business-day rate per each operation.
---

# converting-currency-nbp

Przeliczenie walut obcych na PLN dla celów polskiego podatku dochodowego.

## Reguła

**Art. 11a ust. 1 ustawy o PIT:**

> "Przychody w walutach obcych przelicza się na złote według kursu średniego ogłaszanego przez Narodowy Bank Polski z **ostatniego dnia roboczego poprzedzającego dzień uzyskania przychodu**."

**Art. 24a** — tożsamy przepis dla krypto.

## Kluczowe

- **Kurs średni NBP** (tabela A).
- Z **dnia roboczego poprzedzającego** operację.
- Dla przychodu: dzień uzyskania przychodu = dzień wpływu środków / moment realizacji transakcji (trade date).
- Dla kosztu: dzień poniesienia kosztu = data zakupu.

## Źródła

### Strona NBP

[nbp.pl/kursy](https://www.nbp.pl/kursy/kursya.html) — tabela A (średnia).

### API NBP (bez klucza)

```
https://api.nbp.pl/api/exchangerates/rates/a/{waluta}/{data}/?format=json
```

Przykład:
```
https://api.nbp.pl/api/exchangerates/rates/a/USD/2025-05-14/?format=json
```

Zwraca:
```json
{
  "table": "A",
  "currency": "dolar amerykański",
  "code": "USD",
  "rates": [
    {"no": "092/A/NBP/2025", "effectiveDate": "2025-05-14", "mid": 4.0567}
  ]
}
```

### Za zakres dat

```
https://api.nbp.pl/api/exchangerates/rates/a/USD/{start}/{end}/?format=json
```

## Weekend / święto

Jeśli operacja wypada w **sobotę, niedzielę, święto** — użyj kursu z **ostatniego dnia roboczego**.

### Przykład

- Sprzedaż akcji w **sobotę 17.05.2025** (niemożliwa, giełdy zamknięte, ale dywidenda?).
- Kurs NBP z **piątku 16.05.2025** (ostatni dzień roboczy).

**API zwraca 404** dla daty z wolnego — trzeba iterować wstecz.

### Algorytm w pseudokodzie

```python
def nbp_rate(date, currency):
    while True:
        response = api_nbp(date, currency)
        if response.status == 200:
            return response.rate
        date = previous_day(date)
```

## Zdarzenia — dzień uzyskania przychodu

### Sprzedaż papieru wartościowego

- **Trade date** (data zawarcia transakcji).
- Settlement date (T+2 zwykle) — **nie** używa się jako dnia uzyskania.

### Dywidenda

- Dzień wpłynięcia na konto brokera / wpłaty.
- Zwykle = "payment date" brokera.

### Odsetki bankowe

- Dzień kapitalizacji.

### Wynagrodzenie z zagranicy

- Dzień wpłynięcia na konto polskie (lub zagraniczne dostępne).

### Sprzedaż krypto

- Dzień wykonania transakcji na giełdzie.

## Przykłady

### Przykład 1: Dywidenda Apple

**Sytuacja:** Apple wypłacił dywidendę $120 dnia **15.05.2025 (czw)**.

- Dzień roboczy poprzedzający: **14.05.2025 (śr)**.
- Kurs NBP z 14.05.2025: **3,95 PLN/USD** (przykład).
- Brutto PLN: 120 × 3,95 = **474 PLN**.

### Przykład 2: Sprzedaż akcji w poniedziałek

**Sytuacja:** sprzedaż 10 × AAPL dnia **15.09.2025 (pn)**.

- Dzień roboczy poprzedzający: **12.09.2025 (pt)**.
- Kurs z 12.09: 3,90.
- 10 × 220 × 3,90 = **8 580 PLN**.

### Przykład 3: Dywidenda w niedzielę

**Sytuacja:** ETF wypłacił dywidendę z datą nominalną **2025-08-17 (nd)**.

- Dni robocze poprzedzające: 15.08 (piątek, święto Wniebowzięcia NMP), 14.08 (czw).
- Pierwszy dzień z kursem: **14.08.2025**.
- Kurs: 3,98.

### Przykład 4: Sprzedaż krypto w sobotę

**Sytuacja:** sprzedaż BTC dnia **2025-07-12 (sb)**.

- Poprzedzający dzień roboczy: **11.07.2025 (pt)**.
- Kurs USD: 4,00.
- Cena rynkowa BTC na 12.07 (nie używamy w wzorze, ale potrzebna dla określenia ilości dolarów).

### Przykład 5: Dochód z pracy zdalnej

**Sytuacja:** wynagrodzenie $5 000 wpłynęło **02.01.2026 (pt)**.

- Dni robocze poprzedzające: 31.12.2025 (śr — dzień roboczy; 01.01 święto), ale sprawdzamy najbliższy.
- Kurs NBP z **31.12.2025 (śr)**: 4,10.
- PLN: 5 000 × 4,10 = **20 500 PLN**.

## Kurs NBP vs kurs banku

- Bank konwertuje waluty (np. SWIFT-em) **wg własnego kursu** (często odchyla się od NBP o 0,5-2%).
- **Dla celów PIT — używa się KURSU NBP**, nie bankowego.
- Różnice kursowe (bank daje mniej niż NBP) — poza PIT (to "ryzyko walutowe"; mogłoby wpływać na koszty działalności JDG, ale dla PIT-38 osoby fizycznej jest bez znaczenia).

## Dla JDG vs osoby fizycznej

### Osoba fizyczna (PIT-38, PIT-37, PIT-36 ogólny)

**Art. 11a:** kurs NBP z poprzedzającego dnia roboczego.

### JDG

**Art. 11a ust. 2 (szczegółowe):** kurs NBP z dnia operacji lub dnia ostatniego (zależnie od typu).

Dla JDG **na rzecz zaliczek PIT** — taki sam jak dla osób fizycznych (poprzedzający dzień roboczy).

### Krypto

**Art. 24a ust. 6:** kurs NBP z poprzedzającego dnia roboczego.

## Dla VAT

**Art. 31a ust. 1 ustawy o VAT:** kurs NBP z **dnia poprzedzającego wystawienie faktury** (!).

Inaczej niż dla PIT! W VAT — dzień wystawienia faktury decyduje.

## Waluty nienotowane przez NBP

NBP notuje ~40 głównych walut. Dla **rzadkich** (np. nigeryjska naira NGN):

**Art. 11a ust. 3:** kurs kraju, w którym waluta ma obieg — zwykle przez **cross-rate przez USD**:

```
NGN → PLN = NGN × (1 / NGN_per_USD) × USD_per_PLN
```

Źródła: OANDA, XE.com, banki centralne.

## Kursy średnie w praktyce — 2025 (orient.)

| Data | USD | EUR | GBP | CHF |
|---|---|---|---|---|
| 15.01.2025 | 4,10 | 4,35 | 5,10 | 4,55 |
| 15.03.2025 | 4,00 | 4,30 | 5,05 | 4,45 |
| 15.05.2025 | 3,95 | 4,30 | 5,00 | 4,40 |
| 15.07.2025 | 3,90 | 4,25 | 4,95 | 4,35 |
| 15.09.2025 | 3,95 | 4,30 | 5,00 | 4,40 |
| 15.11.2025 | 4,00 | 4,30 | 5,05 | 4,45 |

**(Orientacyjne; używać aktualnych z api.nbp.pl.)**

## Algorytm

```python
def convert_to_pln(amount_foreign, currency, operation_date):
    # Znajdź poprzedzający dzień roboczy
    check_date = operation_date - 1 day

    while True:
        rate = fetch_nbp_rate(currency, check_date)
        if rate exists:
            break
        check_date -= 1 day

    return amount_foreign * rate
```

## Automatyzacja

### W Excel

```excel
=VLOOKUP(data_poprzedzajaca, tabela_kursow_NBP, kolumna_kursu, FALSE) * kwota_USD
```

Wymaga pobrania historii kursów.

### Python

```python
import requests

def get_nbp_rate(currency, date):
    url = f"https://api.nbp.pl/api/exchangerates/rates/a/{currency}/{date}/?format=json"
    r = requests.get(url)
    if r.status_code == 200:
        return r.json()['rates'][0]['mid']
    return None

def get_rate_preceding_business_day(currency, date):
    from datetime import timedelta
    d = date - timedelta(days=1)
    while True:
        rate = get_nbp_rate(currency, d.isoformat())
        if rate:
            return rate, d
        d -= timedelta(days=1)
```

### Excel + VBA

```vb
Function GetNBPRate(currency As String, targetDate As Date) As Double
    Dim d As Date
    d = targetDate - 1
    ' Try API; jeśli nie ma, iteruj
    ' ...
End Function
```

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Kurs NBP z dnia operacji | Inny wynik | Dzień **poprzedzający** |
| Średnioroczny kurs | Ogromna różnica | Kurs per operacja |
| Kurs banku / brokera | Inna wartość niż NBP | Zawsze NBP |
| Nie iteruje wstecz przy weekendzie | Brak kursu | Poprzedni dzień roboczy |
| Kurs w VAT z dnia wpływu | Inne reguły | VAT: dzień wystawienia faktury |
| Waluta nienotowana przez NBP | Błąd konwersji | Cross-rate przez USD |

## Ograniczenia

- Dla transakcji intraday (wielu w ciągu dnia) — wystarczy jeden kurs dziennie.
- Odstępstwa dla transakcji na zasadzie "swap spotów" (forex) — złożone.
- NBP publikuje **2 tabele**: A (średnia, dla PIT/CIT) i B (wąska kwoty, dla banków). **Używaj A**.
