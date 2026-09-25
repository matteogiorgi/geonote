# Geonote — Appunti e problemi

Raccolta work in progress (†) di note teoriche pensate come riferimento rapido e materiale di ripasso. Gli appunti spaziano dai fondamenti dei linguaggi di programmazione (sistemi di tipi, OOP, closure) alla teoria della computazione (riduzioni, classi di complessità, costo algoritmico) e qualche richiamo di matematica e statistica.

Chiude la raccolta una sezione di problemi tipici da colloquio tecnico e competizioni, risolti con più approcci (ricorsione diretta, programmazione dinamica, forme chiuse).




## Teoria, fondamenti e curiosità

<img class="shot-img" src="pixel_astronaut_shifted_1.png" alt="astronaut_shifted_1" />

### Teoria dei linguaggi

- **[Sistemi di tipi](teoria_linguaggi/teoria_tipi.md)** — statico/dinamico, forte/debole, inferenza, null/option, ADT, polimorfismo.
- **[I tipi _Go_ e OOP](teoria_linguaggi/fondamenti_go_oop.md)** — predicati, contratti, struct type, interfacce, ereditarietà, multiple dispatch.
- **[I tipi _Guile_ e GOOPS](teoria_linguaggi/fondamenti_guile_oop.md)** — predicati, contratti, record type, classi, ereditarietà, multiple dispatch.
- **[I tipi _R_ e S3/S4/R6](teoria_linguaggi/fondamenti_r_oop.md)** — predicati, contratti, coercizioni, S3, S4, multiple dispatch, R6.
- **[Closure](teoria_linguaggi/teoria_chiusure.md)** — definizione, upward funarg problem, rappresentazione a runtime e confronti.
- **[Regex](teoria_linguaggi/teoria_regex.md)** — sintassi, matching, flavor (POSIX/PCRE/RE2/ECMAScript), ReDoS, con esempi.


### Teoria della computazione

- **[Classi di complessità](teoria_computazione/teoria_complessita.md)** — notazione, MdT, P, NP, co-NP, NP-completezza, PSPACE, EXPTIME.
- **[Costo algoritmico](teoria_computazione/teoria_costo.md)** — caso pessimo, ottimo, medio e ammortizzato con tecniche di calcolo.
- **[Riduzioni](teoria_computazione/teoria_riduzioni.md)** — many-one, Turing, da SAT a Vertex Cover, teorema di Cook-Levin.
- **[Auto-riferimento](teoria_computazione/teoria_autoriferimento.md)** — teorema di ricorsione, quine, teorema di Rice, Gödel machine, costo di NAS.
- **[Ottimizzazione e decidibilità](teoria_computazione/teoria_ottimizzazione.md)** — PL, ILP, ottimizzazione polinomiale e decimo problema di Hilbert.


### Fondamenti

- **[Fondamenti _Go_](fondamenti/fondamenti_go.md)** — sintassi base (variabili e tipi, strutture di controllo, funzioni, concorrenza).
- **[Fondamenti _Guile_](fondamenti/fondamenti_guile.md)** — sintassi base (S-espressioni, tipi di dato, funzioni, ricorsione e scripting).
- **[Fondamenti _R_](fondamenti/fondamenti_r.md)** — elementi per il calcolo statistico (tipi di dato, vettori, matrici, strutture dati).


### Matematica e statistica

- **[Teoria della misura](matematica_statistica/teoria_misura.md)** — insieme di Cantor, $\sigma$-algebre, misura e insieme di Vitali, integrale di Lebesgue.
- **[Metodi stocastici](matematica_statistica/teoria_metodi.md)** † — spazi di probabilità, variabili aleatorie, distribuzioni.
- **[Processi stocastici](matematica_statistica/teoria_processi.md)** † — catene di Markov, ergodicità, distribuzione stazionaria, processi di Poisson.
- **[Inferenza statistica](matematica_statistica/teoria_inferenza.md)** † — stima puntuale e per intervalli, test d'ipotesi.


### Strumenti e curiosità

- **[Geoteo _CSS_](strumenti_curiosita/tema_geoteo.md)** — come ereditare stile, *MathJax* e *Mermaid* da `geoteo.net`.
- **[GitHub Actions](strumenti_curiosita/azioni_github.md)** — workflow YAML, eventi, DAG di job, matrix, cache e permessi/OIDC.
- **[Second brain](strumenti_curiosita/second_brain.md)** — archivio di note agnostico: nucleo e adattatori, formato, `AGENTS.md`, workflow, cattura.




## Interview problems e programmazione competitiva

<img class="shot-img" src="pixel_astronaut_shifted_2.png" alt="astronaut_shifted_2" />

### Programmazione dinamica

- **[Risolvere Fibonacci](programmazione_dinamica/problema_fibonacci.md)** — ricorsione diretta, PD *top-down* (memoization) e *bottom-up*.
- **[Numero di BST](programmazione_dinamica/problema_bst.md)** — ricorsione, PD, forma chiusa e numeri di Catalan.
- **[Matching di regex](programmazione_dinamica/problema_regex_matching.md)** — implementazione di `.` e `*` con ricorsione diretta e PD.
- **[Partizione insieme](programmazione_dinamica/problema_partizione_uguale.md)** — ricorsione diretta e PD, ottimizzazione spazio e tempo.
- **[Scomposizione di stringhe](programmazione_dinamica/problema_scomposizione_stringhe.md)** — ricorsione diretta, PD top-down e bottom-up (BFS).


### Problemi famosi

- **[Knapsack problem](problemi_famosi/problema_knapsack.md)** † — ottimizzazione con vincolo di capacità, PD 0/1 e frazionario.
- **[Ponti di Königsberg](problemi_famosi/problema_konigsberg.md)** † — teoria dei grafi, cammini e circuiti euleriani.
- **[Travelling salesman](problemi_famosi/problema_tsp.md)** † — NP-hardness, ricerca esaustiva, PD con bitmask (Held-Karp), euristiche.
- **[Postino cinese](problemi_famosi/problema_postino_cinese.md)** † — matching perfetto minimo, estensione del caso euleriano.
- **[N-Regine](problemi_famosi/problema_n_regine.md)** † — backtracking, pruning e PD con bitmask.
- **[Secretary problem](problemi_famosi/problema_secretary.md)** † — arresto ottimale, strategia a soglia e regola $1/e$.
