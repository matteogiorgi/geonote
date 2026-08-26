# GNU Guile — fondamenti del linguaggio

## 1. Cos'è Guile

**GNU Guile** (*GNU Ubiquitous Intelligent Language for Extensions*) è il linguaggio di
estensione ufficiale del Progetto GNU. È un'implementazione del linguaggio **Scheme**, a sua
volta un dialetto minimalista ed elegante della famiglia **Lisp**. La sua prima versione risale
al 1993; la serie stabile corrente è la **3.0.x** (versione **3.0.11**, dicembre 2025).

Guile nasce con un duplice scopo:

1. **Linguaggio autonomo** — può funzionare in modo interattivo (REPL), come interprete di
   script e come compilatore Scheme verso bytecode eseguito da una macchina virtuale.
2. **Libreria incorporabile** — può essere integrato in programmi C/C++ per fornire un motore
  Scheme completo, usato come linguaggio di scripting, configurazione o estensione.

Conformità agli standard: Guile implementa **R5RS**, gran parte di **R6RS** e **R7RS**, oltre a
numerosi **SRFI** (*Scheme Requests for Implementation*). Include accesso completo alle chiamate
di sistema POSIX, networking, thread multipli, collegamento dinamico, una FFI (interfaccia verso C)
e persino client e server HTTP.

Programmi noti che usano Guile come motore di estensione o linguaggio interno: **GNU Guix**
(gestore di pacchetti), **GnuCash**, **GDB**, **LilyPond**, **GNU TeXmacs**, **Lepton EDA**.




## 2. La sintassi: le S-espressioni

Come ogni Lisp, Guile scrive il codice come **S-espressioni** (liste racchiuse tra parentesi) in
**notazione prefissa**: l'operatore precede sempre gli operandi.

```scheme
;; Un commento inizia con ;
(+ 1 2 3)          ; => 6
(* (+ 1 2) (- 5 1)) ; => 12   equivale a (1+2) * (5-1)
(display "Ciao, mondo!\n")
```

L'espressione `(* (+ 1 2) (- 5 1))` corrisponde all'espressione matematica:

$$(1 + 2) \times (5 - 1) = 3 \times 4 = 12$$

Il fatto che codice e dati abbiano la stessa forma (una lista) è la proprietà di
*omoiconicità*, che rende le macro estremamente potenti.




## 3. Tipi di dato principali

```scheme
42                  ; intero (bignum: precisione arbitraria)
3.14                ; numero in virgola mobile (reale)
1/3                 ; numero razionale esatto
3+4i                ; numero complesso
#\a                 ; carattere
"stringa"           ; stringa
#t  #f              ; booleani (vero / falso)
'simbolo            ; simbolo
'(1 2 3)            ; lista
#(1 2 3)            ; vettore
(cons 1 2)          ; coppia (pair): (1 . 2)
```

Guile supporta la **torre numerica** completa di Scheme. Un razionale esatto come $\frac{1}{3}$
non viene approssimato:

```scheme
(+ 1/3 1/6)   ; => 1/2   (esatto, non 0.5)
(* 1/3 3)     ; => 1     (nessun errore di arrotondamento)
```

$$\frac{1}{3} + \frac{1}{6} = \frac{2}{6} + \frac{1}{6} = \frac{3}{6} = \frac{1}{2}$$




## 4. Definizioni e funzioni

Si usa `define` per legare un nome a un valore o a una funzione. Le funzioni anonime si creano
con `lambda`, l'equivalente diretto della notazione del **calcolo lambda** $\lambda x.\, e$.

```scheme
(define pi 3.14159)

;; Funzione con nome
(define (quadrato x)
  (* x x))

;; Funzione anonima equivalente a  λx. x*x
(define quadrato-anon
  (lambda (x) (* x x)))

(quadrato 5)   ; => 25
```

L'area di un cerchio, $A = \pi r^2$, si traduce direttamente:

```scheme
(define (area-cerchio r)
  (* pi (quadrato r)))

(area-cerchio 2)   ; => 12.56636
```




## 5. Ricorsione

Scheme non ha bisogno di cicli tradizionali: la **ricorsione** è il costrutto naturale.


### Fattoriale

Definizione matematica:

$$n! = \prod_{k=1}^{n} k = n \times (n-1) \times \cdots \times 1, \qquad 0! = 1$$

```scheme
(define (fattoriale n)
  (if (= n 0)
      1
      (* n (fattoriale (- n 1)))))

(fattoriale 5)   ; => 120
(fattoriale 30)  ; => 265252859812191058636308480000000  (bignum!)
```


### Successione di Fibonacci

Definita dalla ricorrenza:

$$F_0 = 0, \quad F_1 = 1, \quad F_n = F_{n-1} + F_{n-2} \ \ (n \ge 2)$$

```scheme
(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1))
         (fib (- n 2)))))

(fib 10)   ; => 55
```




## 6. Ricorsione di coda e iterazione

La versione ingenua di Fibonacci ha complessità esponenziale $O(\varphi^n)$, dove
$\varphi = \frac{1 + \sqrt{5}}{2}$ è la sezione aurea. Riscrivendola in **ricorsione di coda**
(*tail recursion*) si ottiene complessità lineare $O(n)$ e spazio costante, perché Guile
garantisce l'ottimizzazione delle chiamate in coda (*proper tail calls*).

```scheme
(define (fib-veloce n)
  (let loop ((a 0) (b 1) (k n))
    (if (= k 0)
        a
        (loop b (+ a b) (- k 1)))))

(fib-veloce 50)   ; => 12586269025   (istantaneo)
```

Qui `let loop` definisce un ciclo interno: `a` e `b` accumulano i due termini consecutivi
$(F_k, F_{k+1})$ e `k` conta a ritroso. Poiché la chiamata a `loop` è l'ultima operazione, non
consuma stack aggiuntivo.




## 7. Funzioni di ordine superiore

Le funzioni sono valori di prima classe: si passano come argomenti e si restituiscono come
risultati. Le operazioni fondamentali dell'esempio sono `map`, `filter` e `fold`,
disponibili tramite SRFI-1.

```scheme
(use-modules (srfi srfi-1))

;; map: applica una funzione a ogni elemento
(map quadrato '(1 2 3 4))          ; => (1 4 9 16)

;; filter: seleziona gli elementi che soddisfano un predicato
(filter even? '(1 2 3 4 5 6))      ; => (2 4 6)

;; fold: riduce una lista a un singolo valore
(fold + 0 '(1 2 3 4 5))            ; => 15
```

L'ultima riga calcola la somma:

$$\sum_{k=1}^{5} k = 1 + 2 + 3 + 4 + 5 = 15$$

Combinando le tre operazioni si esprime, ad esempio, la somma dei quadrati dei numeri pari:

$$\sum_{\substack{k=1 \\ k \text{ pari}}}^{n} k^2$$

```scheme
(define (somma-quadrati-pari n)
  (fold +
        0
        (map quadrato
             (filter even?
                     (iota n 1)))))   ; iota genera 1..n

(somma-quadrati-pari 6)   ; => 4 + 16 + 36 = 56
```




## 8. Macro: estendere il linguaggio

Grazie all'omoiconicità, Guile permette di creare nuovi costrutti sintattici con le **macro
igieniche**. `syntax-rules` è il meccanismo più semplice.

```scheme
;; Definiamo un costrutto `while` tramite una macro igienica
(define-syntax while
  (syntax-rules ()
    ((_ condition body ...)
     (let loop ()
       (when condition
         body ...
         (loop))))))

;; Uso
(define i 0)
(while (< i 3)
  (display i)
  (newline)
  (set! i (+ i 1)))
;; Stampa 0, 1, 2
```

Le macro operano a tempo di compilazione e sono igieniche: non catturano
accidentalmente i nomi di variabili del contesto in cui vengono espanse.




## 9. Il sistema dei moduli

Guile organizza il codice in **moduli**, che controllano quali definizioni sono visibili
all'esterno.

```scheme
;; File: matematica.scm
(define-module (mio matematica)
  #:use-module (srfi srfi-1)
  #:export (media varianza))

(define (quadrato x)
  (* x x))

(define (media lst)
  (/ (fold + 0 lst)
     (length lst)))

;; Varianza:  σ² = (1/n) Σ (xᵢ - μ)²
(define (varianza lst)
  (let ((mu (media lst))
        (n  (length lst)))
    (/ (fold + 0
             (map (lambda (x) (quadrato (- x mu))) lst))
       n)))
```

La varianza calcolata corrisponde alla formula:

$$\sigma^2 = \frac{1}{n} \sum_{i=1}^{n} (x_i - \mu)^2, \qquad \mu = \frac{1}{n}\sum_{i=1}^{n} x_i$$

Per usare il modulo altrove:

```scheme
(use-modules (mio matematica))
(varianza '(2 4 4 4 5 5 7 9))   ; => 4
```




## 10. Continuazioni

Una caratteristica potente di Scheme è `call-with-current-continuation` (abbreviato `call/cc`),
che cattura lo "stato di esecuzione futuro" come un valore riutilizzabile. Serve per implementare
eccezioni, generatori, backtracking e coroutine.

```scheme
;; Uscita anticipata da una ricerca
(define (trova-primo pred lst)
  (call/cc
    (lambda (esci)
      (for-each (lambda (x)
                  (when (pred x)
                    (esci x)))   ; salta fuori immediatamente
                lst)
      #f)))

(trova-primo even? '(1 3 5 8 9))   ; => 8
```




## 11. Metodo di Newton (esempio numerico)

Un esempio classico di Scheme è il calcolo della radice quadrata con il **metodo di Newton**.
Per approssimare $\sqrt{x}$ si itera:

$$y_{n+1} = \frac{1}{2}\left(y_n + \frac{x}{y_n}\right)$$

fino a quando $|y_n^2 - x|$ è sufficientemente piccolo.

```scheme
(define (radice x)
  (define (abbastanza-vicino? y)
    (< (abs (- (* y y) x)) 1e-10))
  (define (migliora y)
    (/ (+ y (/ x y)) 2))
  (let iterazione ((y 1.0))
    (if (abbastanza-vicino? y)
        y
        (iterazione (migliora y)))))

(radice 2)    ; => 1.4142135623730951
(radice 144)  ; => 12.0
```




## 12. Programmazione a oggetti: GOOPS

Guile include **GOOPS** (*Guile Object-Oriented Programming System*), un sistema a oggetti
ispirato al CLOS di Common Lisp, con classi, ereditarietà multipla e metodi generici.

```scheme
(use-modules (oop goops))

(define-class <punto> ()
  (x #:init-value 0 #:accessor punto-x #:init-keyword #:x)
  (y #:init-value 0 #:accessor punto-y #:init-keyword #:y))

;; Metodo generico: distanza dall'origine  d = √(x² + y²)
(define-method (distanza (p <punto>))
  (sqrt (+ (quadrato (punto-x p))
           (quadrato (punto-y p)))))

(define p (make <punto> #:x 3 #:y 4))
(distanza p)   ; => 5.0
```

La distanza euclidea dall'origine è:

$$d = \sqrt{x^2 + y^2} = \sqrt{3^2 + 4^2} = \sqrt{25} = 5$$




## 13. Integrazione con C (incorporazione ed estensione)

Il tratto distintivo di Guile è la facilità con cui si integra nel codice C. Un programma C può
incorporare l'interprete Scheme:

```c
#include <libguile.h>

static void* inner_main(void* data) {
    /* Valuta espressioni Scheme dal C */
    scm_c_eval_string("(display \"Ciao da Scheme!\\n\")");
    return NULL;
}

int main(int argc, char** argv) {
    scm_boot_guile(argc, argv, &inner_main, NULL);
    return 0;
}
```

Compilazione tipica:

```bash
gcc programma.c -o programma $(pkg-config --cflags --libs guile-3.0)
```

Viceversa, tramite la **FFI** Scheme può chiamare funzioni C di librerie condivise senza scrivere
alcun wrapper in C.




## 14. Concorrenza

Guile offre thread nativi e, tramite la libreria **Fibers**, un modello di concorrenza cooperativa
leggera basato su canali e messaggi (in stile Concurrent ML / goroutine).

```scheme
;; Thread nativo
(use-modules (ice-9 threads))

(define t
  (call-with-new-thread
    (lambda () (+ 1 2 3))))

(join-thread t)   ; => 6
```




## 15. Esecuzione: REPL, script e compilazione

```bash
# REPL interattivo
$ guile

# Eseguire uno script
$ guile mio-script.scm

# Compilare in bytecode (.go) per esecuzione più veloce
$ guild compile mio-script.scm -o mio-script.go
```

Uno script eseguibile può iniziare con uno "shebang" ibrido:

```scheme
#!/usr/bin/env guile
!#
(display "Sono uno script Guile\n")
```




## 16. Riepilogo dei punti di forza

| Caratteristica | Descrizione |
|---|---|
| **Standard** | R5RS, R6RS, R7RS + molti SRFI |
| **Numeri** | Torre numerica completa (interi arbitrari, razionali esatti, complessi) |
| **Compilazione** | Bytecode su VM, con compilatore JIT nella serie 3.0 |
| **Macro** | Igieniche (`syntax-rules`, `syntax-case`) |
| **Continuazioni** | `call/cc`, continuazioni delimitate |
| **Oggetti** | GOOPS (stile CLOS) |
| **Integrazione C** | Incorporazione bidirezionale + FFI |
| **Concorrenza** | Thread POSIX, Fibers |
| **Ruolo** | Linguaggio di estensione ufficiale di GNU |




## 17. Documentazione e risorse

- **Manuale di riferimento ufficiale**: <https://www.gnu.org/software/guile/manual/>
- **Sito ufficiale**: <https://www.gnu.org/software/guile/>
- **Tutorial "A Scheme Primer"** (Spritely Institute): consigliato per iniziare
- Il libro *Structure and Interpretation of Computer Programs* (SICP) usa un dialetto Scheme
  molto vicino a Guile ed è un'ottima introduzione ai concetti.

> **Nota sulla versione**: gli esempi fanno riferimento alla serie **Guile 3.0.x**. Verifica sempre
> il manuale della versione installata con `guile --version`.
