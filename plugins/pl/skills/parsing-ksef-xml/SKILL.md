---
name: parsing-ksef-xml
description: Use when parsing KSeF XML documents. Covers FA_VAT and FA_KOR structure, extracting invoice data and GTU/MPP flags, XSD validation, API integration, reconciliation with JPK_V7.
---

# parsing-ksef-xml

Skill — praca ze strukturą XML faktur w KSeF.

## Kluczowe źródła

- **KSeF** — [ksef.mf.gov.pl](https://ksef.mf.gov.pl).
- **Dokumentacja techniczna** FA_VAT v3 — na stronie MF.
- **Schemat XSD** — oficjalny, do walidacji.
- **API KSeF** — REST z autentykacją certyfikatem.

## Struktura FA_VAT (v3) — uproszczona

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Faktura xmlns="http://crd.gov.pl/wzor/2023/06/29/12648/"
         wersja="1-0E">
  <Naglowek>
    <KodFormularza kodSystemowy="FA (3)" wersjaSchemy="1-0E">FA</KodFormularza>
    <WariantFormularza>3</WariantFormularza>
    <DataWytworzeniaFa>2026-04-10T14:23:00</DataWytworzeniaFa>
    <SystemInfo>Fakturownia 2026</SystemInfo>
  </Naglowek>

  <Podmiot1>
    <DaneIdentyfikacyjne>
      <NIP>1234567890</NIP>
      <Nazwa>Jan Kowalski JDG</Nazwa>
    </DaneIdentyfikacyjne>
    <Adres>
      <KodKraju>PL</KodKraju>
      <AdresL1>ul. Marszałkowska 100/15</AdresL1>
      <AdresL2>00-001 Warszawa</AdresL2>
    </Adres>
    <DaneKontaktowe>
      <Email>jan@kowalski.pl</Email>
    </DaneKontaktowe>
  </Podmiot1>

  <Podmiot2>
    <DaneIdentyfikacyjne>
      <NIP>9876543210</NIP>
      <Nazwa>ACME Sp. z o.o.</Nazwa>
    </DaneIdentyfikacyjne>
    <Adres>
      <KodKraju>PL</KodKraju>
      <AdresL1>ul. Piłsudskiego 5</AdresL1>
      <AdresL2>00-002 Warszawa</AdresL2>
    </Adres>
  </Podmiot2>

  <Fa>
    <KodWaluty>PLN</KodWaluty>
    <P_1>2026-04-10</P_1>                           <!-- Data wystawienia -->
    <P_1M>Warszawa</P_1M>                           <!-- Miejsce wystawienia -->
    <P_2>FV/2026/04/001</P_2>                       <!-- Numer faktury -->
    <P_6>2026-04-10</P_6>                           <!-- Data sprzedaży -->

    <!-- VAT rows -->
    <P_13_1>24000.00</P_13_1>                       <!-- Netto 23% -->
    <P_14_1>5520.00</P_14_1>                        <!-- VAT 23% -->
    <P_15>29520.00</P_15>                           <!-- Razem brutto -->

    <!-- Line items -->
    <FaWiersz>
      <NrWierszaFa>1</NrWierszaFa>
      <P_7>Usługi programistyczne — kwiecień 2026</P_7>       <!-- Nazwa -->
      <P_8A>godzina</P_8A>                           <!-- Jednostka -->
      <P_8B>160</P_8B>                               <!-- Ilość -->
      <P_9A>150.00</P_9A>                            <!-- Cena netto -->
      <P_11>24000.00</P_11>                          <!-- Wartość netto -->
      <P_12>23</P_12>                                <!-- Stawka VAT -->
      <GTU_12 />                                     <!-- Oznaczenie GTU -->
    </FaWiersz>

    <Adnotacje>
      <P_19N />                                      <!-- 1 = metoda kasowa, 2 = samofakturowanie, ... -->
    </Adnotacje>

    <Platnosc>
      <Zaplacono>0</Zaplacono>                       <!-- 0 = nie zapłacono, 1 = zapłacono -->
      <TerminPlatnosci>
        <Termin>2026-04-24</Termin>
      </TerminPlatnosci>
      <FormaPlatnosci>6</FormaPlatnosci>             <!-- 6 = przelew -->
      <RachunekBankowy>
        <NrRB>12123456789012345678901234</NrRB>
        <NazwaBanku>ING Bank Śląski S.A.</NazwaBanku>
      </RachunekBankowy>
    </Platnosc>
  </Fa>

  <Stopka>
    <Informacje>
      <StopkaFaktury>Rachunek na białej liście VAT na dzień wystawienia.</StopkaFaktury>
    </Informacje>
  </Stopka>
</Faktura>
```

## Klucze pól FA_VAT (v3) — ściągawka

| Tag | Opis |
|---|---|
| `<P_1>` | Data wystawienia |
| `<P_1M>` | Miejsce wystawienia |
| `<P_2>` | Numer faktury |
| `<P_6>` | Data sprzedaży / dokonania |
| `<P_7>` | Nazwa towaru/usługi |
| `<P_8A>` | Jednostka miary |
| `<P_8B>` | Ilość |
| `<P_9A>` | Cena jednostkowa netto |
| `<P_11>` | Wartość netto |
| `<P_12>` | Stawka VAT (23, 8, 5, 0, zw) |
| `<P_13_x>` | Suma netto per stawka (x=1 dla 23%, x=2 dla 8%, x=3 dla 5%, x=4 dla 0%, x=5 dla zw) |
| `<P_14_x>` | Suma VAT per stawka |
| `<P_15>` | Brutto ogółem |
| `<GTU_NN>` | Oznaczenie GTU (01-13) |
| `<MPP>` | Flaga mechanizmu podzielonej płatności |
| `<TP>` | Transakcja powiązana |
| `<WSTO_EE>` | Sprzedaż wysyłkowa / usługi B2C UE |

## Parsing w Python

### lxml (szybki)

```python
from lxml import etree

with open('faktura.xml', 'rb') as f:
    tree = etree.parse(f)

# Namespace
ns = {'fa': 'http://crd.gov.pl/wzor/2023/06/29/12648/'}

# Podstawowe
numer = tree.xpath('//fa:Fa/fa:P_2/text()', namespaces=ns)[0]
data_wyst = tree.xpath('//fa:Fa/fa:P_1/text()', namespaces=ns)[0]
brutto = float(tree.xpath('//fa:Fa/fa:P_15/text()', namespaces=ns)[0])

# Sprzedawca
nip_s = tree.xpath('//fa:Podmiot1//fa:NIP/text()', namespaces=ns)[0]
nazwa_s = tree.xpath('//fa:Podmiot1//fa:Nazwa/text()', namespaces=ns)[0]

# Nabywca
nip_n = tree.xpath('//fa:Podmiot2//fa:NIP/text()', namespaces=ns)
nip_n = nip_n[0] if nip_n else None  # B2C może nie mieć NIP

# Pozycje
wiersze = tree.xpath('//fa:Fa/fa:FaWiersz', namespaces=ns)
for w in wiersze:
    nazwa = w.xpath('fa:P_7/text()', namespaces=ns)[0]
    ilosc = float(w.xpath('fa:P_8B/text()', namespaces=ns)[0])
    netto = float(w.xpath('fa:P_11/text()', namespaces=ns)[0])
    stawka = w.xpath('fa:P_12/text()', namespaces=ns)[0]
    # GTU
    gtu = []
    for gtu_tag in w.xpath('fa:*[starts-with(local-name(), "GTU_")]', namespaces=ns):
        gtu.append(gtu_tag.tag.split('}')[-1])
    print(f"  {nazwa}: {ilosc} x {netto} (VAT {stawka}%), GTU: {gtu}")
```

### xml.etree.ElementTree (standard library)

```python
import xml.etree.ElementTree as ET

tree = ET.parse('faktura.xml')
root = tree.getroot()
ns = {'fa': 'http://crd.gov.pl/wzor/2023/06/29/12648/'}

for elem in root.iter():
    tag = elem.tag.split('}')[-1]
    if tag == 'P_2':  # Numer faktury
        print(f"Numer: {elem.text}")
```

## Walidacja XSD

```python
from lxml import etree

# Załaduj schema
with open('schemaFA_VAT_v3.xsd') as f:
    schema_doc = etree.parse(f)
schema = etree.XMLSchema(schema_doc)

# Walidacja
with open('faktura.xml') as f:
    doc = etree.parse(f)

if schema.validate(doc):
    print("Valid")
else:
    for error in schema.error_log:
        print(error.message)
```

**Gdzie pobrać XSD:**
- [ksef-test.mf.gov.pl](https://ksef-test.mf.gov.pl) → dokumentacja techniczna.

## API KSeF

### Autoryzacja

```python
import requests

# Token autoryzacyjny uzyskujesz przez podpis kwalifikowany + API KSeF
API_BASE = 'https://ksef.mf.gov.pl/api'  # Środowisko produkcyjne
HEADERS = {'Authorization': f'Bearer {token}'}

# Pobranie faktury przez numer KSeF
ksef_no = '1234567890-20260410-A1B2C3D4'
response = requests.get(f'{API_BASE}/online/Invoice/Get/{ksef_no}', headers=HEADERS)
xml_content = response.text
```

### Wystawienie faktury

```python
# Przygotuj XML zgodny z FA_VAT
xml_invoice = build_invoice_xml(...)

response = requests.post(
    f'{API_BASE}/online/Invoice/Send',
    headers={**HEADERS, 'Content-Type': 'application/octet-stream'},
    data=xml_invoice.encode('utf-8'),
)

ksef_element_id = response.json()['elementReferenceNumber']
# ... checking status ...
```

### Lista faktur otrzymanych / wystawionych

```python
# Query invoices from date range
params = {
    'subjectType': 'subject1',  # 1 = sprzedawca, 2 = nabywca
    'dateFrom': '2026-04-01',
    'dateTo': '2026-04-30',
}
response = requests.post(
    f'{API_BASE}/online/Invoice/Query',
    headers=HEADERS,
    json=params,
)
invoices = response.json()['invoiceList']
```

## Faktury korygujące (FA_KOR)

Struktura podobna, ale z dodatkowymi polami:
- **FaKorygowana** — referencja do pierwotnej faktury.
- **Przyczyna korekty** — tekst opisowy.
- **P_13_x_po** / **P_14_x_po** — kwoty po korekcie.

```xml
<Fa>
  <RodzajFaktury>KOREKTA</RodzajFaktury>
  <FaKorygowana>
    <NrFaKorygowanej>FV/2026/04/001</NrFaKorygowanej>
    <DataWyst>2026-04-10</DataWyst>
  </FaKorygowana>
  <PrzyczynaKorekty>Udzielenie rabatu 10%</PrzyczynaKorekty>
  <!-- wartości po korekcie -->
</Fa>
```

## Uzgodnienie z JPK_V7

Parsowanie obu (KSeF XML + JPK_V7 XML):

```python
# Lista KSeF faktur z kwietnia
ksef_invoices = [parse_ksef(f) for f in ksef_xmls_april]

# JPK_V7M sprzedaż
jpk_tree = ET.parse('JPK_V7M_2026_04.xml')
jpk_ns = {'j': 'http://jpk.mf.gov.pl/wzor/2022/02/17/02171/'}
jpk_sales = [row.findtext('j:NrFa', namespaces=jpk_ns) 
             for row in jpk_tree.findall('.//j:SprzedazWiersz', jpk_ns)]

ksef_numbers = set(inv['P_2'] for inv in ksef_invoices)
jpk_numbers = set(jpk_sales)

# Rozbieżności
in_ksef_not_jpk = ksef_numbers - jpk_numbers
in_jpk_not_ksef = jpk_numbers - ksef_numbers

print("W KSeF, brak w JPK:", in_ksef_not_jpk)
print("W JPK, brak w KSeF:", in_jpk_not_ksef)
```

## Przetwarzanie otrzymanych faktur

Jeśli kontrahent wystawił fakturę w KSeF dla ciebie:

1. Pobrać z KSeF przez API.
2. Sparsować XML.
3. Zweryfikować:
   - Czy NIP sprzedawcy się zgadza.
   - Czy stawki VAT OK.
   - Czy adnotacje (MPP) są zgodne z oczekiwaniami.
4. Wprowadzić do swojego JPK_V7 po stronie zakupów.
5. Odliczyć VAT naliczony.

## Typowe błędy w parsowaniu

| Błąd | Rozwiązanie |
|---|---|
| Namespace prefix nie pasuje | Użyć `local-name()` w XPath |
| B2C faktura bez NIP nabywcy | Sprawdzać obecność node przed dostępem |
| Stawka VAT jako string (`zw`, `np`) | Nie konwertować bezkrytycznie na int |
| Wiele stawek na jednej fakturze | Iterować P_13_1, P_13_2, ... |
| GTU brak node (nie ma wskazania) | Default = brak GTU |
| Kwoty z przecinkiem zamiast kropki | Standaryzować przy parsowaniu |

## Archiwizacja

**Format XML** przechowywany 5 lat (art. 86 Ordynacji).

**KSeF** archiwizuje automatycznie (na serwerze MF).

**Kopia lokalna:**
- Pobierać XML okresowo.
- Przechowywać zabezpieczone kopie (z podpisem, timestampem).

## Narzędzia

### KSeF Dev Portal

[ksef-test.mf.gov.pl](https://ksef-test.mf.gov.pl) — środowisko testowe.

- Generator testowych faktur.
- Walidacja XSD.
- Przykłady API calls.

### SDK

- **KSeF SDK** (Python) — biblioteki społecznościowe.
- **KSeF Client** (.NET) — dla C# developers.

### Programy księgowe

- **Comarch, iFirma, wFirma, InFakt, Fakturownia** — wszystkie wspierają eksport XML + integrację z KSeF API.

## Scenariusze

### Scenariusz 1: Masowy eksport faktur z KSeF za miesiąc

```python
# Pobrać listę
invoices = query_ksef_invoices('2026-04-01', '2026-04-30', subject_type='subject1')

# Dla każdej zaciągnij XML
for ref in invoices:
    xml = get_invoice_xml(ref['ksefReferenceNumber'])
    save_to_disk(f"archive/{ref['invoiceDate']}_{ref['ksefReferenceNumber']}.xml", xml)
```

### Scenariusz 2: Walidacja przychodzącej faktury

```python
# Gdy kontrahent powiadamia o fakturze (numer KSeF)
ksef_no = '9876543210-20260410-X1Y2Z3W4'
xml = get_invoice_xml(ksef_no)

# Parse
data = parse_ksef(xml)

# Sprawdź
assert data['Podmiot1']['NIP'] == expected_nip
assert data['Fa']['P_15'] == expected_brutto
# ...

# Wprowadź do bazy zakupów
import_as_purchase(data)
```

### Scenariusz 3: Automatyczne odpowiedzenie z fakturą korygującą

```python
if should_correct(invoice):
    kor_xml = build_correction_xml(invoice, reason, new_amounts)
    send_to_ksef(kor_xml)
```

## Ograniczenia

- Schema FA_VAT v3 — **aktualna**; poprzednie wersje (v1, v2) wycofane.
- Dla API produkcyjnego wymagany certyfikat kwalifikowany.
- Środowisko testowe ma inne endpointy.
- Niezgodność XSD → odrzucenie faktury przez KSeF.
