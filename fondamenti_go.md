# Go language

**Go** (o *Golang*) è un linguaggio di programmazione open source sviluppato da Google nel 2007 e rilasciato pubblicamente nel 2009. È compilato, staticamente tipizzato, con garbage collection e un modello di concorrenza integrato. È progettato per essere semplice, efficiente e adatto allo sviluppo di sistemi su larga scala.




## 1. Caratteristiche principali

- **Compilazione veloce** verso codice macchina nativo.
- **Tipizzazione statica** con inferenza dei tipi.
- **Garbage collection** automatico.
- **Concorrenza** tramite *goroutine* e *canali*.
- **Sintassi minimale**: solo 25 parole chiave riservate.
- **Standard library** ricca e strumenti integrati (`go fmt`, `go test`, `go build`).




## 2. Struttura di base di un programma

Ogni programma eseguibile appartiene al package `main` e definisce una funzione `main`.

```go
package main

import "fmt"

func main() {
    fmt.Println("Ciao, mondo!")
}
```




## 3. Variabili, costanti e tipi

```go
var x int = 10          // dichiarazione esplicita
y := 3.14               // dichiarazione breve con inferenza
const Pi = 3.14159      // costante

var (
    nome   string = "Go"
    attivo bool   = true
)
```

Tipi fondamentali: `int`, `int8/16/32/64`, `uint`, `float32/64`, `complex64/128`, `bool`, `string`, `byte` (alias di `uint8`), `rune` (alias di `int32`).

Il valore massimo di un intero senza segno a $n$ bit è dato da:

$$
\text{max}_{\text{uint}} = 2^{n} - 1
$$

mentre per un intero con segno (in complemento a due):

$$
\text{max}_{\text{int}} = 2^{n-1} - 1, \qquad \text{min}_{\text{int}} = -2^{n-1}
$$




## 4. Strutture di controllo

Go ha un solo costrutto di ciclo: `for`.

```go
// ciclo classico
for i := 0; i < 5; i++ {
    fmt.Println(i)
}

// come while
n := 0
for n < 3 {
    n++
}

// condizionale
if v := calcola(); v > 0 {
    fmt.Println("positivo")
} else {
    fmt.Println("non positivo")
}

// switch (senza break implicito)
switch giorno {
case "sab", "dom":
    fmt.Println("weekend")
default:
    fmt.Println("feriale")
}
```




## 5. Funzioni

Le funzioni possono restituire più valori, caratteristica molto usata per la gestione degli errori.

```go
func dividi(a, b float64) (float64, error) {
    if b == 0 {
        return 0, fmt.Errorf("divisione per zero")
    }
    return a / b, nil
}
```

Una funzione può essere una *closure* che cattura variabili dal proprio ambiente:

```go
func contatore() func() int {
    c := 0
    return func() int {
        c++
        return c
    }
}
```




## 6. Slice, array e mappe

```go
arr := [3]int{1, 2, 3}          // array a lunghezza fissa
s := []int{1, 2, 3}            // slice (dimensione dinamica)
s = append(s, 4)

m := map[string]int{"a": 1}    // mappa
m["b"] = 2
valore, ok := m["a"]          // ok è false se la chiave manca
```

Uno *slice* è composto da tre elementi: un puntatore ai dati, la lunghezza $\ell$ e la capacità $c$, con il vincolo:

$$
0 \le \ell \le c
$$

Quando `append` supera la capacità, Go alloca un nuovo array; l'ammortamento porta la complessità media di `append` a:

$$
T_{\text{append}} = O(1) \ \text{ammortizzato}
$$




## 7. Struct, metodi e interfacce

```go
type Punto struct {
    X, Y float64
}

// metodo con receiver
func (p Punto) Distanza() float64 {
    return math.Sqrt(p.X*p.X + p.Y*p.Y)
}

// interfaccia: soddisfatta implicitamente
type Forma interface {
    Area() float64
}
```

La distanza euclidea calcolata dal metodo corrisponde a:

$$
d = \sqrt{x^{2} + y^{2}}
$$

e più in generale, tra due punti $P_1$ e $P_2$:

$$
d(P_1, P_2) = \sqrt{(x_2 - x_1)^{2} + (y_2 - y_1)^{2}}
$$

Le interfacce in Go sono **implicite**: un tipo le implementa semplicemente definendo i metodi richiesti, senza dichiarazione esplicita.




## 8. Gestione degli errori

Go non usa eccezioni: gli errori sono valori restituiti esplicitamente.

```go
risultato, err := dividi(10, 0)
if err != nil {
    log.Fatal(err)
}
fmt.Println(risultato)
```

Per situazioni irreversibili esistono `panic` e `recover`:

```go
func sicura() {
    defer func() {
        if r := recover(); r != nil {
            fmt.Println("recuperato:", r)
        }
    }()
    panic("qualcosa è andato storto")
}
```




## 9. Concorrenza: goroutine e canali

Una **goroutine** è un thread leggero gestito dal runtime di Go.

```go
go faiQualcosa()   // avvia una goroutine
```

I **canali** permettono la comunicazione sincronizzata tra goroutine.

```go
ch := make(chan int)

go func() {
    ch <- 42          // invia
}()

v := <-ch             // riceve
fmt.Println(v)
```

Esempio con `sync.WaitGroup` per attendere più goroutine:

```go
var wg sync.WaitGroup
for i := 0; i < 3; i++ {
    wg.Add(1)
    go func(n int) {
        defer wg.Done()
        fmt.Println("lavoro", n)
    }(i)
}
wg.Wait()
```

Il modello di concorrenza si ispira alla teoria dei **Communicating Sequential Processes (CSP)**. Il motto idiomatico è:

> *"Non comunicare condividendo la memoria; condividi la memoria comunicando."*




## 10. Esempio completo: numeri di Fibonacci

La successione di Fibonacci è definita ricorsivamente da:

$$
F(n) =
\begin{cases}
0 & \text{se } n = 0 \\
1 & \text{se } n = 1 \\
F(n-1) + F(n-2) & \text{se } n \ge 2
\end{cases}
$$

Implementazione iterativa con complessità $O(n)$:

```go
package main

import "fmt"

func fibonacci(n int) int {
    a, b := 0, 1
    for i := 0; i < n; i++ {
        a, b = b, a+b
    }
    return a
}

func main() {
    for i := 0; i <= 10; i++ {
        fmt.Printf("F(%d) = %d\n", i, fibonacci(i))
    }
}
```

La forma chiusa (formula di Binet) fornisce l'$n$-esimo termine senza iterazione:

$$
F(n) = \frac{\varphi^{n} - \psi^{n}}{\sqrt{5}}, \qquad
\varphi = \frac{1 + \sqrt{5}}{2}, \quad \psi = \frac{1 - \sqrt{5}}{2}
$$

dove $\varphi$ è la sezione aurea.




## 11. Strumenti e comandi utili

| Comando | Descrizione |
|---|---|
| `go run file.go` | Compila ed esegue |
| `go build` | Compila un eseguibile |
| `go test` | Esegue i test |
| `go fmt` | Formatta il codice |
| `go mod init` | Inizializza un modulo |
| `go get` | Aggiunge dipendenze |




## 12. Documentazione

Documentazione ufficiale: [https://golang.org/doc/](https://golang.org/doc/)
