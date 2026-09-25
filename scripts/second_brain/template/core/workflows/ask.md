# Ask

## Scopo

Rispondere a una domanda usando l'archivio come fonte, così da ritrovare
ciò che ho già scritto invece di ricostruirlo da zero.

## Input

La domanda dell'utente.

## Passi

1. Individua i concetti chiave della domanda e i loro sinonimi, anche in
   inglese se il termine tecnico è inglese.
2. Cerca in `notes/`, `projects/`, `areas/` e `journal/`: nei titoli,
   nei tag e nel testo. Non cercare in `archive/` a meno che la domanda
   non lo richieda o che il resto non basti.
3. Leggi le note rilevanti per intero e segui i loro collegamenti per un
   livello, per raccogliere il contesto.
4. Componi la risposta a partire da ciò che dicono le note.
5. Se le note non bastano a rispondere, dillo esplicitamente. Puoi
   integrare con conoscenze generali solo in una parte separata e
   dichiarata come tale.

## Output

- La risposta, citando per ogni affermazione la nota da cui viene, con il
  percorso relativo alla radice (`notes/processi-poisson.md`).
- Se ci sono, le lacune: cosa manca nell'archivio per rispondere bene.
- Se ci sono, le contraddizioni: note che dicono cose incompatibili.

## Vincoli

- Sola lettura: questo workflow non modifica, crea né sposta file.
- Non attribuire alle note ciò che non dicono. Una parafrasi deve restare
  fedele; nel dubbio, cita la frase.
