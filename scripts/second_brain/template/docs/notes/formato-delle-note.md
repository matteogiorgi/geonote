---
title: Formato delle note
tags: [second-brain, convenzioni, markdown]
created: 2026-09-25
---

# Formato delle note

Convenzioni che ogni nota del [second brain](../areas/second-brain.md)
rispetta. Sono la parte più rigida del [nucleo](nucleo-e-adattatori.md):
cambiarle dopo significa riscrivere l'archivio.

## File

- Testo UTF-8, fine riga LF, newline finale.
- Estensione `.md`.
- A capo manuale intorno alle 72 colonne, come in un messaggio di commit.

## Nomi

- Minuscolo, parole separate da trattini, solo ASCII:
  `processi-poisson-composti.md`, non `Processi Poisson composti.md` né
  `probabilità.md` (diventa `probabilita.md`). Gli accenti vanno nel
  testo e nel titolo, non nel nome del file.
- Il nome descrive il contenuto ed è stabile: non si rinomina un file per
  capriccio, perché ogni rinomina rompe dei link.
- Eccezioni con formato fisso: `journal/AAAA-MM-GG.md` e, in `inbox/`,
  nomi a timestamp generati dalla [cattura](cattura-da-shell.md).

## Frontmatter

Ogni nota inizia con un blocco YAML, tranne gli appunti grezzi in
`inbox/` e `archive/inbox/`:

```yaml
---
title: Processi di Poisson composti
tags: [probabilita, metodi-stocastici]
created: 2026-09-25
---
```

- `title`: titolo leggibile, con accenti e maiuscole.
- `tags`: lista, minuscolo, kebab-case, ASCII come i nomi dei file.
- `created`: data ISO 8601.

Campi facoltativi, solo quando servono: `updated` (data dell'ultima
revisione sostanziale), `source` (libro, articolo, lezione da cui viene
il contenuto).

Nessun altro campo senza aggiornare prima questa nota.

## Link

- Link Markdown standard con percorso relativo al file corrente,
  estensione inclusa: `[processo di Poisson](processo-poisson.md)`,
  `[second brain](../areas/second-brain.md)`.
- Il testo del link si legge come parte della frase; niente "clicca qui".
- Niente `[[wikilink]]`, niente percorsi assoluti.
- Niente link a sezioni (`nota.md#sezione`) se non strettamente
  necessario: ogni strumento genera gli identificativi delle sezioni in
  modo diverso. Se una sezione merita di essere linkata, probabilmente
  merita una nota propria.
- Si linka solo a note esistenti. Un concetto che meriterebbe una nota ma
  non ce l'ha resta testo semplice finché la nota non viene scritta.

## Struttura interna

- Un solo titolo di livello 1, uguale a `title`.
- Sezioni di livello 2; il livello 3 solo se davvero necessario.
- Una sola idea per nota. Se servono due titoli di livello 1, sono due
  note.
- Quando una nota contiene una scelta, una sezione **Perché** la motiva.
- L'ultima sezione è sempre **Collegamenti**, anche breve; se c'è
  **Perché**, viene subito prima.

## Estensioni ammesse

Oltre a CommonMark, solo estensioni diffuse e leggibili anche come testo
grezzo:

- blocchi di codice recintati con l'indicazione del linguaggio;
- tabelle nello stile GitHub, per dati brevi;
- matematica LaTeX tra `$...$` e `$$...$$`.

La matematica non è CommonMark, ma è supportata da pandoc, GitHub e dai
visualizzatori con KaTeX o MathJax, e resta leggibile come sorgente.
È un compromesso consapevole: per appunti di probabilità e statistica
rinunciarvi costerebbe più della portabilità che si guadagna.

## Perché

**Link relativi invece di wikilink.** I wikilink sono un'estensione:
funzionano solo negli strumenti che li implementano. I link relativi li
capiscono GitHub, pandoc, qualsiasi visualizzatore Markdown, e Vim li
segue con `gf`. Costano qualche carattere in più, che l'agente scrive al
posto mio.

**Nomi ASCII in kebab-case.** Sicuri in qualsiasi shell senza virgolette,
uguali su ogni file system, facili da completare con il tab.

**Cartelle piatte, struttura nei tag e nei link.** Un'idea può
appartenere a più argomenti; una cartella la costringe in uno solo. E una
nota che non si sposta non rompe i link che puntano a lei.

**A capo manuale.** Diff di git più leggibili e testo comodo da leggere
nel terminale. L'alternativa seria è una frase per riga, che dà diff
ancora più puliti; ho scelto le 72 colonne perché si leggono meglio
anche senza un visualizzatore.

**Frontmatter minimo.** Ogni campo in più è un campo da mantenere su
centinaia di note. Tre obbligatori bastano per ordinare, filtrare e
datare.

## Collegamenti

- [Second brain](../areas/second-brain.md)
- [Nucleo e adattatori](nucleo-e-adattatori.md)
- [Istruzioni agent-agnostiche](istruzioni-agent-agnostiche.md)
