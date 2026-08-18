# Analisi 1 → Analisi 2: ripasso essenziale

> Ripasso mirato dei prerequisiti di Analisi 1, organizzato in funzione del programma di Analisi 2:
> successioni e serie, teoria della misura e integrazione, calcolo differenziale in più variabili,
> ottimizzazione libera, integrali doppi, equazioni differenziali ordinarie.




## Mappa: cosa serve per cosa

| Argomento di Analisi 2 | Prerequisiti di Analisi 1 |
|---|---|
| Successioni e serie numeriche | Successioni, limiti, criteri di convergenza |
| Teoria della misura e integrazione | Integrale di Riemann, sup/inf, completezza di $\mathbb{R}$ |
| Calcolo differenziale in più variabili | Derivate, regole, Taylor, continuità |
| Ottimizzazione libera | Estremi locali, test derivata seconda, convessità |
| Formula di riduzione (integrali doppi) | Integrale di Riemann, tecniche di integrazione |
| EDO (separabili, lineari 2° ordine) | Primitive, tecniche di integrazione, numeri complessi |




## 1. Numeri reali, estremo superiore e inferiore

$\mathbb{R}$ è un **campo ordinato completo**. La completezza è ciò che distingue $\mathbb{R}$ da $\mathbb{Q}$ ed è alla radice di tutti i teoremi di convergenza.

**Maggioranti e minoranti.** $M$ è un maggiorante di $A \subseteq \mathbb{R}$ se $x \le M$ per ogni $x \in A$.

**Estremo superiore.** $s = \sup A$ è il più piccolo dei maggioranti. Caratterizzazione operativa:

$$
s = \sup A \iff \begin{cases} x \le s & \forall x \in A \\ \forall \varepsilon > 0 \ \exists x \in A : x > s - \varepsilon \end{cases}
$$

Analogamente $\inf A$ è il più grande dei minoranti.

**Assioma di completezza.** Ogni sottoinsieme di $\mathbb{R}$ non vuoto e superiormente limitato ammette estremo superiore in $\mathbb{R}$.

> **Serve per:** convergenza di successioni monotone, integrale di Riemann (sup/inf delle somme), e come idea-guida per la costruzione della misura.




## 2. Successioni numeriche

**Limite (definizione $\varepsilon$–$N$).**

$$\lim_{n \to \infty} a_n = \ell \iff \forall \varepsilon > 0 \ \exists N \in \mathbb{N} : n > N \Rightarrow |a_n - \ell| < \varepsilon$$

**Teorema (monotonia + limitatezza).** Se $(a_n)$ è monotona e limitata, allora converge; se crescente $\lim a_n = \sup_n a_n$, se decrescente $\lim a_n = \inf_n a_n$.

**Algebra dei limiti.** Se $a_n \to a$ e $b_n \to b$ (finiti):

$$a_n \pm b_n \to a \pm b, \qquad a_n b_n \to ab, \qquad \frac{a_n}{b_n} \to \frac{a}{b}\ (b \neq 0)$$

Forme indeterminate: $\infty - \infty,\ 0 \cdot \infty,\ \frac{0}{0},\ \frac{\infty}{\infty},\ 1^\infty,\ 0^0,\ \infty^0$.

**Teorema del confronto (dei carabinieri).** Se $a_n \le c_n \le b_n$ definitivamente e $a_n, b_n \to \ell$, allora $c_n \to \ell$.

**Limiti notevoli e gerarchia degli infiniti.** Per $n \to \infty$, con $a>1$, $\alpha>0$:

$$\log n \ll n^\alpha \ll a^n \ll n! \ll n^n$$

$$\left(1 + \frac{1}{n}\right)^n \to e, \qquad \sqrt[n]{n} \to 1, \qquad \sqrt[n]{a} \to 1$$

**Sottosuccessioni e Bolzano–Weierstrass.** Ogni successione limitata ammette una sottosuccessione convergente.

**Criterio di Cauchy.** $(a_n)$ converge $\iff$ è di Cauchy: $\forall \varepsilon>0\ \exists N: n,m>N \Rightarrow |a_n - a_m| < \varepsilon$.

> **Serve per:** le serie sono per definizione limiti di successioni (le somme parziali). Tutto ciò che segue poggia qui.




## 3. Serie numeriche (ponte verso Analisi 2)

Sviluppate a fondo nel corso, ma è la naturale continuazione delle successioni: la serie $\sum_{n} a_n$ è il limite delle **somme parziali** $S_N = \sum_{n=1}^{N} a_n$.

$$\sum_{n=1}^{\infty} a_n = \lim_{N \to \infty} S_N$$

**Serie di riferimento.**

$$\sum_{n=0}^{\infty} q^n = \frac{1}{1-q} \quad (|q|<1) \qquad \text{(geometrica)}$$

$$\sum_{n=1}^{\infty} \frac{1}{n^\alpha} \quad \text{converge} \iff \alpha > 1 \qquad \text{(armonica generalizzata)}$$

**Condizione necessaria.** Se $\sum a_n$ converge allora $a_n \to 0$ (non sufficiente: l'armonica $\sum 1/n$ diverge pur avendo $a_n \to 0$).

**Criteri (per serie a termini positivi).**

- **Confronto:** $0 \le a_n \le b_n$; se $\sum b_n$ converge, converge $\sum a_n$.
- **Confronto asintotico:** se $a_n \sim b_n$ (cioè $a_n/b_n \to 1$), hanno lo stesso carattere.
- **Rapporto:** $L = \lim \dfrac{a_{n+1}}{a_n}$; converge se $L<1$, diverge se $L>1$.
- **Radice:** $L = \lim \sqrt[n]{a_n}$; converge se $L<1$, diverge se $L>1$.
- **Integrale:** con $f$ positiva decrescente, $\sum f(n)$ e $\int_1^\infty f$ hanno lo stesso carattere.

**Serie a segni alterni — Leibniz.** Se $b_n \ge 0$ è decrescente e $b_n \to 0$, allora $\sum (-1)^n b_n$ converge.

**Convergenza assoluta.** Se $\sum \|a_n\|$ converge, allora $\sum a_n$ converge (non viceversa).

> **Serve per:** è letteralmente il primo blocco del tuo programma. In più le serie di potenze e Fourier che incontrerai poggiano su questi criteri.




## 4. Limiti di funzioni e continuità

**Continuità.** $f$ è continua in $x_0$ se $\lim_{x \to x_0} f(x) = f(x_0)$.

**Teoremi fondamentali su $[a,b]$ (compatto):**

- **Weierstrass:** $f$ continua su $[a,b]$ è limitata e assume massimo e minimo.
- **Valori intermedi (Bolzano):** $f$ continua su $[a,b]$ assume ogni valore tra $f(a)$ e $f(b)$.
- **Zeri:** se $f(a)f(b) < 0$ e $f$ continua, esiste $c \in (a,b)$ con $f(c)=0$.

> **Serve per:** la continuità di funzioni di più variabili generalizza questa; il teorema di Weierstrass è la garanzia di esistenza del massimo/minimo su cui si fonda l'ottimizzazione.




## 5. Calcolo differenziale in una variabile

**Derivata.**

$$f'(x_0) = \lim_{h \to 0} \frac{f(x_0 + h) - f(x_0)}{h}$$

Interpretazione: coefficiente angolare della retta tangente. La retta tangente è $y = f(x_0) + f'(x_0)(x-x_0)$.

**Derivabilità $\Rightarrow$ continuità** (non viceversa: es. $\|x\|$ in $0$).

**Regole di derivazione.**

$$(fg)' = f'g + fg', \qquad \left(\frac{f}{g}\right)' = \frac{f'g - fg'}{g^2}, \qquad (f \circ g)'(x) = f'(g(x))\, g'(x)$$

**Derivate notevoli.**

| $f(x)$ | $f'(x)$ |
|---|---|
| $x^n$ | $n x^{n-1}$ |
| $e^x$ | $e^x$ |
| $a^x$ | $a^x \ln a$ |
| $\ln x$ | $1/x$ |
| $\sin x$ | $\cos x$ |
| $\cos x$ | $-\sin x$ |
| $\tan x$ | $1/\cos^2 x = 1 + \tan^2 x$ |
| $\arctan x$ | $1/(1+x^2)$ |
| $\arcsin x$ | $1/\sqrt{1-x^2}$ |

**Teoremi del valor medio.**

- **Fermat:** in un estremo interno con $f$ derivabile, $f'(x_0) = 0$.
- **Rolle:** $f$ continua su $[a,b]$, derivabile in $(a,b)$, $f(a)=f(b)$ $\Rightarrow \exists c: f'(c)=0$.
- **Lagrange:** $\exists c \in (a,b): f'(c) = \dfrac{f(b)-f(a)}{b-a}$.
- **Cauchy:** $\dfrac{f'(c)}{g'(c)} = \dfrac{f(b)-f(a)}{g(b)-g(a)}$.

**De l'Hôpital.** Nelle forme $\frac{0}{0}$ o $\frac{\infty}{\infty}$: $\lim \dfrac{f}{g} = \lim \dfrac{f'}{g'}$ (se il secondo esiste).

> **Serve per:** le derivate parziali e il gradiente sono derivate "una direzione alla volta"; i punti critici in più variabili generalizzano Fermat ($\nabla f = 0$).




## 6. Formula di Taylor

**Polinomio di Taylor con resto di Peano** (centro $x_0$):

$$f(x) = \sum_{k=0}^{n} \frac{f^{(k)}(x_0)}{k!}(x-x_0)^k + o\big((x-x_0)^n\big)$$

**Resto di Lagrange:** esiste $\xi$ tra $x_0$ e $x$ tale che il resto è $\dfrac{f^{(n+1)}(\xi)}{(n+1)!}(x-x_0)^{n+1}$.

**Sviluppi notevoli in $x_0 = 0$** (di McLaurin):

$$e^x = 1 + x + \frac{x^2}{2!} + \frac{x^3}{3!} + \cdots$$

$$\sin x = x - \frac{x^3}{3!} + \frac{x^5}{5!} - \cdots \qquad \cos x = 1 - \frac{x^2}{2!} + \frac{x^4}{4!} - \cdots$$

$$\ln(1+x) = x - \frac{x^2}{2} + \frac{x^3}{3} - \cdots \qquad \frac{1}{1-x} = \sum_{n=0}^{\infty} x^n$$

$$(1+x)^\alpha = 1 + \alpha x + \binom{\alpha}{2} x^2 + \cdots \qquad \arctan x = x - \frac{x^3}{3} + \frac{x^5}{5} - \cdots$$

> **Serve per:** la formula di Taylor in più variabili usa gradiente e **matrice hessiana**; è lo strumento che classifica i punti critici (sezione 7 in versione multivariabile).




## 7. Estremi e convessità (precursore diretto dell'ottimizzazione)

**Monotonia dal segno della derivata.** Su un intervallo: $f' \ge 0 \Rightarrow f$ crescente; $f' \le 0 \Rightarrow f$ decrescente.

**Estremi locali.**

- **Condizione necessaria (Fermat):** se $x_0$ interno è estremo e $f$ derivabile, allora $f'(x_0) = 0$ (punto critico).
- **Test della derivata seconda:** se $f'(x_0) = 0$, allora

$$f''(x_0) > 0 \Rightarrow \text{minimo locale}, \qquad f''(x_0) < 0 \Rightarrow \text{massimo locale}$$

(se $f'' (x_0)=0$ il test è inconcludente).

**Convessità.** $f$ è convessa $\iff f'' \ge 0$; concava $\iff f'' \le 0$. Un punto dove la concavità cambia è un **flesso**.

> **Serve per:** l'ottimizzazione libera in più variabili è la trasposizione esatta di questa sezione — $f'(x_0)=0$ diventa $\nabla f = 0$, e il segno di $f''$ diventa il **segno della matrice hessiana** (definita positiva → minimo, definita negativa → massimo, indefinita → sella).




## 8. Integrale di Riemann

**Definizione (somme di Darboux).** Data una partizione di $[a,b]$, si costruiscono somme inferiori $s(P)$ (con gli inf su ogni sottointervallo) e superiori $S(P)$ (con i sup). $f$ è **integrabile** se

$$\sup_P s(P) = \inf_P S(P) =: \int_a^b f(x)\, dx$$

**Classi integrabili.** Le funzioni continue su $[a,b]$ sono integrabili; anche le monotone e le continue a tratti lo sono.

**Proprietà.**

$$\int_a^b (\alpha f + \beta g) = \alpha \int_a^b f + \beta \int_a^b g \quad \text{(linearità)}$$

$$\int_a^b f = \int_a^c f + \int_c^b f \quad \text{(additività)}, \qquad f \le g \Rightarrow \int_a^b f \le \int_a^b g \quad \text{(monotonia)}$$

**Teorema della media integrale.** Se $f$ è continua, esiste $c \in [a,b]$ con

$$\int_a^b f(x)\, dx = f(c)\,(b-a)$$

**Teorema fondamentale del calcolo.**

- *Parte I:* se $f$ è continua, $F(x) = \int_a^x f(t)\, dt$ è derivabile e $F'(x) = f(x)$.
- *Parte II:* se $G$ è una primitiva di $f$, allora $\displaystyle \int_a^b f(x)\, dx = G(b) - G(a)$.

> **Serve per:** la teoria della misura generalizza l'idea di "area sotto il grafico"; la **formula di riduzione** per gli integrali doppi consiste nel calcolare un integrale semplice alla volta, quindi tutto ciò che qui impari si applica direttamente.




## 9. Tecniche di integrazione (calcolo delle primitive)

**Primitive immediate.**

$$\int x^n \, dx = \frac{x^{n+1}}{n+1} + C \ (n \neq -1), \qquad \int \frac{1}{x}\, dx = \ln|x| + C$$

$$\int e^x \, dx = e^x + C, \qquad \int \frac{1}{1+x^2}\, dx = \arctan x + C$$

**Integrazione per sostituzione.**

$$\int f(g(x))\, g'(x)\, dx = \int f(u)\, du \quad (u = g(x))$$

**Integrazione per parti.**

$$\int f(x)\, g'(x)\, dx = f(x)\, g(x) - \int f'(x)\, g(x)\, dx$$

**Funzioni razionali (fratti semplici).** Si scompone $\dfrac{P(x)}{Q(x)}$ (con $\deg P < \deg Q$) in somma di termini del tipo $\dfrac{A}{(x-a)^k}$ e $\dfrac{Bx+C}{(x^2+px+q)^k}$, integrabili singolarmente.

> **Serve per:** è il cuore operativo della risoluzione delle EDO separabili e lineari, e del calcolo effettivo degli integrali doppi. Vale la pena averlo davvero in mano.




## 10. Ponte verso le EDO

Il tuo programma chiude con equazioni separabili e lineari del 2° ordine: ecco i due tasselli che li rendono immediati.

**EDO a variabili separabili.** $y' = f(x)\, g(y)$ si risolve separando e integrando:

$$\int \frac{dy}{g(y)} = \int f(x)\, dx$$

Ecco perché la sezione 9 è indispensabile: risolvere un'EDO separabile *è* calcolare due primitive.

**EDO lineari 2° ordine a coefficienti costanti (omogenee):** $a y'' + b y' + c y = 0$. Si cerca $y = e^{\lambda x}$ e si arriva all'**equazione caratteristica**

$$a \lambda^2 + b \lambda + c = 0$$

Tre casi secondo il discriminante:

| Radici | Soluzione generale |
|---|---|
| Reali distinte $\lambda_1 \neq \lambda_2$ | $y = c_1 e^{\lambda_1 x} + c_2 e^{\lambda_2 x}$ |
| Reale doppia $\lambda$ | $y = (c_1 + c_2 x)\, e^{\lambda x}$ |
| Complesse $\alpha \pm i\beta$ | $y = e^{\alpha x}(c_1 \cos \beta x + c_2 \sin \beta x)$ |

**Numeri complessi ed Eulero** (per il caso complesso):

$$e^{i\theta} = \cos\theta + i\sin\theta \qquad \Rightarrow \qquad e^{(\alpha + i\beta)x} = e^{\alpha x}\big(\cos\beta x + i \sin\beta x\big)$$

> **Serve per:** risolvere le radici complesse dell'equazione caratteristica e capire da dove vengono seno e coseno nella soluzione.




## Appendice: formulario compatto

**Limiti notevoli (per $x \to 0$).**

$$\frac{\sin x}{x} \to 1, \qquad \frac{1 - \cos x}{x^2} \to \frac{1}{2}, \qquad \frac{e^x - 1}{x} \to 1, \qquad \frac{\ln(1+x)}{x} \to 1$$

**Serie di riferimento.**

$$\sum_{n=0}^{\infty} q^n = \frac{1}{1-q}\ (|q|<1), \qquad \sum_{n=1}^{\infty} \frac{1}{n^\alpha}: \text{converge} \iff \alpha > 1$$

**Le due formule "motore" delle EDO.**

$$\text{separabili: } \int \frac{dy}{g(y)} = \int f(x)\, dx \qquad\quad \text{lineari: } a\lambda^2 + b\lambda + c = 0$$
