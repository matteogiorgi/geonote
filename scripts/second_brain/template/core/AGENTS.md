# AGENTS.md

## Scopo

Archivio personale di note, in testo semplice e versionato con git.
Serve a raccogliere, collegare e ritrovare idee di studio, lavoro e
progetti. Il tuo compito è organizzarlo e interrogarlo secondo le regole
qui sotto.

## Struttura

- `inbox/`: appunti grezzi appena catturati, senza formato. Da smistare.
- `notes/`: note atomiche, una idea per file, tutte allo stesso livello.
  È la destinazione predefinita.
- `projects/`: note legate a qualcosa con una fine (un esame, una tesi,
  un repository).
- `areas/`: note su responsabilità continue (studio, carriera, questo
  archivio).
- `journal/`: note giornaliere, `AAAA-MM-GG.md`.
- `archive/`: note ritirate; `archive/inbox/` per gli appunti originali
  già smistati.
- `workflows/`: procedure da eseguire su richiesta.
- `bin/`: script di supporto (`capture`, `links`). Puoi eseguirli, non
  modificarli.
- `editors/`, `CLAUDE.md`, `.claude/` e altri file di configurazione
  degli strumenti: non sono note, non toccarli.

## Formato

La fonte completa, se presente, è `notes/formato-delle-note.md`; in
sintesi:

- Nomi file: minuscolo, kebab-case, solo ASCII, estensione `.md`.
- Frontmatter YAML obbligatorio, tranne che in `inbox/` e
  `archive/inbox/`: `title`, `tags` (lista, minuscolo, kebab-case,
  ASCII), `created` (AAAA-MM-GG).
  Facoltativi: `updated`, `source`. Nessun altro campo.
- Un solo titolo di livello 1, uguale a `title`; sezioni di livello 2.
- Link Markdown relativi al file corrente, con estensione:
  `[testo](altra-nota.md)`, `[testo](../areas/nota.md)`. Mai wikilink,
  mai percorsi assoluti, niente link a sezioni.
- A capo manuale intorno alle 72 colonne.
- Matematica in LaTeX tra `$...$` e `$$...$$`.
- Chiudere ogni nota con una sezione `## Collegamenti`; quando la nota
  contiene una scelta, aggiungere subito prima una sezione `## Perché`.
- Lingua: italiano. Termini tecnici in inglese dove sono lo standard.

## Regole ferme

- Non cancellare mai file: sposta in `archive/`.
- Non creare link verso note inesistenti.
- Non modificare file fuori da questa cartella.
- Non modificare file di configurazione degli strumenti senza richiesta
  esplicita.
- Non fare commit: lascia le modifiche da rivedere con `git diff`.
- Non inventare contenuto: le note riportano ciò che è negli appunti o
  che l'utente ha chiesto di scrivere.
- In caso di dubbio su dove va una nota, come chiamarla o se unirla a
  un'altra, chiedi invece di decidere.

## Workflow disponibili

Quando ti viene chiesto di eseguire un workflow, leggi il file
corrispondente e seguilo.

- `workflows/triage.md`: smista gli appunti di `inbox/` in note vere.
- `workflows/ask.md`: risponde a una domanda usando solo le note.
- `workflows/connect.md`: trova collegamenti mancanti, note orfane e
  link rotti.
