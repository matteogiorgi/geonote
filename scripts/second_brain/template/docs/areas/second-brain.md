---
title: Second brain editor-agnostico e agent-agnostico
tags: [second-brain, pkm, workflow, strumenti]
created: 2026-09-25
---

# Second brain editor-agnostico e agent-agnostico

## Idea

Un archivio personale di note in testo semplice, versionato con git, che
posso leggere e scrivere con qualsiasi editor e far organizzare da
qualsiasi agente AI. I file sono l'unica fonte di verità; editor e agenti
sono intercambiabili e si collegano al sistema tramite adattatori sottili.

Test di correttezza: se elimino tutti gli adattatori, il sistema deve
continuare a funzionare con `cat`, `grep` e `git`.

## Architettura

Il sistema ha tre livelli (dettagli in
[nucleo e adattatori](../notes/nucleo-e-adattatori.md)):

- **Nucleo**: le note, il loro [formato](../notes/formato-delle-note.md),
  la struttura delle cartelle, le
  [istruzioni per gli agenti](../notes/istruzioni-agent-agnostiche.md)
  (`AGENTS.md`) e le procedure (`workflows/`).
- **Adattatori**: configurazioni specifiche per un editor (`editors/`) o
  per un agente (`CLAUDE.md`, `.claude/commands/`, ecc.). Sono sottili,
  non contengono logica e si possono buttare via.
- **Cattura**: uno script POSIX che scrive nell'inbox da qualunque
  terminale (vedi [cattura da shell](../notes/cattura-da-shell.md)).

```
brain/
├── AGENTS.md          # istruzioni operative per qualsiasi agente
├── CLAUDE.md          # adattatore: importa AGENTS.md
├── inbox/             # appunti grezzi, da smistare
├── notes/             # note atomiche, piatte, una idea per file
├── projects/          # cose con una fine (esami, tesi, repo)
├── areas/             # responsabilità continue (studio, carriera, questo sistema)
├── journal/           # note giornaliere, AAAA-MM-GG.md
├── archive/           # note ritirate: qui non si cancella, si sposta
│   └── inbox/         # appunti originali già smistati
├── workflows/         # procedure in prosa, leggibili da persone e agenti
├── bin/               # script POSIX: capture, links
├── editors/           # adattatori editor (vim/, ...)
└── .claude/
    └── commands/      # adattatori: ogni comando rimanda a un workflow
```

## Costruzione

L'archivio si crea con `init.sh`, che copia i file di partenza senza
mai sovrascrivere quelli esistenti:

```sh
init.sh --claude --vim --docs ~/brain
```

Il nucleo (cartelle, `AGENTS.md`, `workflows/`, `bin/`) viene creato
sempre; `--claude`, `--vim` e `--docs` aggiungono gli adattatori per
Claude Code, quello per Vim e queste note di documentazione. Dopo,
seguendo i passi che lo script stampa alla fine:

1. esportare `BRAIN` e aggiungere `bin/` al `PATH` nel profilo della
   shell, come in [cattura da shell](../notes/cattura-da-shell.md);
2. con `--vim`, caricare `editors/vim/brain.vim` dal `vimrc`;
3. con `--claude`, lanciare Claude Code dentro l'archivio;
4. completare `AGENTS.md` con le informazioni sull'archivio che l'agente
   deve sapere;
5. fare il primo commit.

Senza lo script si procede a mano con gli stessi passi: creare le
cartelle e `git init`, scrivere `AGENTS.md` e i workflow, poi gli
adattatori.

## Uso quotidiano

1. **Catturare** senza pensare: `capture "idea"` o direttamente un file
   nuovo in `inbox/`. Nessuna decisione su dove va o come si chiama.
2. **Smistare** una volta al giorno con il workflow `triage`: l'agente
   assegna frontmatter, nome, destinazione e collegamenti.
3. **Interrogare** con il workflow `ask` quando serve ritrovare qualcosa:
   l'agente risponde solo dalle note e cita i file.
4. **Rivedere** con `git diff` quello che l'agente ha modificato, poi
   committare.

## Manutenzione

**Ogni settimana**: inbox a zero; scorrere `git log` della settimana;
lanciare `connect` per trovare collegamenti mancanti.

**Ogni mese**: spostare in `archive/` i progetti chiusi; rivedere i
tag (unificare i sinonimi, eliminare quelli usati una volta sola);
rileggere `AGENTS.md` e correggere le istruzioni che l'agente ha
frainteso nel mese.

**Quando cambio editor**: scrivo un nuovo adattatore in `editors/`. Nulla
nel nucleo deve cambiare; se devo toccare il nucleo, l'ho progettato male.

**Quando cambio agente**: scrivo il suo adattatore, cioè il file che
legge all'avvio (che rimanda ad `AGENTS.md`) e i suoi comandi (che
rimandano ai file in `workflows/`). Se l'agente legge `AGENTS.md`
nativamente, non serve altro.

## Note collegate

- [Nucleo e adattatori](../notes/nucleo-e-adattatori.md)
- [Formato delle note](../notes/formato-delle-note.md)
- [Istruzioni agent-agnostiche](../notes/istruzioni-agent-agnostiche.md)
- [Cattura da shell](../notes/cattura-da-shell.md)
