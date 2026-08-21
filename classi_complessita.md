# Classi di complessità computazionale

La **teoria della complessità computazionale** classifica i problemi in base alle risorse (tempo, spazio) necessarie a un modello di calcolo per risolverli, in funzione della dimensione $n$ dell'input. Serve a rispondere a una domanda semplice: *quanto è "difficile" un problema, indipendentemente dall'algoritmo specifico o dal computer usato?*




## Mappa: cosa serve per cosa

- **Notazione asintotica** ($O$, $\Omega$, $\Theta$) → per parlare di crescita del tempo/spazio ignorando le costanti.
- **Macchina di Turing (deterministica e non deterministica)** → il modello formale su cui si definiscono le classi.
- **P, NP, co-NP** → le classi centrali per i problemi "trattabili" e "verificabili in fretta".
- **NP-completezza** → i problemi più difficili di NP; per dimostrarla servono le **riduzioni**, trattate in dettaglio in [riduzioni.md](riduzioni.md).
- **PSPACE, EXPTIME** → classi più ampie, per problemi che richiedono più spazio o tempo esponenziale.




## 1. Notazione asintotica

Prima di parlare di classi serve un linguaggio per confrontare la crescita delle funzioni di costo.

$$
f(n) = O(g(n)) \iff \exists\, c > 0,\ n_0 \in \mathbb{N} \ \text{tali che}\ \forall n \ge n_0,\ f(n) \le c \cdot g(n)
$$

$$
f(n) = \Omega(g(n)) \iff \exists\, c > 0,\ n_0 \in \mathbb{N} \ \text{tali che}\ \forall n \ge n_0,\ f(n) \ge c \cdot g(n)
$$

$$
f(n) = \Theta(g(n)) \iff f(n) = O(g(n)) \ \text{e} \ f(n) = \Omega(g(n))
$$

In parole: $O$ è un **limite superiore** (non cresce più veloce di), $\Omega$ un **limite inferiore**, $\Theta$ una **crescita esatta** (a meno di costanti).

**Gerarchia tipica delle classi di crescita** (dalla più lenta alla più veloce):

$$
O(1) \subset O(\log n) \subset O(n) \subset O(n \log n) \subset O(n^2) \subset O(n^k) \subset O(2^n) \subset O(n!)
$$

```python
# Confronto empirico di crescita: quanti "passi" servono per n = 10, 100, 1000
import math

def confronta(n):
    return {
        "log n":   math.log2(n),
        "n":       n,
        "n log n": n * math.log2(n),
        "n^2":     n**2,
        "2^n":     2**n if n <= 30 else float("inf"),  # esplode subito
    }

for n in (10, 100, 1000):
    print(n, confronta(n))
```

L'ultima riga (`2^n`) mostra perché un algoritmo esponenziale diventa inutilizzabile molto prima di uno polinomiale, anche se per $n$ piccoli può sembrare competitivo.




## 2. Il modello di calcolo: macchina di Turing

Le classi di complessità si definiscono formalmente rispetto alla **macchina di Turing (MdT)**, un modello astratto con un nastro infinito, una testina di lettura/scrittura e un insieme finito di stati.

- **MdT deterministica (DTM)**: in ogni configurazione esiste al più una transizione possibile. Modella il calcolo "normale".
- **MdT non deterministica (NTM)**: in ogni configurazione può esistere più di una transizione; la macchina "sceglie" (o esplora tutti i rami in parallelo, concettualmente). Accetta se **almeno un ramo** accetta.

Le classi si definiscono in termini di **tempo** (numero di passi) o **spazio** (celle di nastro usate) in funzione di $n = |x|$, la lunghezza dell'input $x$:

$$
\mathrm{TIME}(f(n)) = \{\, L \mid L \text{ è deciso da una DTM in tempo } O(f(n)) \,\}
$$

$$
\mathrm{NTIME}(f(n)) = \{\, L \mid L \text{ è deciso da una NTM in tempo } O(f(n)) \,\}
$$




## 3. Classe P

$$
\mathrm{P} = \bigcup_{k \ge 1} \mathrm{TIME}(n^k)
$$

**P** (Polynomial time) è l'insieme dei problemi decisionali risolvibili da una macchina di Turing **deterministica** in tempo **polinomiale** rispetto alla dimensione dell'input. È considerata (con qualche eccezione pratica) la classe dei problemi "trattabili".

**Esempi di problemi in P:**

- Ordinamento di una lista (`O(n log n)`).
- Ricerca del cammino minimo in un grafo (Dijkstra, `O(n² )` o `O((n+m) log n)`).
- Test di primalità (algoritmo AKS, polinomiale — anche se in pratica si usano test probabilistici più veloci).
- Programmazione lineare (algoritmo dell'ellissoide / punti interni).

```python
def dijkstra_esiste_cammino(grafo, sorgente, destinazione):
    """Verifica raggiungibilità con costo minimo: O((V+E) log V), quindi in P."""
    import heapq
    dist = {sorgente: 0}
    coda = [(0, sorgente)]
    while coda:
        d, u = heapq.heappop(coda)
        if u == destinazione:
            return True
        for v, peso in grafo.get(u, []):
            nd = d + peso
            if nd < dist.get(v, float("inf")):
                dist[v] = nd
                heapq.heappush(coda, (nd, v))
    return destinazione in dist
```




## 4. Classe NP

$$
\mathrm{NP} = \bigcup_{k \ge 1} \mathrm{NTIME}(n^k)
$$

**NP** (Nondeterministic Polynomial time) è l'insieme dei problemi decisionali risolvibili da una macchina di Turing **non deterministica** in tempo polinomiale.

C'è una caratterizzazione **equivalente e più intuitiva**, basata sulla verifica invece che sulla ricerca:

> $L \in \mathrm{NP}$ se e solo se esiste un **certificato** (o "prova") $y$, di lunghezza polinomiale in $n$, e un **verificatore deterministico polinomiale** $V$ tale che:
> $$x \in L \iff \exists\, y,\ |y| = O(n^k),\ V(x, y) = 1$$

In parole: NP raccoglie i problemi per cui, **se qualcuno ti suggerisce la soluzione**, puoi verificarla velocemente — anche se trovarla da zero può essere molto costoso.

**Esempi di problemi in NP:**

- **SAT**: data una formula booleana, esiste un'assegnazione di verità che la rende vera? (Certificato: l'assegnazione stessa.)
- **Clique**: esiste in un grafo una cricca (sottografo completo) di almeno $k$ nodi? (Certificato: l'insieme di $k$ nodi.)
- **Commesso viaggiatore (decisionale)**: esiste un percorso che tocca tutte le città con costo $\le k$? (Certificato: il percorso.)

```python
def verifica_clique(grafo, sottoinsieme):
    """Verificatore in O(k^2): dato un candidato, controlla che sia una cricca.
    Trovare il sottoinsieme da zero è invece il problema NP-difficile."""
    nodi = list(sottoinsieme)
    for i in range(len(nodi)):
        for j in range(i + 1, len(nodi)):
            if nodi[j] not in grafo.get(nodi[i], set()):
                return False
    return True
```

Nota bene: $\mathrm{P} \subseteq \mathrm{NP}$ sempre (ogni problema risolvibile in fretta è anche verificabile in fretta, ignorando il certificato). La domanda **$\mathrm{P} \stackrel{?}{=} \mathrm{NP}$** è il problema aperto più famoso dell'informatica teorica (uno dei [Millennium Prize Problems](https://www.claymath.org/millennium-problems)).




## 5. NP-completezza e NP-difficoltà

- Un problema $L$ è **NP-difficile (NP-hard)** se ogni problema in NP si può **ridurre** a $L$ in tempo polinomiale.
- Un problema $L$ è **NP-completo (NP-complete)** se $L \in \mathrm{NP}$ **e** $L$ è NP-difficile.

I problemi NP-completi sono, informalmente, i "più difficili" di NP: se se ne trovasse uno solo risolvibile in tempo polinomiale, allora $\mathrm{P} = \mathrm{NP}$ e ogni problema in NP diventerebbe trattabile.

Il **teorema di Cook-Levin** (1971) dimostra che **SAT è NP-completo** — è stato il primo problema per cui si è dimostrata questa proprietà, ed è la base da cui si dimostrano NP-completi tutti gli altri (tramite riduzioni a catena).

> La costruzione delle riduzioni, con esempi passo-passo (SAT → 3-SAT → Clique → Vertex Cover → ...), è approfondita in **[riduzioni.md](riduzioni.md)**.

**Esempi di problemi NP-completi:** SAT, 3-SAT, Clique, Vertex Cover, Hamiltonian Cycle, commesso viaggiatore (decisionale), Subset Sum, coloring di grafi ($k \ge 3$).




## 6. co-NP

$$
\mathrm{co\text{-}NP} = \{\, L \mid \overline{L} \in \mathrm{NP} \,\}
$$

**co-NP** è la classe dei complementi dei linguaggi in NP: un problema è in co-NP se le istanze **negative** ammettono un certificato verificabile in tempo polinomiale.

**Esempio:** *TAUTOLOGIA* (una formula booleana è vera per ogni assegnazione?) è in co-NP, perché il complemento — "esiste un'assegnazione che la rende falsa" — è SAT-like ed è in NP.

Non si sa se $\mathrm{NP} = \mathrm{co\text{-}NP}$ (è un'altra domanda aperta, collegata a $\mathrm{P} \stackrel{?}{=} \mathrm{NP}$: se $\mathrm{P} = \mathrm{NP}$ allora necessariamente $\mathrm{NP} = \mathrm{co\text{-}NP}$, perché P è chiusa per complemento).




## 7. PSPACE ed EXPTIME

$$
\mathrm{PSPACE} = \bigcup_{k \ge 1} \mathrm{SPACE}(n^k) \qquad \mathrm{EXPTIME} = \bigcup_{k \ge 1} \mathrm{TIME}(2^{n^k})
$$

- **PSPACE**: problemi risolvibili con **spazio polinomiale**, tempo qualsiasi (anche esponenziale). Esempio: generalizzazioni di giochi come *Quantified Boolean Formula (QBF)*, o scacchi/dama generalizzati su scacchiera $n \times n$.
- **EXPTIME**: problemi risolvibili in **tempo esponenziale**. Contiene PSPACE (per il teorema di Savitch, $\mathrm{NPSPACE} = \mathrm{PSPACE}$, e uno spazio $f(n)$ implica un tempo al più $2^{O(f(n))}$).

**Relazioni note (catena di inclusioni):**

$$
\mathrm{P} \subseteq \mathrm{NP} \subseteq \mathrm{PSPACE} \subseteq \mathrm{EXPTIME}
$$

Si sa per certo (teorema della gerarchia del tempo) che $\mathrm{P} \subsetneq \mathrm{EXPTIME}$ — quindi **almeno una** delle inclusioni sopra è stretta — ma non si sa quale. Questo è il motivo per cui $\mathrm{P} \stackrel{?}{=} \mathrm{NP}$ resta aperto.




## 8. Quadro riassuntivo dei problemi per classe

| Classe | Significato intuitivo | Esempi |
|---|---|---|
| **P** | Risolvibile in fretta | Ordinamento, cammino minimo, primalità |
| **NP** | Verificabile in fretta | SAT, Clique, TSP (decisionale) |
| **co-NP** | Complemento verificabile in fretta | Tautologia, non-primalità (storicamente) |
| **NP-completo** | Il più difficile di NP | SAT, 3-SAT, Vertex Cover, Hamiltonian Cycle |
| **NP-difficile** | Almeno difficile quanto NP (non necessariamente in NP) | TSP (ottimizzazione), Halting Problem |
| **PSPACE** | Spazio polinomiale | QBF, giochi generalizzati |
| **EXPTIME** | Tempo esponenziale | Generalizzazioni di giochi con stati esponenziali |




## 9. Formulario compatto

$$
\mathrm{P} = \bigcup_k \mathrm{TIME}(n^k) \qquad \mathrm{NP} = \bigcup_k \mathrm{NTIME}(n^k) \qquad \mathrm{co\text{-}NP} = \{L : \overline{L} \in \mathrm{NP}\}
$$

$$
L \in \mathrm{NP} \iff \exists\, y,\ |y| = O(n^k),\ V(x,y) = 1 \ \text{in tempo polinomiale}
$$

$$
\mathrm{P} \subseteq \mathrm{NP} \cap \mathrm{co\text{-}NP} \subseteq \mathrm{NP} \subseteq \mathrm{PSPACE} \subseteq \mathrm{EXPTIME}
$$

$$
L \text{ NP-completo} \iff L \in \mathrm{NP} \ \wedge \ \forall L' \in \mathrm{NP},\ L' \le_p L
$$

> Il simbolo $\le_p$ (riduzione polinomiale) è definito e usato estesamente in **[riduzioni.md](riduzioni.md)**.
