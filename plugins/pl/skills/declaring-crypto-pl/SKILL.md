---
name: declaring-crypto-pl
description: Use when declaring cryptocurrency activity in Polish PIT-38. Covers crypto-to-crypto swaps as taxable events, mining, staking, yield farming, NFTs, FIFO, loss carry-forward, exchange data extraction, Koinly automation.
---

# declaring-crypto-pl

Deklarowanie działalności kryptowalutowej w polskim PIT-38. Podstawa prawna — **art. 30b ust. 1 pkt 4 ustawy o PIT** (od 01.01.2019).

## Kluczowe źródła

- **Ustawa o PIT**:
  - Art. 30b — 19% od kapitałów, w tym krypto.
  - Art. 9 ust. 3 — straty 5 lat.
  - Art. 24a — kurs NBP dla krypto.
  - Art. 22 — koszty uzyskania.
- Interpretacje KIS (eureka.mf.gov.pl) — liczne dotyczące krypto.

## Parametry — odniesienie

> Aktualne wartości — pobierać przez kanoniczne skille.
> Jeśli skill nie odpowiedział, użyj fallback poniżej; ostrzeż: «⚠ Wartość [parametr] użyto ze stanem na [data].»

| Parametr | Kanoniczny skill | Fallback |
|---|---|---|
| Stawka 19% krypto (art. 30b ust. 1 pkt 4) | `calculating-pit-38` | 19% _(01.01.2026)_ |
| Przenoszenie strat (50%, 5 lat) | `calculating-pit-38` | 50% / 5 lat _(01.01.2026)_ |

## Stawka

**19%** _(fallback; stan na 01.01.2026)_ od dochodu (proste, jak PIT-38 standardowy).

## Co jest przedmiotem opodatkowania

### Oczywiste zdarzenia

- **Sprzedaż krypto za fiat (PLN, EUR, USD)** — dochód z odpłatnego zbycia.
- **Kup przez kartę Binance/Revolut** — zakup.

### Mniej oczywiste

- **Wymiana crypto na crypto** — każda wymiana jest **sprzedażą starego + zakupem nowego**.
- **Płatność krypto za towar/usługę** — sprzedaż krypto.
- **Stakowanie, yield farming** — dochód z momentem otrzymania (art. 10 ust. 1 pkt 9).
- **Mining** — dochód z momentem wydobycia.
- **NFT sprzedaż** — jak krypto.
- **Airdrop** — dochód z ryczałtowej wartości (często kontrowersyjne; przy 0 wartości — brak dochodu).

### Wyjątki

- **HODL** (trzymanie bez reorganizacji) — brak opodatkowania do momentu sprzedaży.
- **Przelew między swoimi gaminaczami** — brak dochodu.
- **DeFi "wrap" (np. ETH → WETH)** — szara strefa; praktyka KIS różna. Konsultacja.

## Formuła

```
Dochód_roczny = Σ (Przychody z każdej sprzedaży / wymiany) − Σ (Koszty nabycia)
Podatek = 19% × Dochód
```

## FIFO

**Obowiązkowa** (wynika z braku przepisu LIFO; praktyka KIS — FIFO).

**Przy wielu zakupach tego samego tokena:**

```
Pierwsze sprzedane = najwcześniej kupione
```

## Kursy NBP

**Art. 24a (oraz 11a):** średni kurs NBP z **dnia roboczego poprzedzającego** operację.

**Dla krypto-operacji:**

```
Wartość_w_PLN = Ilość × Cena_w_USD × Kurs_NBP_USD(dzień roboczy poprzedzający)
```

### Cena rynkowa

- NBP **nie publikuje** kursu krypto.
- Używaj **ceny rynkowej** z:
  - Binance (dla BTC, ETH, altów).
  - Coinbase (dla głównych).
  - CoinGecko / CoinMarketCap (agregowane).
- Przyjmij cenę **zamknięcia** albo **wolumenowo ważoną**.

## Przykład crypto → crypto

**01.03.2025: kupiłem 1 BTC za $60 000.**
- Kurs NBP 28.02.2025 (pt): 3,95.
- Koszt nabycia BTC: 1 × 60 000 × 3,95 = **237 000 PLN**.

**15.09.2025: wymieniłem 1 BTC na 20 ETH.** W momencie wymiany:
- 1 BTC rynkowo = $70 000.
- 1 ETH rynkowo = $3 500.
- Kurs NBP 12.09.2025 (pt): 3,90.

**Obliczenia:**
1. **Sprzedaż BTC:**
   - Przychód: 1 × 70 000 × 3,90 = **273 000 PLN**.
   - Koszt nabycia: 237 000.
   - **Dochód BTC: 36 000 PLN.**
2. **Nabycie ETH:**
   - Koszt nabycia: 273 000 PLN (20 ETH).

**20.12.2025: sprzedałem 20 ETH za $90 000.**
- Kurs NBP 19.12.2025: 4,10.
- Przychód: 90 000 × 4,10 = **369 000 PLN**.
- Koszt: 273 000.
- **Dochód ETH: 96 000 PLN.**

**Rocznie:**
- Dochód suma: 36 000 + 96 000 = **132 000 PLN**.
- Podatek: 19% × 132 000 = **25 080 PLN**.

## Staking / yield farming

**Dochód = wartość otrzymanych monet × kurs w momencie otrzymania.**

**Przykład:** staking Lido (30 ETH) z 4% APY przez rok.

**Miesięczne otrzymanie (co tydzień/co dzień — tutaj uproszczenie):**
- 0,1 ETH co tydzień (średnio).
- 01.11.2025: otrzymano 0,1 ETH. ETH = $3 100, kurs 4,10.
- Dochód: 0,1 × 3 100 × 4,10 = 1 271 PLN.
- PIT: 19% × 1 271 = 241 PLN za tę nagrodę.

**Rocznie:** sumować wszystkie takie otrzymania → suma dochodów.

Przy sprzedaży tych ETH później — **koszt nabycia = suma dochodów w PLN** (już opodatkowanych przy otrzymaniu).

## Mining

- Otrzymanie coina = dochód (wartość rynkowa × kurs NBP).
- Brak możliwości odliczenia kosztów (energia, sprzęt) dla osoby fizycznej (tylko JDG).

Dla **JDG "mining"** — inne reguły (nie w tym skillu).

## NFT

- Sprzedaż NFT → przychód (w PLN).
- Koszt nabycia = cena zakupu NFT + gas fees.
- Traktowane jak krypto (art. 30b).

## DeFi

Bardzo złożone; każdy protokół inaczej:

- **Uniswap swap** = wymiana crypto/crypto.
- **Yield farming** = staking (dochód w momencie otrzymania).
- **Impermanent loss** — nierozpoznany podatkowo (nierealizowany).
- **LP tokens** — kontrowersyjne (sprzedaż starego? depozyt?).
- **Lending (Aave, Compound)** — odsetki to dochód.

**Rekomendacja:** zasięgnij interpretacji indywidualnej KIS dla nietypowych przypadków.

## Narzędzia do automatyzacji

### Koinly (najpopularniejsze)

- Integracja z 700+ bierż i blockchainów.
- Import transakcji przez API / CSV.
- Eksport raportu **Poland PIT** (formalnie dostępny).
- Koszt: ~50-100 EUR/rok.

### CoinTracker

- Podobnie, ale skupione na USA.

### Excel z makro

- Dla zaawansowanych — możliwe, ale bardzo pracochłonne.
- Plus: pełna kontrola.

### Inne

- **Crypto.com Tax** — bezpłatne podstawowe.
- **Accointing** — przestało działać od 2023.

## Ekstrakcja danych z bierż

### Binance

- Account → Statement.
- Eksport CSV (Spot Trade History, Fiat Transactions, Convert History).
- **Uwaga:** Binance miało problemy z licencjami w różnych krajach; weryfikować dostępność.

### Coinbase

- Taxes → Documents → Transaction History CSV.

### Kraken

- History → Export Ledgers / Trades / Deposits / Withdrawals (CSV).

### Bybit, OKX, KuCoin, Bitget

- W panelu "History" lub "Orders" → eksport CSV.

### DeFi (Ethereum, BSC, Polygon)

- Export przez **Etherscan / BscScan / Polygonscan** dla wallet address.
- Alternatywa: podłączenie portfela do Koinly.

## PIT-38 — sekcja C1 krypto

### Pola

| Pole | Opis |
|---|---|
| **32. Przychód** | Suma przychodów ze wszystkich sprzedaży / wymian w PLN |
| **33. Koszty uzyskania** | Suma kosztów nabycia w PLN |
| **34. Dochód** | 32 − 33 |
| **35. Podatek 19%** | od 34 |

### Koszty — co wliczać

- Cena kupna tokena × kurs NBP.
- Gas fees (w wysokości poniesionej).
- Prowizje giełd.

### Przychody

- Cena sprzedaży × kurs NBP.
- Pomniejszone o prowizje giełdy (jeśli stosowane jako koszt).

## Straty — przenoszenie

Tak jak dla sekcji C:
- 5 lat wstecz.
- Max 50% w jednym roku.
- Sekcja C i C1 mają **oddzielne** salda! (strata z crypto nie kompensuje zysku z akcji).

## Typowe błędy

| Błąd | Skutek | Poprawnie |
|---|---|---|
| Nie deklaruje crypto/crypto | Niedopłata + kara | Każda wymiana = zdarzenie |
| Nie uwzględnia stakowania | Niedopłata | Dochód z momentem otrzymania |
| Myli sekcje C i C1 | Zła klasyfikacja | Krypto tylko w sekcji C1 (od 2019) |
| Używa kursu NBP z dnia operacji | Błąd | Z dnia roboczego poprzedzającego |
| Używa kursu giełdy (Binance BTC/PLN) | Nieprawidłowe | NBP × cena w USD |
| Kompensuje stratę crypto z zyskiem akcji | Błąd | Straty osobno dla każdej sekcji |

## Scenariusz pełny

**2025:**
- 50 000 PLN zainwestowane.
- 300+ transakcji (głównie swapy BTC/ETH/stable).
- Koinly → raport: dochód 120 000 PLN.
- Straty z 2024: 30 000 PLN.

**PIT-38 C1:**
- Poz. 32 (przychody suma): 2 500 000 PLN.
- Poz. 33 (koszty suma): 2 380 000 PLN.
- Poz. 34 (dochód): 120 000 PLN.
- Poz. 35 (pełny podatek 19%): 22 800 PLN.

**Odliczenie straty 2024:**
- Max 50% × 30 000 = 15 000 PLN.
- Dochód po odliczeniu: 105 000 PLN.
- Podatek: 19% × 105 000 = **19 950 PLN**.

Pozostało z straty 2024: 15 000 PLN do wykorzystania 2026-2029.

## Ograniczenia

- **Prawo dynamiczne** — KIS wciąż rozwija interpretacje dla DeFi, NFT, airdropów.
- Dla działalności "zawodowej" (mining jako biznes, trading jako główny dochód) — rozważyć JDG, **nie** PIT-38.
- Dla dużych portfeli (> 500k) — konsultant podatkowy z crypto specjalizacją.
- W przypadku hacku / utraty kluczy → strata trudna do udowodnienia.
