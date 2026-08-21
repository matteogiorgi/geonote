# Riduzioni tra problemi

Le **riduzioni** sono lo strumento con cui si confronta la difficoltà di due problemi diversi, e sono il meccanismo alla base delle dimostrazioni di **NP-completezza** introdotte in [classi_complessita.md](classi_complessita.md). Intuitivamente: *ridurre $A$ a $B$* significa mostrare che, avendo a disposizione un modo per risolvere $B$, si può risolvere anche $A$ senza troppo sforzo aggiuntivo.




## Mappa: cosa serve per cosa

- **Riduzione many-one (Karp)** → la più usata per confrontare problemi decisionali; è alla base della catena di riduzioni che dimostra NP-completezza.
- **Riduzione Turing (Cook)** → più generale, usa $B$ come "oracolo" chiamabile più volte.
- **Catena SAT → 3-SAT → Clique → Vertex Cover** → l'esempio canonico che si studia per capire come si costruiscono le riduzioni in pratica.
- **Teorema di Cook-Levin** → il punto di partenza: SAT è NP-completo "per definizione diretta", tutto il resto si dimostra per riduzione da SAT (o da un problema già noto NP-completo).




## 1. Perché servono le riduzioni

Dimostrare che un problema è "difficile" partendo da zero (analizzando tutti i possibili algoritmi) è impraticabile. Le riduzioni permettono di **riciclare** la difficoltà: se so che $A$ è difficile e mostro che $A$ si trasforma in $B$ in modo "economico", allora anche $B$ deve essere (almeno) altrettanto difficile.

Le riduzioni si usano in due direzioni:

1. **Per dimostrare che un problema è "facile"**: se $A \le_p B$ e $B \in \mathrm{P}$, allora anche $A \in \mathrm{P}$ (uso $B$ come subroutine).
2. **Per dimostrare che un problema è "difficile"**: se $A \le_p B$ e $A$ è NP-completo, allora $B$ è NP-difficile (e se $B \in \mathrm{NP}$, anche NP-completo).

La direzione della freccia è cruciale e spesso fonte di errori: $A \le_p B$ si legge "**$A$ si riduce a $B$**", cioè *$B$ è (almeno) difficile quanto $A$*, non il contrario.




## 2. Riduzione many-one (riduzione di Karp)

$$
A \le_p B \iff \exists\, f: \Sigma^* \to \Sigma^* \ \text{calcolabile in tempo polinomiale, tale che} \ \forall x,\ x \in A \iff f(x) \in B
$$

$f$ si chiama **funzione di riduzione**: trasforma ogni istanza $x$ di $A$ in un'istanza $f(x)$ di $B$, preservando la risposta (sì/no). È il tipo di riduzione standard usato per dimostrare NP-completezza.

**Proprietà chiave — transitività:**

$$
A \le_p B \ \wedge \ B \le_p C \implies A \le_p C
$$

(la composizione di due funzioni polinomiali è polinomiale). Questo è ciò che permette di costruire **catene** di riduzioni: una volta dimostrato che SAT è NP-completo, basta ridurre SAT a un nuovo problema $X$ per concludere che anche $X$ è NP-difficile.

```r
riduzione_esempio <- function(istanza_A) {
    # Schema generale di una riduzione many-one:
    # trasforma un'istanza di A in un'istanza di B in tempo polinomiale,
    # preservando la risposta sì/no.
    istanza_B <- trasforma(istanza_A)   # deve girare in tempo poly(length(istanza_A))
    istanza_B
}

# Se avessimo un risolutore per B, risolveremmo A così:
risolvi_A_tramite_B <- function(istanza_A, risolvi_B) {
    istanza_B <- riduzione_esempio(istanza_A)
    risolvi_B(istanza_B)   # stessa risposta di "istanza_A in A?"
}
```




## 3. Riduzione di Turing (Cook)

Più generale della riduzione many-one: $A$ si riduce a $B$ (in senso Turing) se esiste un algoritmo polinomiale per $A$ che ha accesso a un **oracolo** per $B$ (una subroutine che risolve istanze di $B$ in tempo costante), e può chiamarlo **più volte**.

$$
A \le_T B \iff \exists \ \text{algoritmo polinomiale per } A \ \text{con accesso a un oracolo per } B
$$

Ogni riduzione many-one è anche una riduzione di Turing (basta chiamare l'oracolo una sola volta e restituirne l'esito), ma non vale il viceversa in generale. Nella pratica delle dimostrazioni di NP-completezza si usa quasi sempre la riduzione **many-one**, perché la classe NP non è nota essere chiusa rispetto a riduzioni di Turing generiche (mentre lo è rispetto a quelle many-one).

| | Many-one (Karp) | Turing (Cook) |
|---|---|---|
| Chiamate all'oracolo | Esattamente 1, come passo finale | Anche multiple, in qualsiasi punto dell'algoritmo |
| Uso tipico | Dimostrare NP-completezza | Dimostrare NP-difficoltà in senso più debole/generale |
| Forza della relazione | Più restrittiva | Più permissiva |




## 4. Come si dimostra che un problema è NP-completo

Schema standard, sempre in due passi:

1. **Appartenenza a NP**: si esibisce un certificato $y$ e un verificatore polinomiale $V(x, y)$ (vedi [classi_complessita.md § 4](classi_complessita.md)).
2. **NP-difficoltà**: si sceglie un problema **già noto** NP-completo (es. SAT) e si costruisce una riduzione polinomiale da esso al problema target.

Non serve mai ridurre *da tutti* i problemi di NP: basta ridurre da **uno solo** già dimostrato NP-completo, grazie alla transitività di $\le_p$.




## 5. Esempio 1 — SAT $\le_p$ 3-SAT

**SAT**: formula booleana in forma normale congiuntiva (CNF), clausole di lunghezza qualsiasi. **3-SAT**: stesso problema, ma ogni clausola ha **esattamente 3** letterali.

La riduzione trasforma ogni clausola $C$ di SAT in un insieme equisoddisfacibile di clausole a 3 letterali, introducendo variabili ausiliarie:

- Clausola con 1 letterale $(\ell_1)$ → si duplica: $(\ell_1 \vee z_1 \vee z_2) \wedge (\ell_1 \vee \overline{z_1} \vee z_2) \wedge (\ell_1 \vee z_1 \vee \overline{z_2}) \wedge (\ell_1 \vee \overline{z_1} \vee \overline{z_2})$.
- Clausola con 2 letterali $(\ell_1 \vee \ell_2)$ → $(\ell_1 \vee \ell_2 \vee z) \wedge (\ell_1 \vee \ell_2 \vee \overline{z})$.
- Clausola con 3 letterali → resta invariata.
- Clausola con $k > 3$ letterali $(\ell_1 \vee \ell_2 \vee \cdots \vee \ell_k)$ → si introducono $k-3$ variabili ausiliarie $z_1, \dots, z_{k-3}$ per "spezzarla" in catena:

$$
(\ell_1 \vee \ell_2 \vee z_1) \wedge (\overline{z_1} \vee \ell_3 \vee z_2) \wedge (\overline{z_2} \vee \ell_4 \vee z_3) \wedge \cdots \wedge (\overline{z_{k-3}} \vee \ell_{k-1} \vee \ell_k)
$$

L'idea: se la clausola originale è vera grazie a $\ell_i$, si possono scegliere i valori delle $z_j$ in modo da "far passare" la verità lungo la catena.

```r
spezza_clausola <- function(letterali) {
    # Trasforma una clausola di k letterali in clausole equivalenti di 3 letterali.
    # Caso k <= 3 gestito a parte; qui il caso k > 3 (la catena di ausiliarie).
    k <- length(letterali)
    if (k <= 3) return(list(letterali))  # eventualmente da riempire per k=1,2 come sopra

    z <- paste0("z", seq_len(k - 3))
    clausole <- list(c(letterali[1], letterali[2], z[1]))
    for (i in seq_len(k - 4)) {
        clausole[[length(clausole) + 1]] <- c(paste0("~", z[i]), letterali[i + 2], z[i + 1])
    }
    clausole[[length(clausole) + 1]] <- c(paste0("~", z[length(z)]), letterali[k - 1], letterali[k])
    clausole
}
```

La dimensione dell'istanza risultante è **lineare** nella dimensione di quella originale, quindi la riduzione è polinomiale. Poiché 3-SAT è ovviamente in NP (certificato = assegnazione), e SAT è NP-completo per Cook-Levin, questa riduzione dimostra che **3-SAT è NP-completo**.




## 6. Esempio 2 — 3-SAT $\le_p$ Clique

**Clique**: dato un grafo $G$ e un intero $k$, esiste un sottoinsieme di $k$ nodi a due a due connessi?

Data una formula 3-CNF con $m$ clausole $C_1, \dots, C_m$ (ciascuna con 3 letterali), si costruisce un grafo $G$ così:

1. Per ogni clausola $C_i = (\ell_{i,1} \vee \ell_{i,2} \vee \ell_{i,3})$, si crea un **gruppo di 3 nodi**, uno per letterale — $3m$ nodi in totale.
2. Si collegano due nodi con un arco **se e solo se**:
   - appartengono a gruppi (clausole) diversi, **e**
   - i letterali corrispondenti non sono l'uno la negazione dell'altro (es. $x$ e $\overline{x}$ non si collegano).
3. Si pone $k = m$ (una scelta per clausola).

**Intuizione**: una cricca di dimensione $m$ corrisponde a una scelta di un letterale vero per ciascuna clausola, tale che le scelte siano **coerenti** (mai $x$ e $\overline{x}$ entrambi scelti) — esattamente un'assegnazione soddisfacente.

```r
sat3_a_clique <- function(clausole) {
    # clausole: lista di vettori di 3 letterali (stringhe, es. "x1", "~x1").
    # Ritorna list(grafo, k) tale che la formula è soddisfacibile
    # sse il grafo ha una cricca di dimensione k.
    negazione <- function(lit) {
        if (startsWith(lit, "~")) substring(lit, 2) else paste0("~", lit)
    }

    nodi <- list()
    for (i in seq_along(clausole)) {
        for (j in seq_along(clausole[[i]])) {
            nodi[[length(nodi) + 1]] <- c(i, j)
        }
    }

    archi <- list()
    for (a in nodi) {
        for (b in nodi) {
            if (a[1] == b[1]) next   # stesso gruppo/clausola: mai collegati
            l1 <- clausole[[a[1]]][a[2]]
            l2 <- clausole[[b[1]]][b[2]]
            if (l2 != negazione(l1)) {
                chiave <- paste(sort(c(paste(a, collapse = "_"), paste(b, collapse = "_"))), collapse = "-")
                archi[[chiave]] <- TRUE
            }
        }
    }

    list(grafo = list(nodi = nodi, archi = names(archi)), k = length(clausole))
}
```

Anche qui la costruzione è polinomiale ($O(m^2)$ archi al più), quindi **Clique è NP-completo** (appartenenza a NP già mostrata in [classi_complessita.md § 4](classi_complessita.md)).




## 7. Esempio 3 — Clique $\le_p$ Vertex Cover

**Vertex Cover**: dato un grafo $G=(V,E)$ e un intero $k$, esiste un insieme di al più $k$ nodi che "copre" ogni arco (ogni arco ha almeno un estremo nell'insieme)?

Riduzione elegante basata sul **grafo complementare** $\overline{G}$ (stessi nodi, archi invertiti: $(u,v) \in \overline{G} \iff (u,v) \notin G$):

$$
G \text{ ha una cricca di dimensione } k \iff \overline{G} \text{ ha un vertex cover di dimensione } |V| - k
$$

**Perché funziona**: $S$ è una cricca in $G$ (ogni coppia di nodi di $S$ è collegata in $G$) se e solo se **nessun arco di $\overline{G}$ ha entrambi gli estremi in $S$** — per costruzione del complemento, due nodi collegati in $G$ non lo sono in $\overline{G}$. Questo equivale a dire che **ogni arco di $\overline{G}$ ha almeno un estremo in $V \setminus S$**, cioè che $V \setminus S$ è un vertex cover di $\overline{G}$ di dimensione $|V| - k$.

```r
clique_a_vertex_cover <- function(grafo, k) {
    nodi <- grafo$nodi
    id <- function(n) paste(n, collapse = "_")

    tutte_le_coppie <- character(0)
    for (i in seq_along(nodi)) {
        if (i == length(nodi)) break
        for (j in (i + 1):length(nodi)) {
            chiave <- paste(sort(c(id(nodi[[i]]), id(nodi[[j]]))), collapse = "-")
            tutte_le_coppie <- c(tutte_le_coppie, chiave)
        }
    }

    archi_complemento <- setdiff(tutte_le_coppie, grafo$archi)
    k_cover <- length(nodi) - k
    list(grafo = list(nodi = nodi, archi = archi_complemento), k = k_cover)
}
```

Questo chiude una catena tipica di dimostrazioni: $\text{SAT} \le_p \text{3-SAT} \le_p \text{Clique} \le_p \text{Vertex Cover}$, e per transitività (§2) tutti e quattro sono NP-completi.




## 8. Cook-Levin: il punto di partenza della catena

Il **teorema di Cook-Levin** (Cook 1971, Levin indipendentemente) dimostra che **SAT è NP-completo** senza riduzione da un altro problema, ma **direttamente dalla definizione di NP**:

> Per ogni linguaggio $L \in \mathrm{NP}$, esiste una riduzione polinomiale da $L$ a SAT. L'idea è **simulare** l'esecuzione della macchina di Turing non deterministica che decide $L$ come una formula booleana: ogni possibile configurazione della macchina (stato, posizione della testina, contenuto del nastro) a ogni passo di tempo diventa un insieme di variabili booleane, e le regole di transizione diventano clausole che vincolano le variabili di un passo in funzione di quelle del passo precedente.

Questo è ciò che rende SAT il "capostipite" da cui si dimostrano NP-completi tutti gli altri problemi, come nella catena degli esempi sopra.




## 9. Riduzioni "facili": l'altra direzione

Le riduzioni non servono solo a dimostrare difficoltà: sono anche lo strumento standard per **riusare algoritmi già noti**. Esempio classico: *2-SAT* (clausole con esattamente 2 letterali) è in **P**, non NP-completo come 3-SAT — si riduce in tempo polinomiale al problema di trovare le componenti fortemente connesse in un grafo di implicazioni, risolvibile in $O(n+m)$.

```r
letterale_implica <- function(lit) {
    # In 2-SAT, (a ∨ b) equivale a (¬a ⟹ b) ∧ (¬b ⟹ a):
    # si costruisce un grafo di implicazioni e si verifica che nessuna
    # variabile e la sua negazione stiano nella stessa componente fortemente connessa.
    NULL  # riduzione a "raggiungibilità in un grafo", problema in P
}
```

Questo è un buon promemoria: **la difficoltà di un problema non dipende dalla sua forma superficiale** (3-SAT vs 2-SAT sembrano quasi identici) ma dalla struttura che la riduzione riesce a sfruttare.




## 10. Formulario compatto

$$
A \le_p B \iff \exists\, f \in \mathrm{FP}\ (\text{funzioni calcolabili in tempo polinomiale}),\ \forall x,\ x \in A \iff f(x) \in B
$$

$$
A \le_p B \ \wedge \ B \in \mathrm{P} \implies A \in \mathrm{P} \qquad\qquad A \le_p B \ \wedge \ A \text{ NP-completo} \implies B \text{ NP-difficile}
$$

$$
A \le_p B \ \wedge \ B \le_p C \implies A \le_p C \quad \text{(transitività)}
$$

$$
\text{SAT} \le_p \text{3-SAT} \le_p \text{Clique} \le_p \text{Vertex Cover} \le_p \text{Hamiltonian Cycle} \le_p \text{TSP}
$$

> I primi tre passaggi sono costruiti passo-passo nei §5–§7; gli ultimi due (non trattati qui) seguono lo stesso schema generale.

> Per le definizioni di P, NP, NP-completezza e le classi correlate, vedi **[classi_complessita.md](classi_complessita.md)**.
