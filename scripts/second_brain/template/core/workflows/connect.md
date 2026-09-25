# Connect

## Scopo

Mantenere sana la rete di collegamenti: trovare note che dovrebbero
citarsi e non lo fanno, note isolate e link rotti.

## Input

L'ambito indicato dall'utente: una nota, una cartella o un tag. Se non
è indicato, tutte le note fuori da `archive/` (`answers/` non contiene
note).

## Passi

1. **Link rotti.** Per ogni link relativo nell'ambito, verifica che il
   file di destinazione esista.
2. **Note orfane.** Elenca le note dell'ambito che non ricevono link da
   nessun'altra nota. Contano i link che partono da `journal/`, non
   quelli che partono da `archive/`. Le note di `journal/` sono escluse
   da questo controllo.

   Per i passi 1 e 2 puoi usare `bin/links`, che li esegue sull'intero
   archivio; poi filtra il risultato sull'ambito.
3. **Collegamenti mancanti.** Per ogni nota dell'ambito, individua i
   concetti principali e cerca altre note che li trattano senza essere
   collegate. Proponi un collegamento solo se una delle due note aiuta
   davvero a capire l'altra; condividere un tag non basta.
4. Presenta i risultati e aspetta conferma.
5. Applica solo i collegamenti confermati, in entrambe le direzioni,
   nella sezione `## Collegamenti` o nel testo.

## Output

Prima della conferma, tre elenchi:

- link rotti: nota, link, e se esiste un file con nome simile che
  potrebbe essere la destinazione giusta;
- note orfane;
- collegamenti proposti: coppia di note e una riga sul perché.

Dopo la conferma, l'elenco delle modifiche fatte.

## Vincoli

- Non correggere i link rotti da solo: proponi la correzione.
- Non creare note nuove per colmare lacune: segnalale.
- Meglio pochi collegamenti significativi che molti deboli.
