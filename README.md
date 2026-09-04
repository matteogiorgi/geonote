# Geonote

Raccolta di note teoriche pensate come riferimento rapido e materiale di ripasso. Gli appunti spaziano dai fondamenti dei linguaggi di programmazione (sistemi di tipi, OOP, closure) alla teoria della computazione (riduzioni, classi di complessità, costo algoritmico) e qualche richiamo di matematica e statistica.

Chiude la raccolta una sezione di problemi tipici da colloquio tecnico e competizioni, risolti con più approcci (ricorsione diretta, programmazione dinamica, forme chiuse).




## Teoria, fondamenti e curiosità

- **[Sistemi di tipi](teoria_tipi.md)**: statico/dinamico, forte/debole, inferenza, null/option, ADT, polimorfismo.
- **[I tipi _Go_ e OOP](fondamenti_go_oop.md)**: predicati, contratti, struct type, interfacce, ereditarietà, multiple dispatch.
- **[I tipi _Guile_ e GOOPS](fondamenti_guile_oop.md)**: predicati, contratti, record type, classi, ereditarietà, multiple dispatch.
- **[I tipi _R_ e S3/S4/R6](fondamenti_r_oop.md)**: predicati, contratti, coercizioni, S3, S4, multiple dispatch, R6.
- **[Closure](teoria_chiusure.md)**: definizione, upward funarg problem, rappresentazione a runtime e confronti.
- **[Regex](teoria_regex.md)**: sintassi, matching, flavor (POSIX/PCRE/RE2/ECMAScript), ReDoS, con esempi.

<div align="center">⸻⸻⸻</div>

- **[Classi di complessità](teoria_complessita.md)**: notazione, MdT, P, NP, co-NP, NP-completezza, PSPACE, EXPTIME.
- **[Costo algoritmico](teoria_costo.md)**: caso pessimo, ottimo, medio e ammortizzato con tecniche di calcolo.
- **[Riduzioni](teoria_riduzioni.md)**: many-one, Turing, da SAT a Vertex Cover, teorema di Cook-Levin.

<div align="center">⸻⸻⸻</div>

- **[Fondamenti _Go_](fondamenti_go.md)**: sintassi base (variabili e tipi, strutture di controllo, funzioni, concorrenza).
- **[Fondamenti _Guile_](fondamenti_guile.md)**: sintassi base (S-espressioni, tipi di dato, funzioni, ricorsione e scripting).
- **[Fondamenti _R_](fondamenti_r.md)**: elementi per il calcolo statistico (tipi di dato, vettori, matrici, strutture dati).

<div align="center">⸻⸻⸻</div>

- **[Elementi di Analisi](teoria_analisi1.md)**: prerequisiti per Analisi 2 (successioni, serie, integrale di Riemann).
- **[Elementi di Probabilità](teoria_probabilita.md)**: prerequisiti per Probabilità 2 (spazi di probabilità, variabili aleatorie, distribuzioni).
- **[Elementi di Statistica](teoria_statistica.md)**: prerequisiti per Statistica 2 (variabili aleatorie, distribuzioni, stima e test d'ipotesi).

<div align="center">⸻⸻⸻</div>

- **[Geoteo _CSS_](tema_geoteo.md)**: come ereditare stile, *MathJax* e *Mermaid* da `geoteo.net`.
- **[GitHub Actions](github_actions.md)**: come aggiornare automaticamente il repository con GitHub Actions.




## Interview problems e programmazione competitiva

- **[Risolvere Fibonacci](problema_fibonacci.md)**: ricorsione diretta, PD *top-down* (memoization) e *bottom-up*.
- **[Numero di BST](problema_bst.md)**: ricorsione, PD, forma chiusa e numeri di Catalan.
- **[Matching di regex](problema_regex_matching.md)**: implementazione di `.` e `*` con ricorsione diretta e PD.
- **[Partizione insieme](problema_partizione_uguale.md)**: ricorsione diretta e PD, ottimizzazione spazio e tempo.
- **[Scomposizione di stringhe](problema_scomposizione_stringhe.md)**: ricorsione diretta, PD top-down e bottom-up (BFS).
