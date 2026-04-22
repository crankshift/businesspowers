---
name: parsing-bank-statements-pl
description: Use when parsing Polish bank statements for JDG reconciliation — covers ING Business, mBank Biznes, Santander Biznes, PKO BP iPKO Biznes, Pekao24, Millennium, BNP Paribas, Nest Bank. Standard formats MT940 (SWIFT), CSV, Excel, XML-CAMT.053. Extract incoming payments (date, amount, counterparty, description, reference), filter out intra-account transfers, bank fees, and FX conversions. Match payments to invoices by extracting invoice number from description using regex. Convert foreign currency income at NBP rate from preceding business day (per art. 11a ustawy o PIT). Reconcile against JPK_V7 sales (VAT-czynni) and PIT annual declaration.
---

# parsing-bank-statements-pl

Skill — praktyczne podejście do parsowania wyciągów bankowych polskich banków dla celów księgowych JDG.

## Polskie banki dla JDG — porównanie formatów

| Bank | Format wyciągu | API |
|---|---|---|
| **ING Business Online** | MT940, CSV, PDF | ING API Business (REST) |
| **mBank Biznes** | MT940, CSV, PDF, XML | API mBank (płatne) |
| **Santander Biznes** | MT940, CSV, PDF | Santander One API |
| **PKO BP iPKO Biznes** | MT940, CSV, PDF | PKO API |
| **Pekao24 / Pekao Biznes** | MT940, CSV | Ograniczone API |
| **Millennium** | MT940, CSV | Millennium Business API |
| **BNP Paribas** | MT940, CSV | BNP API |
| **Nest Bank** | CSV, PDF | Nest Biznes API |

## Format MT940 — standard SWIFT

### Struktura

```
:20:NR_REFERENCYJNY
:25:PL12123456789012345678901234
:28C:001/01
:60F:C240401PLN500000,00
:61:2604100410C29520,00NTRFFV/2026/04/001
:86:ACME Sp. z o.o.
FV/2026/04/001 — zapłata za usługi
NIP: 987-65-43-210
:61:2604120412D2500,00NTRFFEE
:86:Opłata transakcyjna
:62F:C260430PLN527020,00
```

### Kluczowe tagi

| Tag | Opis |
|---|---|
| `:20:` | Numer referencyjny wyciągu |
| `:25:` | Numer rachunku (IBAN) |
| `:28C:` | Numer kolejny wyciągu |
| `:60F:` | Saldo otwarcia |
| `:61:` | Operacja (data + C/D + kwota + kod) |
| `:86:` | Opis operacji (kontrahent, tytuł) |
| `:62F:` | Saldo zamknięcia |

### Parsing w Python

```python
import re
from datetime import datetime

def parse_mt940(content):
    transactions = []
    current_tx = None
    
    for line in content.split('\n'):
        line = line.strip()
        
        if line.startswith(':61:'):
            # Zapis operacji
            if current_tx:
                transactions.append(current_tx)
            
            # Format: YYMMDD[MMDD]C/D<AMOUNT>N<TYPE><REFERENCE>
            match = re.match(r':61:(\d{6})(\d{4})?([CD])([\d,]+)(N\w{3})?(\S*)', line)
            if match:
                date_str, _, sign, amount_str, _, reference = match.groups()
                current_tx = {
                    'date': datetime.strptime(date_str, '%y%m%d'),
                    'direction': 'IN' if sign == 'C' else 'OUT',
                    'amount': float(amount_str.replace(',', '.')),
                    'reference': reference,
                    'description': '',
                }
        
        elif line.startswith(':86:') and current_tx:
            current_tx['description'] = line[4:]
        
        elif current_tx and line and not line.startswith(':'):
            # Kontynuacja :86:
            current_tx['description'] += ' ' + line
    
    if current_tx:
        transactions.append(current_tx)
    
    return transactions
```

## CSV — najpopularniejszy

### ING Business CSV (uproszczony)

```csv
Data operacji;Data księgowania;Rachunek nadawcy/odbiorcy;Nazwa nadawcy/odbiorcy;Tytuł;Kwota;Waluta;Saldo
2026-04-10;2026-04-10;PL987654321098765432109876;ACME Sp. z o.o.;FV/2026/04/001;29520,00;PLN;527020,00
2026-04-12;2026-04-12;;;Opłata transakcyjna;-2,50;PLN;527017,50
```

### mBank Biznes CSV

```csv
#Data operacji;#Data waluty;#Opis operacji;#Tytuł;#Nadawca/Odbiorca;#Numer konta;#Kwota;#Saldo po operacji
"2026-04-10";"2026-04-10";"Przelew przychodzący";"FV/2026/04/001";"ACME Sp. z o.o.";"PL98765432...";"29520,00 PLN";"527020,00 PLN"
```

### Parsing uniwersalny

```python
import pandas as pd

def load_bank_csv(filepath, bank):
    if bank == 'ING':
        df = pd.read_csv(filepath, sep=';', decimal=',', encoding='cp1250')
        df = df.rename(columns={
            'Data operacji': 'date',
            'Nazwa nadawcy/odbiorcy': 'counterparty',
            'Tytuł': 'description',
            'Kwota': 'amount',
        })
    elif bank == 'mBank':
        df = pd.read_csv(filepath, sep=';', decimal=',', encoding='cp1250', skiprows=32)
        # mBank ma kilka wierszy nagłówka
        df = df.rename(columns={
            '#Data operacji': 'date',
            '#Nadawca/Odbiorca': 'counterparty',
            '#Tytuł': 'description',
            '#Kwota': 'amount_str',
        })
        # Parse "29520,00 PLN"
        df['amount'] = df['amount_str'].str.extract(r'([-\d,]+)')[0].str.replace(',', '.').astype(float)
        df['currency'] = df['amount_str'].str.extract(r'([A-Z]{3})')[0]
    
    df['date'] = pd.to_datetime(df['date'])
    return df
```

## API banków

### ING Business API

```python
import requests

# Token uzyskujesz przez OAuth2
headers = {'Authorization': f'Bearer {token}'}
response = requests.get(
    f'https://api.ing.pl/business/accounts/{account_id}/transactions',
    headers=headers,
    params={'dateFrom': '2026-04-01', 'dateTo': '2026-04-30'},
)
transactions = response.json()
```

### mBank API (komercyjne)

```python
# Wymaga certyfikatu + umowy z mBank
response = requests.get(
    'https://api.mbank.pl/business/transactions',
    cert=('/path/to/client.crt', '/path/to/client.key'),
    params={...},
)
```

## Klasyfikacja transakcji

### Kategorie

- **Wpływ od klienta** — przychód.
- **Wydatek operacyjny** — koszt (dla skali/liniowego; dla ryczałtu nieistotne).
- **ZUS / US / PIT** — nieistotne dla ewidencji przychodów.
- **Przelew na prywatne** — wycofanie do celów prywatnych.
- **Opłaty bankowe** — koszt.
- **Konwersja walut** — wewnętrzna operacja.

### Algorytm

```python
def classify_transaction(description, counterparty, amount):
    desc_lower = (description or '').lower()
    cp_lower = (counterparty or '').lower()
    
    # ZUS
    if 'zus' in cp_lower or 'zakład ubezpieczeń' in cp_lower:
        return 'ZUS'
    
    # US (mikrorachunek podatkowy)
    if re.match(r'PL\d{2}1010', cp_lower):
        return 'US'
    
    # Opłaty bankowe
    if 'opłata' in desc_lower or 'prowizja' in desc_lower:
        return 'OPLATA'
    
    # Konwersja walut
    if 'konwersja' in desc_lower or 'przewalutowanie' in desc_lower:
        return 'KONWERSJA'
    
    # Wypłata na prywatne
    if 'wypłata' in desc_lower and amount < 0:
        return 'PRYWATNE'
    
    # Wpływy — przypuszczamy od klienta
    if amount > 0:
        return 'PRZYCHOD'
    
    return 'INNE'
```

## Matching z fakturami

### Regex dla numerów faktur

```python
import re

INVOICE_PATTERNS = [
    r'FV[-/_]?\d{4}[-/_]?\d{2}[-/_]?\d+',      # FV/2026/04/001
    r'FV\d{8,}',                                 # FV20260401
    r'R[-/_]?\d{4}[-/_]?\d{2}[-/_]?\d+',        # R/2026/04/001
    r'FAKTURA[-/_]?(\d+)',                       # FAKTURA 42
    r'nr[.\s]*(\d+[-/]\d+[-/]\d+)',              # nr. 2026/04/001
]

def extract_invoice_number(description):
    for pattern in INVOICE_PATTERNS:
        match = re.search(pattern, description, re.IGNORECASE)
        if match:
            return match.group(0)
    return None
```

### Matching

```python
# Rejestr faktur
invoices = pd.read_csv('faktury_2026.csv')

# Bank transactions (wpływy)
bank_df = load_bank_csv('ing_april_2026.csv', 'ING')
wplywy = bank_df[bank_df['amount'] > 0].copy()

wplywy['matched_invoice'] = wplywy['description'].apply(extract_invoice_number)

# Merge
merged = wplywy.merge(invoices, left_on='matched_invoice', right_on='numer', how='left')

# Matched
matched = merged[merged['numer'].notna()]
print(f"Dopasowano: {len(matched)}")

# Niedopasowane wpływy
unmatched = merged[merged['numer'].isna()]
print(f"Niedopasowane: {len(unmatched)}")
print(unmatched[['date', 'counterparty', 'amount', 'description']])
```

## Konwersja walut (NBP)

### Art. 11a ust. 1 ustawy o PIT

**Kurs średni NBP z dnia roboczego poprzedzającego** uzyskanie przychodu.

```python
import requests

def get_nbp_rate(currency, date):
    url = f"https://api.nbp.pl/api/exchangerates/rates/a/{currency}/{date.isoformat()}/?format=json"
    r = requests.get(url)
    if r.status_code == 200:
        return r.json()['rates'][0]['mid']
    return None

def get_preceding_nbp_rate(currency, date):
    from datetime import timedelta
    d = date - timedelta(days=1)
    for _ in range(7):
        rate = get_nbp_rate(currency, d)
        if rate:
            return rate
        d -= timedelta(days=1)
    return None

# Dla każdej transakcji walutowej
for idx, row in df_foreign.iterrows():
    rate = get_preceding_nbp_rate(row['currency'], row['date'])
    df_foreign.at[idx, 'rate_nbp'] = rate
    df_foreign.at[idx, 'amount_pln'] = row['amount'] * rate
```

## Uzgodnienie z JPK_V7

### Dla VAT-czynnych

```python
# Bank: sprzedaż za miesiąc
bank_sales = wplywy[
    (wplywy['date'] >= '2026-04-01') & 
    (wplywy['date'] <= '2026-04-30')
]['amount'].sum()

# JPK: wartość brutto sprzedaży
jpk_tree = ET.parse('JPK_V7M_04_2026.xml')
ns = {'j': 'http://jpk.mf.gov.pl/wzor/...'}
jpk_brutto = sum(
    float(r.findtext('j:K_19', 0, namespaces=ns) or 0) + 
    float(r.findtext('j:K_20', 0, namespaces=ns) or 0)
    for r in jpk_tree.findall('.//j:SprzedazWiersz', ns)
)

# Uwaga: JPK zawiera wystawione faktury, bank zawiera zapłacone
# → różnica to należności niezapłacone + przedpłaty
```

### Dla PIT (ryczałt / liniowy / skala)

**Ryczałt** — metoda kasowa (art. 14 ustawy o PIT): przychód w momencie zapłaty.

```python
# Dla PIT-28 (ryczałt)
przychod_miesiecznie = wplywy.groupby(wplywy['date'].dt.to_period('M'))['amount'].sum()

# Roczny przychód
przychod_roczny = wplywy['amount'].sum()

# Zgodność z deklaracją
deklaracja = 180000  # Z PIT-28
print(f"Różnica: {przychod_roczny - deklaracja:.2f}")
```

**Liniowy / skala** — metoda memoriałowa: przychód w momencie wystawienia faktury (nie zapłaty).

## Scenariusze

### Scenariusz 1: Miesięczna reconciliacja

```python
# Kwiecień 2026
bank = load_bank_csv('ing_04_2026.csv', 'ING')
invoices = pd.read_csv('faktury_04_2026.csv')

# Wpływy od klientów
cp_invoices = bank[(bank['amount'] > 0) & (bank['counterparty'].notna())]

# Match
cp_invoices['invoice_ref'] = cp_invoices['description'].apply(extract_invoice_number)
matched = cp_invoices.merge(invoices, left_on='invoice_ref', right_on='numer')

print(f"Wystawione faktury: {len(invoices)}, łącznie {invoices['brutto'].sum():.2f}")
print(f"Dopasowane wpływy: {len(matched)}, łącznie {matched['amount'].sum():.2f}")
print(f"Niezapłacone: {len(invoices) - len(matched)}")
```

### Scenariusz 2: Walutowe wpływy (EUR, USD)

```python
foreign_df = bank[bank['currency'].isin(['EUR', 'USD'])]

for idx, row in foreign_df.iterrows():
    rate = get_preceding_nbp_rate(row['currency'], row['date'])
    foreign_df.at[idx, 'amount_pln'] = row['amount'] * rate

total_foreign_pln = foreign_df['amount_pln'].sum()
print(f"Walutowe (po NBP): {total_foreign_pln:.2f} PLN")
```

### Scenariusz 3: Exclude fees & internal

```python
# Tylko "prawdziwy" przychód
income_only = bank[
    (bank['amount'] > 0) &
    (~bank['description'].str.contains('Opłata|Konwersja|Wypłata własna', case=False, na=False))
]
print(f"Czysty przychód: {income_only['amount'].sum():.2f}")
```

## Narzędzia

### Spreadsheet / Google Sheets

- Import CSV.
- VLOOKUP do matchowania.
- Pivot tables dla agregacji.

### Dedykowane aplikacje

- **iFirma, wFirma** — auto-import z banku.
- **Fakturownia** — integracja mBank, ING.
- **Subiekt Biznes** — full integration.

### Własne skrypty

- Python + pandas — elastyczne.
- Google Apps Script — jeśli już w Google Workspace.
- n8n / Make (dawniej Integromat) — no-code.

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Nie matchujesz po numerze faktury | Ręczne sprawdzanie każdego wpływu | Regex + automatyzacja |
| Pomijasz opłaty bankowe jako koszty | Nadpłata PIT | Dla skali/liniowego — koszt |
| Kurs NBP z dnia transakcji | Błędny przychód | Z dnia roboczego poprzedzającego |
| Liczysz wpłaty prywatne jako przychód | Nadpłata | Filtracja |
| Nie sprawdzasz JPK vs bank | Niezgodność, ryzyko kontroli | Uzgodnienie miesięczne |

## Ograniczenia

- Format CSV może się różnić (bank vs bank, wersja vs wersja).
- API wymagają autoryzacji OAuth (niektóre płatne).
- Duży wolumen (10k+ transakcji/mies) → profesjonalne ERP.
