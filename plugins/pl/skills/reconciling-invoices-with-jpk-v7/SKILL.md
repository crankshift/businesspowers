---
name: reconciling-invoices-with-jpk-v7
description: Use when reconciling Polish JDG invoices against JPK_V7 sales register. Covers missing/phantom invoice detection, GTU/procedure flag verification, WDT vs VAT-UE cross-check, PIT accrual vs cash method reconciliation, corrective JPK workflow.
---

# reconciling-invoices-with-jpk-v7

Skill — procedurowe uzgodnienie portfela faktur z JPK_V7 i rocznymi deklaracjami PIT dla polskiej JDG.

## Kluczowe źródła

- **Ustawa o VAT** — art. 99, 109 (JPK), art. 29a (podstawa).
- **Ordynacja podatkowa** — art. 81 (korekta deklaracji).
- **Rozporządzenie MF w sprawie JPK** — struktura FA_VAT, JPK_V7.
- **Ustawa o PIT** — art. 14 (przychód — memoriał vs kasa).

## Zasada

```
Każda WYSTAWIONA faktura VAT → SprzedazWiersz w JPK_V7
Każda OTRZYMANA faktura VAT (z prawem do odliczenia) → ZakupWiersz w JPK_V7

Jeśli niezgodność → ryzyko kontroli US lub utrata VAT naliczonego.
```

## Matryca metody rozliczania dla PIT

| Forma | Metoda przychodu |
|---|---|
| **Skala** (PIT-36) | Memoriałowa — przychód w dacie wystawienia faktury |
| **Liniowy** (PIT-36L) | Memoriałowa |
| **Ryczałt** (PIT-28) | **Kasowa** — przychód w dacie otrzymania zapłaty |
| **Karta** | N/A |

**VAT** zawsze w dacie wystawienia faktury (ze szczegółami w art. 19a ustawy o VAT).

## Procedura uzgodnienia

### Krok 1. Zebrać rejestr faktur

**Źródła:**
- Program księgowy (Fakturownia, iFirma, wFirma, InFakt).
- KSeF (eksport XML).
- Własny Excel/Google Sheets.

**Dane:**
- Numer, data wystawienia, data sprzedaży.
- Netto, VAT, brutto.
- Nabywca: NIP, nazwa.
- GTU (jeśli dotyczy).
- Oznaczenia procedur (SW, EE, TP, MPP).
- Typ (faktura / korekta / zaliczkowa).

### Krok 2. Eksport JPK_V7

- E-US → Moje deklaracje → JPK_V7.
- Lub: z programu księgowego → eksport XML.

### Krok 3. Parsowanie JPK_V7

```python
import xml.etree.ElementTree as ET

tree = ET.parse('JPK_V7M_04_2026.xml')
ns = {'j': 'http://jpk.mf.gov.pl/wzor/2022/02/17/02171/'}  # weryfikować wersję

# Sprzedaż
sales = []
for row in tree.findall('.//j:SprzedazWiersz', ns):
    sales.append({
        'numer': row.findtext('j:NrFa', namespaces=ns),
        'data': row.findtext('j:DataWystawienia', namespaces=ns),
        'nabywca_nip': row.findtext('j:NrKontrahenta', namespaces=ns),
        'netto_23': float(row.findtext('j:K_19', 0, namespaces=ns) or 0),
        'vat_23':   float(row.findtext('j:K_20', 0, namespaces=ns) or 0),
        'gtu':      [gtu.tag.split('}')[-1] for gtu in row if 'GTU_' in gtu.tag],
        'mpp':      row.find('j:MPP', ns) is not None,
    })

# Zakupy
purchases = []
for row in tree.findall('.//j:ZakupWiersz', ns):
    purchases.append({
        'numer': row.findtext('j:DowodZakupu', namespaces=ns),
        'data': row.findtext('j:DataZakupu', namespaces=ns),
        'sprzedawca_nip': row.findtext('j:NrDostawcy', namespaces=ns),
        'netto': float(row.findtext('j:K_42', 0, namespaces=ns) or 0),
        'vat':   float(row.findtext('j:K_43', 0, namespaces=ns) or 0),
    })
```

### Krok 4. Matchowanie

```python
import pandas as pd

invoices_df = pd.read_csv('wystawione_04_2026.csv')
jpk_sales_df = pd.DataFrame(sales)

# Matchowanie
merged = invoices_df.merge(
    jpk_sales_df, 
    left_on='numer', 
    right_on='numer', 
    how='outer', 
    indicator=True,
    suffixes=('_reg', '_jpk')
)

# Niedopasowane
missing_in_jpk = merged[merged['_merge'] == 'left_only']
extra_in_jpk = merged[merged['_merge'] == 'right_only']

print(f"W rejestrze, brak w JPK: {len(missing_in_jpk)}")
print(f"W JPK, brak w rejestrze: {len(extra_in_jpk)}")

# Różnice kwotowe
both = merged[merged['_merge'] == 'both']
diff = both[abs(both['netto_reg'] - both['netto_23']) > 0.01]
print(f"Różnice kwotowe: {len(diff)}")
```

### Krok 5. Analiza rozbieżności

#### Brak w JPK

**Przyczyny:**
- Faktura wystawiona, ale nie wprowadzona do ewidencji.
- Import z programu nie objął wszystkich.
- Faktura "pro forma" omylnie zaksięgowana jako VAT.

**Akcja:**
- **Korekta JPK_V7** za ten miesiąc (art. 81 Ordynacji).
- Dodanie brakującej faktury do rejestru sprzedaży.
- Dopłata VAT + odsetki.
- **Czynny żal** przy okazji korekty.

#### Extra w JPK

**Przyczyny:**
- Duplikat wpisu.
- Wprowadzona faktura, która potem została anulowana (bez korekty JPK).
- Błąd numerowania.

**Akcja:**
- Korekta JPK — usunąć nadmiarowy wpis.
- Zwrot VAT (jeśli odprowadzono więcej).

#### Różnice kwotowe

**Przyczyny:**
- Błąd transkrypcji.
- Korekta faktury nie zaksięgowana do JPK.

**Akcja:**
- Weryfikacja pierwotnej faktury.
- Korekta JPK jeśli potrzebna.

## Weryfikacja oznaczeń GTU

**Każdy wiersz sprzedaży** z towarem/usługą z listy GTU musi mieć odpowiednie oznaczenie.

### Lista GTU (powtórka)

- **GTU_01** — alkohol.
- **GTU_02** — paliwa silnikowe.
- **GTU_03** — paliwa stałe.
- **GTU_04** — papierosy.
- **GTU_05** — odpady.
- **GTU_06** — elektronika (> 1000 zł).
- **GTU_07** — pojazdy.
- **GTU_08** — metale szlachetne.
- **GTU_09** — leki.
- **GTU_10** — nieruchomości.
- **GTU_11** — emisja gazów.
- **GTU_12** — usługi niematerialne (doradztwo, księgowość, prawne, IT w niektórych przypadkach).
- **GTU_13** — transport / magazyn.

### Weryfikacja

```python
# Identyfikacja faktur, które POWINNY mieć GTU
def required_gtu(nazwa_uslugi):
    name = nazwa_uslugi.lower()
    if 'alkohol' in name or 'piwo' in name or 'wino' in name: return 'GTU_01'
    if 'telefon' in name or 'komputer' in name: return 'GTU_06'
    if 'doradztwo' in name or 'konsulting' in name or 'it' in name: return 'GTU_12'
    if 'transport' in name or 'przewóz' in name: return 'GTU_13'
    return None

# Sprawdzenie
for inv in invoices_df.itertuples():
    expected = required_gtu(inv.nazwa_uslugi)
    if expected and expected not in (inv.gtu_jpk or []):
        print(f"FAKTURA {inv.numer}: brak {expected}!")
```

### Sankcje za brak GTU

- Do **500 zł** za każdy błędny rekord w JPK (art. 82b Ordynacji).
- Przy wielu faktur — kwota narasta.

## Oznaczenia procedur

### SW (sprzedaż wysyłkowa z Polski)

- Dla sprzedaży wysyłkowej poza PL (ale w UE).

### EE (dostawy usług telekomunikacyjnych / nadawczych / elektronicznych dla B2C UE)

- Specjalne dla e-services.

### TP (transakcje powiązane)

- Podmioty powiązane (małżonek, rodzina, spółki z relacjami).

### MPP (mechanizm podzielonej płatności)

- Faktury > 15 000 zł z zał. 15.

## Uzgodnienie WDT z VAT-UE

**WDT** (wewnątrzwspólnotowa dostawa towarów) = 0% VAT.

**Obowiązek:** zgłoszenie w **Informacji podsumowującej VAT-UE** do 25-go następnego miesiąca.

### Weryfikacja

```python
# WDT w JPK_V7
wdt_sales = [s for s in sales if s.get('K_21', 0) > 0]  # Pole WDT 0%

# VAT-UE
vat_ue_tree = ET.parse('VAT-UE_04_2026.xml')
vat_ue_sales = [...]  # Parsowanie

# Sprawdzenie
jpk_nips = set(s['nabywca_nip'] for s in wdt_sales)
vat_ue_nips = set(v['nip'] for v in vat_ue_sales)

diff = jpk_nips ^ vat_ue_nips
if diff:
    print(f"Niezgodność WDT: {diff}")
```

## Uzgodnienie z PIT rocznym

### Dla ryczałtu (PIT-28, metoda kasowa)

**Przychód = suma zapłaconych faktur** w okresie rozliczenia.

```python
# Faktury zapłacone w 2026
paid_invoices_2026 = invoices_df[
    (invoices_df['data_zaplaty'].dt.year == 2026)
]
przychod_2026 = paid_invoices_2026['brutto'].sum()

# Porównanie z PIT-28
pit_28_przychod = 450000  # Z deklaracji
diff = przychod_2026 - pit_28_przychod
```

### Dla liniowego (PIT-36L, metoda memoriałowa)

**Przychód = suma faktur wystawionych** w okresie (niezależnie od zapłaty).

```python
# Faktury wystawione w 2026
issued_invoices_2026 = invoices_df[
    (invoices_df['data_wystawienia'].dt.year == 2026)
]
przychod_2026 = issued_invoices_2026['netto'].sum()  # Netto, bo bez VAT dla PIT

# Minus VAT dla sprzedawcy VAT-czynnego (VAT nie jest przychodem)
# netto już jest bez VAT
```

### Dla skali (PIT-36)

Analogicznie jak liniowy — metoda memoriałowa.

## Korekta JPK_V7

### Art. 81 Ordynacji

Korekta składana elektronicznie przez e-US, zawiera wszystkie dane (nie tylko zmiany).

### Procedura

1. Skorygować rejestr sprzedaży / zakupów.
2. Wygenerować nowy JPK_V7.
3. Wysłać z oznaczeniem "Korekta".
4. Dołączyć **czynny żal** (jeśli zmienia VAT do zapłaty).
5. Zapłacić niedopłatę + odsetki.

### Terminy

- Korektę JPK można składać **5 lat wstecz** (termin przedawnienia zobowiązań).
- Im szybciej po wykryciu — tym niższe odsetki.

## Scenariusze

### Scenariusz 1: Pierwsza weryfikacja kwartalna

**Krok po kroku:**
1. Zebrać listę faktur wystawionych za Q1 2026.
2. Zebrać JPK_V7M za styczeń, luty, marzec.
3. Parse każdy JPK.
4. Match po numerze.
5. Raport: OK? Brakuje? Nadmiar? Różnice?
6. Korekty jeśli potrzeba.

### Scenariusz 2: Odkrycie braku faktury w JPK

**Sytuacja:**
- FV/2026/03/042 na 10 000 netto + 2 300 VAT = 12 300 brutto.
- Wystawiona i wysłana 28.03.2026.
- Brak w JPK_V7M za marzec.

**Akcja:**
1. Zweryfikować w programie księgowym — czy w ogóle została tam zaksięgowana.
2. Dodać do ewidencji sprzedaży.
3. Wygenerować **korektę JPK_V7M** za marzec.
4. Wysłać z oznaczeniem "Korekta".
5. Dopłacić 2 300 VAT + odsetki (~15% p.a. × dni).
6. Dołączyć **czynny żal**.

### Scenariusz 3: Rozbieżność PIT-28 vs bank

**Sytuacja:**
- PIT-28 za 2025: przychód 450 000.
- Suma wpływów na rachunku firmowym za 2025: 440 000.
- Różnica: 10 000.

**Analiza:**
- Może: 10 000 to faktura wystawiona 30.12.2025, zapłacona 08.01.2026.
- Dla ryczałtu (kasowa) → przychód 2026, nie 2025.
- **Jeżeli w PIT-28 2025 ujęto 10 000 → korekta w dół!**

**Akcja:**
- Korekta PIT-28 za 2025 (minus 10 000).
- Uwzględnienie w PIT-28 za 2026 (plus 10 000).

### Scenariusz 4: Duplikat w JPK

**Sytuacja:**
- W JPK_V7 kwiecień: FV/2026/04/042 pojawia się dwa razy.
- Obydwa wpisy na te same 10 000 netto + 2 300 VAT.

**Akcja:**
1. Korekta JPK_V7 — usunąć duplikat.
2. VAT do zwrotu: 2 300.
3. Wniosek o zwrot lub zaliczenie na przyszłe zobowiązania.

## Narzędzia

### Programy księgowe

**Automatyczne uzgodnienie:**
- **Comarch ERP Optima** — pełna funkcjonalność.
- **iFirma, wFirma** — uzgodnienia automatyczne.
- **Fakturownia** — brakuje niektórych uzgodnień (dla prostszych).

### Skrypty

- Python + pandas + lxml.
- Excel z VBA.

### Audyt / Pre-check

- Sprawdzić przed każdym składaniem JPK / PIT rocznego.
- Koniec miesiąca → quick reconciliacja.
- Koniec kwartału → pełna analiza.

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Nie weryfikujesz JPK vs rejestr | Ryzyko kontroli, kara | Comiesięczna weryfikacja |
| Brak GTU przy obowiązku | Do 500 zł / wpis | Automatyczne GTU w programie |
| Ryczałt — przychód w dacie faktury (jak memoriał) | Nadpłata lub niedopłata PIT-28 | Kasowa dla ryczałtu |
| Brak VAT-UE przy WDT | Opodatkowanie 23% + kara | Zawsze VAT-UE do 25-go |
| Korekta JPK bez czynnego żalu | KKS | Zawsze dołączać |
| Korekta faktury nie zaksięgowana w JPK | Różnica narasta | Natychmiast do JPK |

## Ograniczenia

- Automatyzacja wymaga zgodnych formatów (JPK struktura ewoluuje).
- Specyficzne branże (VAT marża, VAT turystyka) — odrębne reguły.
- Dla dużych firm (> 5 mln obrót) — VAT zwrot w specjalnych procedurach.
- Zgodność z PIT zależy od wybranej metody (kasowa vs memoriałowa).
