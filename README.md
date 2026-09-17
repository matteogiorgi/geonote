# Geonote — `(cons geo note)`

Raccolta work in progress (†) di note teoriche pensate come riferimento rapido e materiale di ripasso. Gli appunti spaziano dai fondamenti dei linguaggi di programmazione (sistemi di tipi, OOP, closure) alla teoria della computazione (riduzioni, classi di complessità, costo algoritmico) e qualche richiamo di matematica e statistica.

Chiude la raccolta una sezione di problemi tipici da colloquio tecnico e competizioni, risolti con più approcci (ricorsione diretta, programmazione dinamica, forme chiuse).




## Teoria, fondamenti e curiosità

<img class="shot-img" src="pixel_astronaut_shifted_1.png" alt="astronaut_shifted_1" />

### Teoria dei linguaggi

- **[Sistemi di tipi](teoria_tipi.md)** — statico/dinamico, forte/debole, inferenza, null/option, ADT, polimorfismo.
- **[I tipi _Go_ e OOP](fondamenti_go_oop.md)** — predicati, contratti, struct type, interfacce, ereditarietà, multiple dispatch.
- **[I tipi _Guile_ e GOOPS](fondamenti_guile_oop.md)** — predicati, contratti, record type, classi, ereditarietà, multiple dispatch.
- **[I tipi _R_ e S3/S4/R6](fondamenti_r_oop.md)** — predicati, contratti, coercizioni, S3, S4, multiple dispatch, R6.
- **[Closure](teoria_chiusure.md)** — definizione, upward funarg problem, rappresentazione a runtime e confronti.
- **[Regex](teoria_regex.md)** — sintassi, matching, flavor (POSIX/PCRE/RE2/ECMAScript), ReDoS, con esempi.


### Teoria della computazione

- **[Classi di complessità](teoria_complessita.md)** — notazione, MdT, P, NP, co-NP, NP-completezza, PSPACE, EXPTIME.
- **[Costo algoritmico](teoria_costo.md)** — caso pessimo, ottimo, medio e ammortizzato con tecniche di calcolo.
- **[Riduzioni](teoria_riduzioni.md)** — many-one, Turing, da SAT a Vertex Cover, teorema di Cook-Levin.
- **[Auto-riferimento](teoria_autoriferimento.md)** — teorema di ricorsione, quine, teorema di Rice, Gödel machine, costo di NAS.
- **[Ottimizzazione e decidibilità](teoria_ottimizzazione.md)** — PL, ILP, ottimizzazione polinomiale e decimo problema di Hilbert.


### Fondamenti

- **[Fondamenti _Go_](fondamenti_go.md)** — sintassi base (variabili e tipi, strutture di controllo, funzioni, concorrenza).
- **[Fondamenti _Guile_](fondamenti_guile.md)** — sintassi base (S-espressioni, tipi di dato, funzioni, ricorsione e scripting).
- **[Fondamenti _R_](fondamenti_r.md)** — elementi per il calcolo statistico (tipi di dato, vettori, matrici, strutture dati).


### Matematica e statistica

- **[Teoria della misura](teoria_misura.md)** — insieme di Cantor, $\sigma$-algebre, misura e insieme di Vitali, integrale di Lebesgue.
- **[Metodi stocastici](teoria_metodi.md)** † — spazi di probabilità, variabili aleatorie, distribuzioni.
- **[Processi stocastici](teoria_processi.md)** † — catene di Markov, ergodicità, distribuzione stazionaria, processi di Poisson.
- **[Inferenza statistica](teoria_inferenza.md)** † — stima puntuale e per intervalli, test d'ipotesi.


### Strumenti e curiosità

- **[Geoteo _CSS_](tema_geoteo.md)** — come ereditare stile, *MathJax* e *Mermaid* da `geoteo.net`.
- **[GitHub Actions](azioni_github.md)** — workflow YAML, eventi, DAG di job, matrix, cache e permessi/OIDC.




## Interview problems e programmazione competitiva

<img class="shot-img" src="pixel_astronaut_shifted_2.png" alt="astronaut_shifted_2" />

### Programmazione dinamica

- **[Risolvere Fibonacci](problema_fibonacci.md)** — ricorsione diretta, PD *top-down* (memoization) e *bottom-up*.
- **[Numero di BST](problema_bst.md)** — ricorsione, PD, forma chiusa e numeri di Catalan.
- **[Matching di regex](problema_regex_matching.md)** — implementazione di `.` e `*` con ricorsione diretta e PD.
- **[Partizione insieme](problema_partizione_uguale.md)** — ricorsione diretta e PD, ottimizzazione spazio e tempo.
- **[Scomposizione di stringhe](problema_scomposizione_stringhe.md)** — ricorsione diretta, PD top-down e bottom-up (BFS).


### Problemi famosi

- **[Knapsack problem](problema_knapsack.md)** † — ottimizzazione con vincolo di capacità, PD 0/1 e frazionario.
- **[Ponti di Königsberg](problema_konigsberg.md)** † — teoria dei grafi, cammini e circuiti euleriani.
- **[Travelling salesman](problema_tsp.md)** † — NP-hardness, ricerca esaustiva, PD con bitmask (Held-Karp), euristiche.
- **[Postino cinese](problema_postino_cinese.md)** † — matching perfetto minimo, estensione del caso euleriano.
- **[N-Regine](problema_n_regine.md)** † — backtracking, pruning e PD con bitmask.
- **[Secretary problem](problema_secretary.md)** † — arresto ottimale, strategia a soglia e regola $1/e$.
