---
title: Nucleo e adattatori
tags: [second-brain, architettura, strumenti]
created: 2026-09-25
---

# Nucleo e adattatori

## Principio

Un sistema che deve sopravvivere ai propri strumenti va diviso in due
parti: un **nucleo** che contiene tutto ciò che ha valore, e degli
**adattatori** che collegano il nucleo a uno strumento specifico. Il
nucleo non sa nulla degli strumenti; gli adattatori sanno tutto del
nucleo, ma non contengono nulla di proprio.

È lo stesso schema dell'architettura esagonale (*ports and adapters*)
nel software: il dominio non dipende dall'infrastruttura, è
l'infrastruttura che dipende dal dominio.

## Il nucleo

Sta nel nucleo tutto ciò che conserva senso indipendentemente dallo
strumento con cui lo si usa:

- le note stesse, nel loro [formato](formato-delle-note.md);
- la struttura delle cartelle;
- le istruzioni per gli agenti (`AGENTS.md`), vedi
  [istruzioni agent-agnostiche](istruzioni-agent-agnostiche.md);
- le procedure in `workflows/`, scritte in prosa;
- gli script in `bin/`, scritti in shell POSIX;
- la storia in git.

Criterio: una cosa appartiene al nucleo se ha ancora senso dopo che ho
disinstallato ogni editor e ogni agente.

## Gli adattatori

Un adattatore traduce il nucleo nel linguaggio di uno strumento. Esempi:

- `CLAUDE.md`, che contiene solo `@AGENTS.md`;
- `.claude/commands/triage.md`, che dice solo di eseguire
  `workflows/triage.md`;
- `editors/vim/`, con le impostazioni per ricaricare i file e seguire i
  link relativi.

Un buon adattatore rispetta quattro regole.

1. **È sottile.** Poche righe; se cresce, sta assorbendo logica che
   appartiene al nucleo.
2. **Punta in una sola direzione.** L'adattatore rimanda al nucleo, mai il
   contrario. Nessuna nota, nessun workflow e nessuno script dipende da un
   editor o da un agente specifico: può citarlo come esempio, non
   richiederlo per funzionare.
3. **Non ha stato proprio.** Non conserva dati che non siano anche nel
   nucleo: cache, indici e database di uno strumento sono ricostruibili,
   quindi sacrificabili.
4. **È sostituibile.** Posso cancellarlo e riscriverlo per un altro
   strumento in pochi minuti.

## Dove va una cosa nuova

Quando aggiungo qualcosa al sistema, mi chiedo: *ha senso senza questo
strumento?* Se sì, va nel nucleo, anche se l'ho scritta pensando a uno
strumento preciso. Se no, è un adattatore, e ne controllo la sottigliezza.

Caso tipico: una funzionalità specifica di un agente, come un hook che
esegue qualcosa dopo ogni modifica. La logica va in uno script in `bin/`;
l'hook si limita a chiamare lo script. Così un altro agente, o io a mano,
posso fare la stessa cosa.

## Test di correttezza

Elimino mentalmente `CLAUDE.md`, `.claude/`, `editors/` e ogni altro
adattatore. Posso ancora catturare, leggere, cercare, collegare e
versionare le note con `cat`, `grep`, un editor qualsiasi e `git`? Se sì,
il confine è tracciato bene.

## Limiti

La portabilità ha un prezzo: alcune comodità restano legate a uno
strumento e non migrano. Il grafo dei collegamenti di un'estensione, la
vista dei diff nell'editor, i completamenti automatici dei link. Le accetto
come comodità dell'adattatore, a patto che nessuna diventi indispensabile
per usare il sistema.

## Perché

Gli strumenti cambiano più in fretta delle idee, e gli agenti AI in
particolare cambiano ogni pochi mesi. Il testo semplice e git invece
durano decenni. Separare nucleo e adattatori significa che il valore
accumulato (le note, le convenzioni, le procedure) non resta ostaggio
dello strumento del momento, e che provare uno strumento nuovo costa
un adattatore, non una migrazione.

## Collegamenti

- [Second brain](../areas/second-brain.md)
- [Formato delle note](formato-delle-note.md)
- [Istruzioni agent-agnostiche](istruzioni-agent-agnostiche.md)
