# businesspowers / pl

Przestrzeń robocza do obsługi Jednoosobowej Działalności Gospodarczej (JDG) oraz spraw podatkowych osoby fizycznej w Polsce. Plugin zawiera wyspecjalizowanych subagentów pod konkretne zadania i skille do kalkulacji, wyboru form, sprawozdawczości oraz odniesień do pierwotnych źródeł.

Plugin `pl` wchodzi w skład monorepo `businesspowers` (`crankshift/businesspowers`). Komendy w Claude Code otrzymują prefiks `/pl:…` (np. `/pl:jdg-registrator`). Równolegle w tym samym marketplace istnieje plugin `ua` (Ukraina, ФОП), z którym plugin `pl` się nie krzyżuje.

## Język komunikacji

- Język podstawowy — **polski**. Wszyscy agenci, skille, szablony i deklaracje formułowane są po polsku.
- Terminologia podatkowa — zgodna z ustawą o PIT, VAT, ryczałcie, o systemie ubezpieczeń społecznych, Ordynacją podatkową.
- Daty cytowań aktów prawnych — wskazywać wyraźnie. Redakcja z konkretnego dnia ma znaczenie, bo stawki i progi zmieniają się corocznie (szczególnie składka zdrowotna w Polskim Ładzie).

## Agenci i skille

Opis każdego agenta i skilla jest ładowany automatycznie z frontmatteru. Pełna lista — `agents/*.md` i `skills/*/SKILL.md`. Agenci dzielą się na blok **JDG** (cykl życia działalności) i blok **osoba fizyczna** (dochody poza działalnością — inwestycje, spadki, krypto).

## Kluczowe zasoby

| Zasób | URL | Zastosowanie |
|---|---|---|
| Ustawa o PIT | [isap.sejm.gov.pl](https://isap.sejm.gov.pl/isap.nsf/DocDetails.xsp?id=WDU19910800350) | Źródło pierwotne |
| Ustawa o VAT | [isap.sejm.gov.pl](https://isap.sejm.gov.pl/isap.nsf/DocDetails.xsp?id=WDU20040540535) | Źródło pierwotne |
| Ustawa o ryczałcie | [isap.sejm.gov.pl](https://isap.sejm.gov.pl/isap.nsf/DocDetails.xsp?id=WDU19981440930) | Źródło pierwotne |
| Ministerstwo Finansów | [podatki.gov.pl](https://www.podatki.gov.pl) | Stawki, formularze, e-US |
| KIS / interpretacje | [eureka.mf.gov.pl](https://eureka.mf.gov.pl) | Interpretacje indywidualne |
| CEIDG | [biznes.gov.pl/pl/firma/ceidg](https://www.biznes.gov.pl/pl/firma/ceidg) | Rejestracja JDG |
| ZUS | [zus.pl](https://www.zus.pl) | Składki, e-PUE, kalkulatory |
| NBP kursy | [nbp.pl/kursy](https://www.nbp.pl/kursy) | Kurs średni NBP |
| Biała lista VAT | [podatki.gov.pl/wykaz-podatnikow-vat-wyszukiwarka/](https://www.podatki.gov.pl/wykaz-podatnikow-vat-wyszukiwarka/) | Weryfikacja VAT |
| KSeF | [ksef.mf.gov.pl](https://ksef.mf.gov.pl) | Krajowy System e-Faktur |

## Zasady pracy

- **Weryfikuj stawki przy każdej kalkulacji.** Minimalne wynagrodzenie, prognozowane przeciętne wynagrodzenie, progi skali — zmieniają się corocznie. Weryfikować w obwieszczeniach MF i ustawie budżetowej na dany rok.
- **Polski Ład — liczne nowelizacje.** Od 2022:
  - **Polski Ład 1.0** (01.01.2022): 12% stawka PIT na skali, kwota wolna 30 000, ulga dla klasy średniej (potem uchylona), składka zdrowotna 9%/4,9%/zryczałtowana, brak odliczenia od podatku.
  - **Polski Ład 2.0** (01.07.2022): uchylenie ulgi dla klasy średniej; obniżenie stawki z 17% na 12% w skali; wspólne rozliczenie z samotnym rodzicem przywrócone.
  - **2023**: częściowe odliczenie składki zdrowotnej dla liniowego i ryczałtu.
  - **2024-2026**: dalsze korekty (weryfikować aktualny stan).
- **Dosłowność cytatów aktów prawnych.** Art. 30c, art. 30b, art. 21 ust. 1 ustawy o PIT — zawsze w redakcji z konkretnej daty.
- **Odniesienia obowiązkowe.** Do źródła pierwotnego (isap.sejm.gov.pl), do wyjaśnień MF (podatki.gov.pl), do interpretacji KIS (eureka.mf.gov.pl).
- **Nie wymyślać interpretacji.** Interpretacje indywidualne (IPI) KIS mają numer i datę; jeśli nie uda się znaleźć — nie odnosić się.
- **Dane osobowe.** Szablony — placeholdery (`[imię i nazwisko]`, `[PESEL]`, `[NIP]`, `[REGON]`, `[adres]`, `[numer konta]`).

## Zasady nazewnictwa

- Pliki agentów/skillów — bez prefiksu (`jdg-registrator.md`, `skills/calculating-ryczalt/SKILL.md`). Prefiks `pl:` dodawany automatycznie z `name` w `plugin.json`.
- W dokumentacji — odwołania przez wywołanie (`pl:jdg-registrator`), aby użytkownik widział dokładną komendę.

## Codex support

This plugin also has Codex support. Keep `AGENTS.md` and `.codex-plugin/plugin.json` in sync with this Claude-facing file and `.claude-plugin/plugin.json` when user-visible behavior changes. Claude Code continues to use the existing Claude plugin ID; Codex may use a collision-safe ID documented in `AGENTS.md`.

Codex custom-agent files are generated into `.codex/agents/*.toml` from the Claude `agents/*.md` files. Keep `agents/*.md` authoritative, run `python3 scripts/convert-agents-to-codex.py` after agent edits, and verify with `python3 scripts/validate-codex-agents.py`. Do not hand-maintain generated TOML unless the converter is updated too. Current Codex plugin manifests do not declare agents directly; `.codex/agents/` is the compatibility/import layer.
