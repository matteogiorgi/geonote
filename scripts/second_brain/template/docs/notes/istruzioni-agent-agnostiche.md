---
title: Istruzioni agent-agnostiche
tags: [second-brain, agenti, convenzioni]
created: 2026-09-25
---

# Istruzioni agent-agnostiche

## Il problema

Ogni agente AI cerca le proprie istruzioni in un posto diverso: un file
con un nome specifico nella radice del progetto, una cartella di comandi
con una sintassi propria. Se scrivo le istruzioni lì, il sistema diventa
di quell'agente. Le istruzioni sono invece la parte più preziosa del
lavoro con un agente, perché accumulano tutto ciò che ho imparato su come
farlo lavorare bene, e vanno trattate come
[nucleo](nucleo-e-adattatori.md).

## Due livelli

- **`AGENTS.md`**, nella radice: ciò che l'agente deve sapere *sempre*,
  in ogni sessione. Contesto e regole.
- **`workflows/`**: ciò che l'agente deve fare *quando glielo chiedo*.
  Una procedura per file.

`AGENTS.md` è breve perché viene letto ogni volta; i workflow possono
essere dettagliati perché vengono letti solo quando servono.

## AGENTS.md

Contiene, in quest'ordine:

1. **Scopo**: due righe su cosa è l'archivio e a chi serve.
2. **Struttura**: le cartelle e a cosa serve ciascuna.
3. **Formato**: un riassunto operativo delle regole, con rimando a
   `notes/formato-delle-note.md` come fonte completa.
4. **Regole ferme**: ciò che l'agente non fa mai (vedi sotto).
5. **Workflow disponibili**: elenco dei file in `workflows/`, una riga
   ciascuno.

Non contiene spiegazioni del perché delle scelte: quelle stanno nelle
note, dove le leggo io. `AGENTS.md` è scritto per chi esegue, le note per
chi capisce.

## Regole ferme

Il nucleo minimo, da riportare in `AGENTS.md`:

- Non cancellare note: spostarle in `archive/`.
- Non creare link verso note inesistenti.
- Non modificare file fuori dall'archivio.
- Non modificare gli adattatori senza richiesta esplicita.
- Non fare commit: lasciare le modifiche da rivedere con `git diff`.
- In caso di dubbio su dove va una nota o come chiamarla, chiedere invece
  di decidere.

## workflows/

Ogni file descrive una procedura in prosa imperativa, con la stessa
struttura:

```markdown
# Triage

## Scopo
Svuotare inbox/ assegnando a ogni appunto una destinazione.

## Input
Tutti i file in inbox/.

## Passi
1. Per ogni file, capire di cosa parla.
2. Se esiste già una nota sullo stesso argomento, integrare lì il
   contenuto; altrimenti creare una nota nuova secondo il formato.
3. Cercare note correlate e aggiungere i collegamenti in entrambe le
   direzioni.
4. Spostare il file originale in archive/inbox/.

## Output
Un riepilogo: per ogni appunto, dove è finito e quali link sono stati
aggiunti.

## Vincoli
Nessuna nota nuova per appunti di una riga senza contesto: chiedere.
```

Due regole per scriverli:

- **Nessuna sintassi di un agente.** Gli argomenti si nominano in prosa
  ("la domanda dell'utente"), non con segnaposto specifici di uno
  strumento; sarà l'adattatore a passarli.
- **Eseguibili a mano.** Un workflow deve essere abbastanza chiaro da
  poterlo seguire io, senza agente. Se non ci riesco, è scritto male
  anche per l'agente.

## Adattatori per un agente

Un agente nuovo richiede al massimo due cose.

**Il file letto all'avvio.** Se l'agente legge `AGENTS.md` da solo, non
serve nulla. Altrimenti, un file col nome che si aspetta, che importa
`AGENTS.md` se l'agente supporta gli import, o che contiene una sola
frase: "Leggi `AGENTS.md` e seguine le istruzioni."

**I comandi.** Uno per workflow, di una riga, che rimanda al file e passa
gli eventuali argomenti con la sintassi dell'agente, per esempio:
"Esegui `workflows/ask.md`. Domanda: $ARGUMENTS". I comandi sono una
comodità: in loro assenza basta chiedere all'agente di eseguire il
workflow per nome.

## Test

Apro una sessione con un agente diverso da quello abituale, o senza
adattatori, e gli chiedo di eseguire un workflow dopo aver letto solo
`AGENTS.md`. Se il risultato è comparabile, le istruzioni sono davvero
agnostiche.

## Perché

**Prosa invece di configurazione.** La prosa è l'unica interfaccia che
tutti gli agenti capiscono, e continueranno a capire. Qualsiasi formato
strutturato specifico è una scommessa sulla longevità di uno strumento.

**Workflow eseguibili a mano.** Il sistema degrada con grazia: senza
agente diventa più lento, non inutilizzabile.

**Separare ciò che si sa da ciò che si fa.** Un file unico con contesto e
procedure cresce finché l'agente non lo legge più con attenzione. Due
livelli tengono corto ciò che viene letto sempre.

**Niente commit da parte dell'agente.** La revisione del diff è il
momento in cui mi accorgo degli errori e aggiorno le istruzioni; saltarla
significa perdere il meccanismo con cui il sistema migliora.

## Collegamenti

- [Second brain](../areas/second-brain.md)
- [Nucleo e adattatori](nucleo-e-adattatori.md)
- [Formato delle note](formato-delle-note.md)
