# Triage

## Scopo

Svuotare `inbox/` trasformando ogni appunto grezzo in contenuto
dell'archivio, nel formato corretto e collegato al resto.

## Input

Tutti i file di `inbox/`, esclusi i file nascosti.

## Passi

1. Leggi tutti gli appunti prima di modificare qualcosa: appunti vicini
   possono parlare della stessa idea e vanno trattati insieme.
2. Per ogni appunto (o gruppo di appunti sulla stessa idea), cerca nelle
   note esistenti se l'argomento è già trattato: cerca nei titoli, nei
   tag e nel testo, provando anche sinonimi e termini correlati.
3. Scegli una delle tre strade:
   - **Integrare**: se esiste una nota sulla stessa idea, aggiungi lì il
     contenuto nuovo, nella sezione giusta, e aggiorna `updated`.
   - **Creare**: se l'idea è nuova, crea una nota nel formato previsto.
     Destinazione predefinita `notes/`; `projects/` o `areas/` solo se
     l'appunto riguarda chiaramente un progetto o un'area esistente.
   - **Chiedere**: se l'appunto è ambiguo, troppo breve per capirne il
     senso, o potrebbe andare in più posti, non decidere: mettilo nella
     lista delle domande.
4. Se il contenuto viene da una fonte (un libro, una lezione, un file
   passato dall'utente), compila `source` nella nota.
5. Per ogni nota creata o modificata, cerca note correlate e aggiungi i
   collegamenti in entrambe le direzioni, nella sezione `## Collegamenti`
   o nel testo dove il riferimento è naturale.
6. Sposta ogni appunto smistato in `archive/inbox/`, con lo stesso nome.
   Gli appunti in attesa di risposta restano in `inbox/`. Un file che
   non è testo (un PDF, un'immagine) non va in `archive/inbox/`: lascialo
   dov'è e segnalalo nel riepilogo.

## Output

Un riepilogo in tre parti, più una quarta se serve:

- appunti smistati: per ciascuno, la nota creata o integrata;
- collegamenti aggiunti: coppie di note;
- domande: per ogni appunto rimasto in `inbox/`, cosa serve sapere per
  smistarlo;
- fonti non di testo: quali file l'utente deve conservare fuori
  dall'archivio.

## Vincoli

- Riporta il contenuto degli appunti, riformulandolo in modo chiaro ma
  senza aggiungere informazioni che non c'erano.
- Un appunto di una sola riga senza contesto non diventa una nota nuova:
  va integrato in una nota esistente o finisce tra le domande.
- `title` e nome del file descrivono il contenuto, non la data o
  l'origine dell'appunto.
