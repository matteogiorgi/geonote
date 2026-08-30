# Costo di un algoritmo

Quando si dice che un algoritmo "costa" $O(n^2)$ ci si sta in realtà riferendo a **una specifica convenzione** su come misurare il costo, perché lo stesso algoritmo può comportarsi in modo molto diverso a seconda dell'input. La **teoria della complessità computazionale** (vedi [teoria_complessita.md](teoria_complessita.md) per la notazione asintotica $O$, $\Omega$, $\Theta$ usata qui) dice *quanto* cresce un costo; questo documento tratta *rispetto a cosa* lo si misura: il caso peggiore, il caso migliore, il caso medio, oppure il costo medio su una sequenza di operazioni (ammortizzato).




## Mappa: cosa serve per cosa

- **Caso pessimo** → la garanzia più forte e la più usata: un limite che vale *sempre*, qualunque sia l'input.
- **Caso ottimo** → utile soprattutto come termine di paragone o per algoritmi "adattivi" che sfruttano input già favorevoli (es. array già ordinati o quasi ordinati).
- **Caso medio** → richiede di fissare una *distribuzione di probabilità* sugli input; risponde alla domanda "cosa mi aspetto, in pratica?" (ma non garantisce nulla per input rari o patologici).
- **Costo ammortizzato** → non riguarda una singola chiamata né una distribuzione casuale, ma il costo medio *su una sequenza di operazioni*, garantito nel caso peggiore su quella sequenza. Si dimostra con tre tecniche equivalenti: metodo *aggregato*, metodo *a scala (accounting)*, metodo del *potenziale*.




## 1. Perché un solo numero non basta

Fissiamo la notazione: un algoritmo riceve un'istanza $I$ (un input concreto) di dimensione $n = \|I\|$, e $T(I)$ è il numero di passi elementari eseguiti su quella specifica istanza. Il problema è che, per una dimensione $n$ fissata, esistono **molte** istanze diverse, e $T(I)$ può variare parecchio tra loro.

Sia $I_n = \{\, I \mid \|I\| = n \,\}$ l'insieme di tutte le istanze di dimensione $n$. Le quattro nozioni di costo sono quattro modi diversi di trasformare l'insieme di valori $\{T(I) : I \in I_n\}$ in un unico numero $T(n)$:

$$
T_{\text{pess}}(n) = \max_{I \in I_n} T(I) \qquad T_{\text{ott}}(n) = \min_{I \in I_n} T(I) \qquad T_{\text{medio}}(n) = \mathbb{E}_{I \sim D}\big[T(I)\big]
$$

dove $D$ è una distribuzione di probabilità su $I_n$. Il costo **ammortizzato** è concettualmente diverso dagli altri tre: non media su istanze diverse della stessa dimensione, ma sul tempo, lungo una sequenza di operazioni eseguite su una struttura dati che cambia stato.

Un piccolo esempio guida per tutto il documento: la **ricerca lineare** di un elemento `x` in un array `a` di `n` elementi.

```go
func ricercaLineare(a []int, x int) int {
	for i, v := range a {
		if v == x {
			return i // trovato in posizione i
		}
	}
	return -1 // non trovato
}
```

Il costo (numero di confronti) dipende da **dove** si trova `x` — non solo da `n` — ed è esattamente il tipo di variabilità che le prossime sezioni formalizzano.




## 2. Caso pessimo (worst-case)

$$
T_{\text{pess}}(n) = \max_{I \in I_n} T(I)
$$

È l'istanza **più sfavorevole possibile** tra quelle di dimensione $n$. È la nozione di costo più usata perché fornisce una **garanzia incondizionata**: qualunque sia l'input (anche scelto da un avversario), l'algoritmo non farà mai più di $T_{\text{pess}}(n)$ passi. Quando si scrive "quicksort è $O(n^2)$" o "la ricerca binaria è $O(\log n)$" senza altre precisazioni, ci si riferisce quasi sempre al caso pessimo.

**Esempio (facile) — ricerca lineare:** il caso peggiore è quando `x` non è presente nell'array (o si trova nell'ultima posizione): si eseguono tutti gli $n$ confronti.

$$
T_{\text{pess}}^{\text{ricerca}}(n) = n = \Theta(n)
$$

**Esempio (medio) — ordinamento per inserimento (insertion sort):** ad ogni passo $i$ (da $1$ a $n-1$) l'elemento in posizione $i$ viene confrontato e spostato all'indietro finché non trova il suo posto.

```go
func insertionSort(a []int) {
	for i := 1; i < len(a); i++ {
		chiave := a[i]
		j := i - 1
		for j >= 0 && a[j] > chiave {
			a[j+1] = a[j]
			j--
		}
		a[j+1] = chiave
	}
}
```

Nel caso peggiore l'array è **ordinato in senso inverso**: ogni elemento in posizione $i$ deve scavalcare tutti gli $i$ elementi che lo precedono.

$$
T_{\text{pess}}^{\text{ins}}(n) = \sum_{i=1}^{n-1} i = \frac{n(n-1)}{2} = \Theta(n^2)
$$




## 3. Caso ottimo (best-case)

$$
T_{\text{ott}}(n) = \min_{I \in I_n} T(I)
$$

È l'istanza **più favorevole** tra quelle di dimensione $n$. Da solo dice poco (un algoritmo può avere un ottimo eccellente e un pessimo pessimo), ma è utile in due situazioni: come **limite inferiore** per capire quanto lavoro è comunque inevitabile, e per descrivere algoritmi **adattivi**, cioè che riconoscono input già "comodi" e terminano prima.

**Esempio (facile) — ricerca lineare:** il caso migliore è `x` in prima posizione: un solo confronto.

$$
T_{\text{ott}}^{\text{ricerca}}(n) = 1 = \Theta(1)
$$

**Esempio (medio) — insertion sort:** se l'array è **già ordinato**, il ciclo interno (`for j >= 0 && a[j] > chiave`) non entra mai nel corpo: ogni elemento in posizione $i$ costa un solo confronto per constatare che è già al suo posto.

$$
T_{\text{ott}}^{\text{ins}}(n) = n - 1 = \Theta(n)
$$

Il contrasto $\Theta(n)$ contro $\Theta(n^2)$ mostra perché insertion sort è, in pratica, un'ottima scelta per array quasi ordinati (es. per completare un ordinamento quasi finito) nonostante il pessimo quadratico.




## 4. Caso medio (average-case)

$$
T_{\text{medio}}(n) = \sum_{I \in I_n} \Pr[I] \cdot T(I) = \mathbb{E}_{I \sim D}\big[T(I)\big]
$$

A differenza dei primi due, il caso medio **non è definito univocamente dal problema**: bisogna prima scegliere (o assumere) una distribuzione $D$ sugli input di dimensione $n$. La scelta più comune, quando non c'è altra informazione, è la distribuzione **uniforme**: $\Pr[I] = 1/\|I_n\|$ per ogni $I$. È il costo più informativo per capire il comportamento "tipico" di un algoritmo, ma è anche il più delicato da calcolare — e i risultati valgono solo per la distribuzione assunta (un input patologico, anche raro, resta possibile: il caso medio non sostituisce il caso pessimo).

**Esempio (facile) — ricerca lineare:** assumiamo che `x` sia presente nell'array e che la sua posizione sia **uniforme** tra le $n$ posizioni possibili (probabilità $1/n$ ciascuna). Se `x` è in posizione $k$ (da $1$ a $n$), il costo è $k$ confronti.

$$
T_{\text{medio}}^{\text{ricerca}}(n) = \sum_{k=1}^{n} \frac{1}{n} \cdot k = \frac{1}{n} \cdot \frac{n(n+1)}{2} = \frac{n+1}{2} = \Theta(n)
$$

Nota: stesso ordine di grandezza del caso pessimo ($\Theta(n)$), ma con una costante dimezzata — informazione che il solo $O(n)$ del caso pessimo non dà.

**Esempio (difficile) — quicksort con pivot casuale:** questo è il caso in cui il caso medio cambia **radicalmente** il giudizio su un algoritmo (pessimo $\Theta(n^2)$, medio $\Theta(n \log n)$).

```go
func quicksort(a []int) {
	if len(a) <= 1 {
		return
	}
	p := rand.Intn(len(a)) // scelta del pivot uniforme e casuale
	a[0], a[p] = a[p], a[0]
	pivot := a[0]

	minori := make([]int, 0, len(a))
	maggiori := make([]int, 0, len(a))
	for _, v := range a[1:] {
		if v < pivot {
			minori = append(minori, v)
		} else {
			maggiori = append(maggiori, v)
		}
	}
	quicksort(minori)
	quicksort(maggiori)
	copy(a, append(append(minori, pivot), maggiori...))
}
```

Con un pivot casuale, la posizione $k$ in cui il pivot finisce (cioè quanti elementi sono più piccoli di lui) è **uniforme** su $\{0, 1, \dots, n-1\}$, indipendentemente dall'array di partenza. Il costo del partizionamento è $n-1$ confronti, più il costo ricorsivo sulle due parti:

$$
T(n) = (n-1) + \frac{1}{n}\sum_{k=0}^{n-1} \Big( T(k) + T(n-1-k) \Big)
$$

Un modo più diretto per risolverla (metodo delle **variabili indicatrici**) conta direttamente il numero atteso di confronti totali. Ordiniamo concettualmente gli elementi come $z_1 < z_2 < \dots < z_n$ e definiamo $X_{ij} = 1$ se $z_i$ e $z_j$ vengono **confrontati** durante l'esecuzione, $0$ altrimenti. Si dimostra che $z_i$ e $z_j$ sono confrontati **se e solo se** uno dei due è scelto come pivot per primo tra tutti gli elementi $z_i, \dots, z_j$ — evento di probabilità $\frac{2}{j - i + 1}$ (2 elementi "buoni" su $j-i+1$ candidati equiprobabili). Quindi:

$$
\mathbb{E}[\#\text{confronti}] = \sum_{i=1}^{n-1} \sum_{j=i+1}^{n} \mathbb{E}[X_{ij}] = \sum_{i=1}^{n-1} \sum_{j=i+1}^{n} \frac{2}{j-i+1} \le \sum_{i=1}^{n-1} \sum_{d=1}^{n} \frac{2}{d} = O(n \ln n)
$$

usando $\sum_{d=1}^n \frac{1}{d} = H_n = O(\log n)$ (la serie armonica). Quindi $T_{\text{medio}}^{\text{qsort}}(n) = O(n \log n)$, contro $T_{\text{pess}}^{\text{qsort}}(n) = \Theta(n^2)$ (che si verifica, ad esempio, quando l'array è già ordinato e il pivot cade sempre nella posizione estrema).




## 5. Costo ammortizzato: l'idea generale

Il costo ammortizzato risponde a una domanda diversa dalle precedenti: non "quanto costa *questa* chiamata nel caso peggiore/medio?", ma "**qual è il costo medio per operazione, nel caso peggiore, su una sequenza lunga di operazioni?**". È utile quando un'operazione è quasi sempre economica ma **occasionalmente** molto costosa, e si vuole dimostrare che i picchi occasionali non fanno esplodere il costo complessivo.

Per una sequenza di $m$ operazioni $op_1, \dots, op_m$, con costi reali $c_1, \dots, c_m$, si cercano dei **costi ammortizzati** $\hat{c}_1, \dots, \hat{c}_m$ che siano:

1. **facili da calcolare** (spesso costanti), e
2. una **maggiorazione valida in totale**, per ogni sequenza e ogni prefisso:

$$
\sum_{i=1}^{m} c_i \ \le\ \sum_{i=1}^{m} \hat{c}_i
$$

Attenzione: a differenza del caso medio, qui **non c'è nessuna distribuzione di probabilità** — la garanzia vale per *ogni* sequenza di operazioni, anche costruita da un avversario. Le tre tecniche seguenti (aggregato, a scala, del potenziale) sono modi equivalenti per trovare e dimostrare validi questi $\hat{c}_i$.


### 5.1 Metodo aggregato — esempio: vettore dinamico

Il metodo più diretto: si calcola il costo **totale** $T(m)$ nel caso peggiore per una sequenza di $m$ operazioni, e si definisce il costo ammortizzato come la media:

$$
\hat{c} = \frac{T(m)}{m}
$$

**Esempio (medio) — vettore dinamico che raddoppia la capacità.** È la struttura dietro `ArrayList` di *Java*, `std::vector` di *C++* o `append` di *Go*: quando l'array interno è pieno, se ne alloca uno **doppio** e si copiano gli elementi esistenti.

```go
type VettoreDinamico struct {
	dati []int
	n    int // elementi effettivamente usati
}

func (v *VettoreDinamico) Push(x int) int {
	costo := 1 // scrivere x costa sempre 1
	if v.n == len(v.dati) {
		nuovaCap := 1
		if len(v.dati) > 0 {
			nuovaCap = 2 * len(v.dati)
		}
		nuovi := make([]int, nuovaCap)
		copy(nuovi, v.dati[:v.n]) // costo aggiuntivo: v.n copie
		costo += v.n
		v.dati = nuovi
	}
	v.dati[v.n] = x
	v.n++
	return costo
}
```

Il ridimensionamento avviene alle chiamate $1, 2, 4, 8, \dots, 2^k, \dots$ (le potenze di due $\le m$), e il costo del ridimensionamento alla chiamata $2^k$ è $2^k$ copie. Il costo totale di $m$ Push è quindi al più:

$$
T(m) = \underbrace{m}_{\text{scritture}} + \underbrace{\sum_{k=0}^{\lfloor \log_2 m \rfloor} 2^k}_{\text{copie nei ridimensionamenti}} = m + (2^{\lceil \log_2 m \rceil + 1} - 1) \le m + 2(2m - 1) < 3m
$$

(la somma delle potenze di due è una serie geometrica, dominata dall'ultimo termine $\approx 2m$). Quindi:

$$
\hat{c} = \frac{T(m)}{m} < \frac{3m}{m} = 3 = \Theta(1)
$$

Ogni singola `Push` può costare $\Theta(n)$ (quando ridimensiona), ma **in media su una sequenza qualsiasi** costa $O(1)$: è questo che si intende dicendo "l'inserimento in un vettore dinamico è $O(1)$ ammortizzato".


### 5.2 Metodo a scala (accounting) — lo stesso esempio, vista diversa

Invece di sommare tutto e dividere, il metodo a scala assegna **manualmente** un costo ammortizzato $\hat{c}_i$ a ogni operazione, tale che l'operazione "sovrapaghi" quando è economica, accumulando un **credito** che finanzierà le operazioni future più costose. Deve valere, per ogni $k$:

$$
\text{credito}_k = \sum_{i=1}^{k} \hat{c}_i - \sum_{i=1}^{k} c_i \ \ge\ 0
$$

cioè il credito accumulato non deve mai diventare negativo (non si può "spendere in anticipo" più di quanto versato).

**Applicazione al vettore dinamico:** assegniamo $\hat{c}_i = 3$ a ogni `Push` (indipendentemente dal fatto che ridimensioni o meno), così ripartiti concettualmente:

- **1** per inserire l'elemento stesso;
- **1** depositato come credito **sull'elemento appena inserito**, da usare per pagare la sua futura ricopiatura;
- **1** depositato come credito su uno degli elementi **già presenti** che non ha ancora un credito, per pagare la sua ricopiatura.

Quando il vettore, pieno con $n$ elementi, deve raddoppiare: esattamente gli $n$ elementi presenti hanno (per induzione) un credito di 1 ciascuno, sufficiente a pagare la loro copia nel nuovo array. Il credito non scende mai sotto zero, quindi $\hat{c}_i = 3 = \Theta(1)$ è una maggiorazione valida — stesso risultato del metodo aggregato, ottenuto però assegnando un costo esplicito a ogni singola chiamata (utile quando si mescolano operazioni di tipo diverso, es. `Push` e `Pop`, cosa che il metodo aggregato da solo non distingue).


### 5.3 Metodo del potenziale — esempio: contatore binario

Il metodo più generale (ed è quello che si generalizza meglio a strutture dati complesse, es. splay tree, heap binomiali). Si definisce una **funzione potenziale** $\Phi$ che mappa lo stato $D_i$ della struttura dati (dopo l'operazione $i$-esima) in un numero reale, con $\Phi(D_0) = 0$ e $\Phi(D_i) \ge 0$ per ogni $i$. Il costo ammortizzato dell'operazione $i$-esima è definito come:

$$
\hat{c}_i = c_i + \Phi(D_i) - \Phi(D_{i-1})
$$

Sommando su tutta la sequenza, la somma **telescopica**:

$$
\sum_{i=1}^{m} \hat{c}_i = \sum_{i=1}^{m} c_i + \Phi(D_m) - \Phi(D_0) = \sum_{i=1}^{m} c_i + \Phi(D_m) \ \ge\ \sum_{i=1}^{m} c_i
$$

garantisce che $\sum \hat{c}_i$ sia sempre una maggiorazione valida del costo reale, perché $\Phi(D_m) \ge 0 = \Phi(D_0)$. Il punto è scegliere $\Phi$ in modo che cresca prima di un'operazione costosa (assorbendola) e scenda subito dopo.

**Esempio (difficile) — incremento di un contatore binario.** Un contatore a $k$ bit parte da $0\ldots0$; l'operazione `Incrementa` cerca il primo bit a $0$ da destra, lo pone a $1$, e azzera tutti i bit a $1$ che l'hanno preceduto (il "riporto" del binario standard).

```go
type Contatore struct {
	bit []int // bit[0] = meno significativo
}

func (c *Contatore) Incrementa() int {
	costo := 0
	i := 0
	for i < len(c.bit) && c.bit[i] == 1 {
		c.bit[i] = 0 // azzera i riporti
		costo++
		i++
	}
	if i < len(c.bit) {
		c.bit[i] = 1
		costo++
	}
	return costo
}
```

Il caso pessimo di una singola `Incrementa` è $\Theta(k)$ (contatore tipo $011\ldots1 \to 100\ldots0$). Definiamo il potenziale come il **numero di bit a 1**:

$$
\Phi(D_i) = b_i \qquad (b_i = \text{numero di 1 nel contatore dopo l'operazione } i)
$$

Se l'operazione $i$-esima azzera $t$ bit (i riporti) e ne accende $1$, il costo reale è $c_i = t + 1$, e la variazione di potenziale è $\Phi(D_i) - \Phi(D_{i-1}) = 1 - t$ (si perdono $t$ uni, se ne guadagna $1$). Quindi:

$$
\hat{c}_i = c_i + \Phi(D_i) - \Phi(D_{i-1}) = (t+1) + (1 - t) = 2 = \Theta(1)
$$

Il costo ammortizzato per incremento è **costante**, indipendentemente da $k$: per $m$ incrementi a partire dal contatore a zero, $\sum_{i=1}^m c_i \le \sum_{i=1}^m \hat{c}_i = 2m$, cioè $T(m) = O(m)$ — molto meglio del limite (corretto ma troppo pessimista) $O(mk)$ che si otterrebbe moltiplicando ingenuamente $m$ per il caso pessimo della singola operazione.




## 6. Quadro riassuntivo

| Nozione | Media/estremo su | Richiede probabilità? | Garanzia | Esempio tipico |
|---|---|---|---|---|
| **Caso pessimo** | istanze di dimensione $n$ (max) | No | Vale per ogni input | Ricerca lineare $\Theta(n)$ |
| **Caso ottimo** | istanze di dimensione $n$ (min) | No | Vale solo per l'input più favorevole | Insertion sort su array ordinato $\Theta(n)$ |
| **Caso medio** | istanze di dimensione $n$, pesate da $D$ | Sì (bisogna sceglierla) | Vale "in media", non per ogni singolo input | Quicksort con pivot casuale $\Theta(n \log n)$ |
| **Ammortizzato** | operazioni in una sequenza di lunghezza $m$ | No | Vale per ogni sequenza, nel caso peggiore | Push su vettore dinamico $O(1)$ |

Un punto spesso frainteso: il costo ammortizzato **non è** un caso medio "nel tempo" nel senso probabilistico — è una garanzia deterministica sul caso peggiore di una sequenza, tanto quanto lo è il caso pessimo su una singola operazione. Il quicksort randomizzato del [§4](#4-caso-medio-average-case), al contrario, usa davvero la probabilità (nella scelta del pivot), quindi il suo $O(n \log n)$ è un'aspettativa, non una garanzia assoluta (il caso pessimo resta $\Theta(n^2)$).




## 7. Formulario compatto

$$
T_{\text{pess}}(n) = \max_{I \in I_n} T(I) \qquad T_{\text{ott}}(n) = \min_{I \in I_n} T(I) \qquad T_{\text{medio}}(n) = \sum_{I \in I_n} \Pr[I]\, T(I) = \mathbb{E}_{I \sim D}[T(I)]
$$

$$
\text{Ammortizzato (aggregato)}: \quad \hat{c} = \frac{T(m)}{m}, \qquad T(m) = \text{costo reale totale di } m \text{ operazioni}
$$

$$
\text{Ammortizzato (a scala)}: \quad \sum_{i=1}^{k} \hat{c}_i \ge \sum_{i=1}^{k} c_i \quad \forall k \in \{1, \dots, m\}
$$

$$
\text{Ammortizzato (potenziale)}: \quad \hat{c}_i = c_i + \Phi(D_i) - \Phi(D_{i-1}), \qquad \Phi(D_0) = 0,\ \Phi(D_i) \ge 0 \ \implies \ \sum_i \hat{c}_i \ge \sum_i c_i
$$

$$
T_{\text{ott}}(n) \ \le\ T_{\text{medio}}(n) \ \le\ T_{\text{pess}}(n) \qquad \text{per qualunque distribuzione } D
$$
