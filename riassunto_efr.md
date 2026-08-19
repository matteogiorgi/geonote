# Economia e Finanza del Risparmio — Riassunto per l'esame

> Guida di studio basata su dispense (Pattitoni) ed eserciziario. Ogni sezione contiene: **teoria essenziale**, **formule chiave**, **metodo di svolgimento degli esercizi** e **trappole tipiche dei quiz**.




## Indice

1. [Consumo e risparmio: concetti e misure](#1-consumo-e-risparmio-concetti-e-misure)
2. [Scelte intertemporali di consumo](#2-scelte-intertemporali-di-consumo)
3. [Markowitz e le scelte di portafoglio](#3-markowitz-e-le-scelte-di-portafoglio)
4. [Sistemi pensionistici](#4-sistemi-pensionistici)
5. [Formulario riassuntivo](#5-formulario-riassuntivo)




<div style="height: 4em;"></div>

# 1. Consumo e risparmio: concetti e misure

## 1.1 Prospettiva microeconomica

Prospettiva del **singolo individuo / famiglia**. Simboli fondamentali:

- $C_t$ = consumo · $A_t$ = ricchezza accumulata · $W_t$ = salario · $T_t$ = imposte nette · $r$ = tasso di interesse.




### Le quattro identità di base

**Reddito totale** = reddito da capitale + reddito da lavoro:
$$Y_t = A_{t-1}\, r + W_t$$

**Reddito disponibile** (reddito al netto delle imposte):
$$Y_t^D = Y_t - T_t$$

**Risparmio** (parte del reddito disponibile non consumata):
$$S_t = Y_t^D - C_t$$

**Ricchezza** (evolve accumulando il risparmio):
$$A_t = A_{t-1} + S_t = A_{t-1}(1+r) + W_t - T_t - C_t \qquad\Longrightarrow\qquad A_t = A_0 + \sum_{\tau=1}^{t} S_\tau$$


### Relazioni logiche (utili per i quiz)

- $r \uparrow \Rightarrow$ reddito da capitale $\uparrow$ e la ricchezza futura **cresce più velocemente**.
- $T_t \uparrow$ (a parità di $Y_t, C_t$) $\Rightarrow Y_t^D \downarrow \Rightarrow S_t \downarrow$.
- $W_t \uparrow$ (a parità di $A_{t-1}, r$) $\Rightarrow Y_t \uparrow$.
- Se $S_t = 0 \Rightarrow Y_t^D = C_t$.
- A parità di $Y_t^D$: $C_t \uparrow \Rightarrow S_t \downarrow$.


### Metodo per l'esercizio "tabella multi-periodo"

Dati $A_0$, $W$ costante, $r$, aliquota $\tau$, funzione di consumo $C_t = b\,Y_t^D$. Per **ogni** periodo, in ordine:

1. $Y_t = A_{t-1} r + W_t$
2. $T_t = \tau\, Y_t$
3. $Y_t^D = Y_t - T_t$
4. $C_t = b\, Y_t^D$
5. $S_t = Y_t^D - C_t$
6. $A_t = A_{t-1} + S_t$ ← diventa l'$A_{t-1}$ del periodo successivo.

> **Esempio numerico** ($W=120$, $r=0.04$, $\tau=0.25$, $b=0.7$, $A_0=0$):
> $Y_1=120$, $T_1=30$, $Y_1^D=90$, $C_1=63$, $S_1=27$, $A_1=27$.
> Al periodo 2: $Y_2 = 27\cdot0.04 + 120 = 121.08$, e così via.
> Se $b$ **scende** (es. $0.7 \to 0.6$): il consumo diminuisce, il risparmio aumenta e quindi la **ricchezza finale cresce**.




## 1.2 Prospettiva macroeconomica

Prospettiva **aggregata (un Paese)**. Simboli: $Y_t$ (PIL), $C_t$ (consumo privato), $I_t$ (investimenti), $G_t$ (spesa pubblica, esclusi i trasferimenti come pensioni/sussidi), $X_t$/$M_t$ (esport./import.), $T_t$ (imposte nette), $D_t$ (debito pubblico), $r$ (tasso sul debito), $g$ (crescita del PIL).


### Identità contabile nazionale

$$Y_t = C_t + I_t + G_t + (X_t - M_t)$$


### Saldi settoriali

$$\underbrace{Y_t - T_t - C_t - I_t}_{\text{saldo settore privato}} + \underbrace{(T_t - G_t)}_{\text{saldo primario pubblico}} = \underbrace{X_t - M_t}_{\text{saldo commerciale}}$$


### Risparmio nazionale e privato

- **Risparmio privato**: $\;S_t^{Pr} = Y_t - T_t - C_t$
- **Risparmio pubblico** (= saldo primario): $\;S_t^{Pu} = T_t - G_t$
- **Risparmio nazionale**: $\;S_t = S_t^{Pr} + (T_t - G_t) = I_t + (X_t - M_t)$

> Il risparmio nazionale eguaglia **investimenti interni + saldo commerciale**. È l'identità da usare per le verifiche.


### Dinamica del debito pubblico

$$D_t = D_{t-1}(1+r) + (G_t - T_t)$$
$$Y_t = Y_{t-1}(1+g) \qquad\qquad \frac{D_t}{Y_t} = \frac{D_{t-1}(1+r) + G_t - T_t}{Y_{t-1}(1+g)}$$


### Variazione del rapporto debito/PIL

$$\frac{D_t}{Y_t} - \frac{D_{t-1}}{Y_{t-1}} = \frac{(G_t - T_t) + D_{t-1}(r-g)}{Y_t}$$

**Condizione di non crescita del rapporto** ($\Delta(D/Y)\le 0$):
$$\begin{cases} r \neq g \;\Rightarrow\; T_t - G_t \ge D_{t-1}(r-g) \\ r = g \;\Rightarrow\; T_t - G_t \ge 0 \end{cases}$$

Interpretazioni per i quiz:
- $g \uparrow$ (a parità del resto) $\Rightarrow$ rapporto debito/PIL **più basso**.
- $r \uparrow \Rightarrow$ onere del debito $\uparrow$.
- Se $r = g$, per **stabilizzare** il rapporto serve saldo primario **nullo**.
- Se $r > g$ e c'è disavanzo primario, per stabilizzare serve **aumentare le imposte o ridurre la spesa**.


### Metodo per l'esercizio macro tipo

1. **Saldo primario** $= T_t - G_t$ (>0 avanzo, <0 disavanzo, =0 pareggio).
2. **Risparmio privato** $= Y_t - T_t - C_t$.
3. **Saldo commerciale** $= X_t - M_t$.
4. **Risparmio nazionale** $= S_t^{Pr} + (T_t-G_t)$; **verifica** $= I_t + (X_t - M_t)$.
5. **Nuovo debito** $= D_{t-1}(1+r) + (G_t - T_t)$.
6. **Rapporto debito/PIL** $= D_t / Y_t$; confronta con $D_{t-1}/Y_{t-1}$ per dire se cresce.

**Saldo primario per obiettivi sul rapporto debito/PIL** (da imporre $\Delta(D/Y) = \text{target}$):
- Stabilizzare ($\Delta = 0$): $\;G_t - T_t = -D_{t-1}(r-g)$.
- Ridurre di una quota $\delta$ ($\Delta = -\delta$): $\;G_t - T_t = -\delta\, Y_t - D_{t-1}(r-g)$.




<div style="height: 4em;"></div>

# 2. Scelte intertemporali di consumo

## 2.1 L'equilibrio del consumatore

Scelta tra un bene generico (quantità $q$, prezzo $p$) e la spesa in tutti gli altri beni $M$. **Tutto il reddito è consumato** (no risparmio).

**Problema d'ottimo:**
$$\max_{q,M}\; u(q) + u(M) \qquad \text{s.t.}\quad pq + M = Y^D, \qquad (u' > 0,\; u'' < 0)$$

**Lagrangiano** e **condizioni del prim'ordine** (necessarie e sufficienti):
$$\mathcal{L} = u(q) + u(M) + \lambda(Y^D - pq - M)$$
$$u'(q^\ast) = p\,u'(M^\ast), \qquad M^\ast = Y^D - p q^\ast$$

- $\lambda^\ast$ = **utilità marginale del reddito disponibile**.
- $C^\ast = p q^\ast$ (consumo del bene).
- **Statica comparata**: $\dfrac{dq^\ast}{dY^D} > 0$ (bene normale) e se $p\uparrow$ allora $q^\ast \downarrow$.


### Metodo per gli esercizi (utilità additive)

1. Scrivi $\mathcal{L} = u(q) + u(M) + \lambda(Y^D - pq - M)$.
2. FOC: $u'(q) = p\,\lambda$, $\;u'(M) = \lambda$, $\;$ vincolo.
3. Combina le prime due $\Rightarrow$ relazione $M = f(q)$; sostituisci nel vincolo.

> **Esempi risolti**
> - $U=\sqrt q + \sqrt M$, $p=2$, $Y^D=100$: da $\frac{1}{2\sqrt q}=2\cdot\frac{1}{2\sqrt M}$ segue $M=4q$; $2q+4q=100 \Rightarrow q^\ast=16.67,\; M^\ast=66.67$.
> - $U=\ln q + \ln M$, $p=1$, $Y^D=20$: $M=q \Rightarrow q^\ast=M^\ast=10$.
> - $U=\sqrt q + 2\sqrt M$, $p=3$, $Y^D=100$: $M=36q$; $39q=100 \Rightarrow q^\ast\approx2.56$. Se $Y^D\to120$, $q^\ast\approx3.08$: q è un **bene normale**.




## 2.2 Teoria Keynesiana del consumo (1936)

Consumo e risparmio dipendono dal **reddito disponibile corrente**.

**Funzione del consumo** e **del risparmio**:
$$C_t = \bar C + c\, Y_t^D \qquad\qquad S_t = Y_t^D - C_t = -\bar C + (1-c) Y_t^D$$

- $\bar C$ = consumo autonomo (consumo per reddito nullo).
- $c$ = **propensione marginale al consumo** (PMC), $0<c<1$. La **propensione marginale al risparmio** è $1-c$.
- **PMC**: $\dfrac{\partial C}{\partial Y^D} = c$. **Propensione media al consumo**: $\dfrac{C}{Y^D} = \dfrac{\bar C}{Y^D} + c$.

Note per i quiz: ridurre le imposte $\Rightarrow Y^D \uparrow \Rightarrow C \uparrow$; se $C = 8 + 0.75 Y^D$ e $\Delta Y^D = 20$ allora $\Delta C = 15$.


### Metodo esercizi

- Calcola $C$ e $S$ per i valori dati di $Y^D$; verifica che $\Delta S / \Delta Y^D = 1-c$.
- **Punto di risparmio nullo**: poni $C = Y^D$. Es. $C = 10 + 0.8Y^D \Rightarrow 10 = 0.2Y^D \Rightarrow Y^D = 50$.




## 2.3 Fisher e le scelte intertemporali (1930)

Il consumatore vive due periodi e sceglie $C_0, C_1$ massimizzando l'utilità intertemporale, dati redditi $Y_0, Y_1$ e tasso $r$.

**Vincolo di bilancio intertemporale** (valori attualizzati):
$$C_0 + \frac{C_1}{1+r} = Y_0 + \frac{Y_1}{1+r} \qquad\Longleftrightarrow\qquad C_1 = \underbrace{Y_0(1+r)+Y_1}_{\text{intercetta}} - \underbrace{(1+r)}_{\text{pendenza}} C_0$$

**Risparmio del primo periodo**: $\;S_0 = Y_0 - C_0$. ($S_0>0$ risparmia, $S_0<0$ si indebita.)

**Utilità** additiva e separabile: $\;U(C_0,C_1) = u(C_0) + \beta\, u(C_1)$, con $\beta \in (0,1]$ fattore di sconto soggettivo. Ipotesi: $u'>0$, $u''<0$, $u'''>0$ (**prudenza**).

**Condizione di Eulero** (ottimalità):
$$\boxed{\,u'(C_0^\ast) = (1+r)\,\beta\, u'(C_1^\ast)\,}$$

**Relazione tra $r$ e $\beta$:**

| Condizione | Risultato |
|---|---|
| $(1+r)\beta = 1$ | $C_0^\ast = C_1^\ast = \dfrac{Y_0(1+r)+Y_1}{2+r}$, $\;S_0^\ast=\dfrac{Y_0-Y_1}{2+r}$ |
| $(1+r)\beta > 1$ | $u'(C_0^\ast)>u'(C_1^\ast) \Rightarrow C_0^\ast < C_1^\ast$ |
| $(1+r)\beta < 1$ | $u'(C_0^\ast)<u'(C_1^\ast) \Rightarrow C_0^\ast > C_1^\ast$ |

**Statica comparata** (segni):
- $Y_0 \uparrow$: $C_0\uparrow$, $C_1\uparrow$, $S_0\uparrow$.
- $Y_1 \uparrow$: $C_0\uparrow$, $C_1\uparrow$, **$S_0\downarrow$**.
- $\beta \uparrow$: **$C_0\downarrow$**, $C_1\uparrow$, $S_0\uparrow$.
- Nel grafico $C_1$–$C_0$ la retta di bilancio ha **pendenza $-(1+r)$**; un aumento di $Y_0$ la **trasla** verso destra.

**Effetto reddito ed effetto sostituzione** (aumento di $r$):

| | Effetto reddito | Effetto sostituzione | Totale su $C_0$ |
|---|---|---|---|
| Risparmiatore | $>0$ | $<0$ | **ambiguo** |
| Debitore | $<0$ | $<0$ | **$<0$** (riduce $C_0$) |

**Reddito futuro incerto / risparmio precauzionale**: se $\tilde Y_1$ ha varianza $\sigma_Y^2$, allora $\text{Var}[\tilde C_1] = \sigma_Y^2$. Con $u''' > 0$ (prudenza), un aumento di $\sigma_Y^2$ induce a **consumare meno oggi e risparmiare di più** (risparmio precauzionale). Approssimazione di Taylor della condizione di Eulero:
$$u'(C_0^\ast) \approx \beta(1+r)\Big[u'(\mathbb E[\tilde C_1^\ast]) + \tfrac{1}{2}u'''(\mathbb E[\tilde C_1^\ast])\,\sigma_Y^2\Big]$$


### Metodo esercizi (caso log e caso radice)

1. **Eulero** $\Rightarrow$ relazione $C_1 = \phi\, C_0$ (con $\phi = (1+r)\beta$ per utilità **log**; per $U=\sqrt{C_0}+\beta\sqrt{C_1}$ si ottiene $\sqrt{C_1} = (1+r)\beta\sqrt{C_0}$, cioè $C_1 = [(1+r)\beta]^2 C_0$).
2. Calcola il VA del reddito $= Y_0 + \frac{Y_1}{1+r}$.
3. Sostituisci $C_1$ nel vincolo $C_0 + \frac{C_1}{1+r} = \text{VA}$ e risolvi per $C_0^\ast$, poi $C_1^\ast$.
4. $S_0^\ast = Y_0 - C_0^\ast$.

> **Esempio (log):** $Y_0=100$, $Y_1=120$, $r=0.2$, $\beta=1$. Eulero: $C_1 = 1.2\,C_0$. VA $=200$. $C_0 + C_0 = 200 \Rightarrow C_0^\ast=100$, $C_1^\ast=120$, $S_0^\ast=0$.
> **Esempio (radice):** $Y_0=90$, $Y_1=90$, $r=0.5$, $\beta=1$. $\sqrt{C_1}=1.5\sqrt{C_0}\Rightarrow C_1=2.25C_0$. VA $=150$. $2.5C_0=150\Rightarrow C_0^\ast=60$, $C_1^\ast=135$, $S_0^\ast=30$. Con $r=1$: $C_1=4C_0$, $C_0^\ast=45$, $S_0^\ast=45$ (più $r$ ⟹ più risparmio, si posticipa il consumo).




## 2.4 Modigliani — Ipotesi del ciclo di vita (1954)

Gli individui **livellano il consumo** lungo la vita: risparmiano durante gli anni lavorativi e **decumulano** durante la pensione.

Modello semplificato: vita residua $E$ periodi, di cui $L$ di lavoro (reddito $Y^D$ costante) e $E-L$ di pensione (reddito nullo); tasso $r = 0$.

**Consumo annuo** e **risparmio**:
$$C_t = \frac{L\, Y^D}{E} \qquad\qquad S_t = Y_t^D - C_t, \quad\text{con } Y_t^D \in \{0,\, Y^D\}$$

- Durante il **lavoro**: $S_t = Y^D - C_t > 0$ (accumula).
- Durante la **pensione**: $S_t = 0 - C_t = -C_t < 0$ (decumula).
- Ricchezza massima a fine lavoro: $A_L = L\cdot(Y^D - C_t)$, poi decresce fino a $A_E = 0$.

Quiz: $E\uparrow$ (a parità di $L, Y^D$) $\Rightarrow C_t \downarrow$; $E\downarrow \Rightarrow C_t \uparrow$; se $L=6, E=12 \Rightarrow C_t = \frac12 Y^D$. Politiche che aumentano le pensioni attese $\Rightarrow$ **consumo corrente $\uparrow$**.

> **Esempio:** $E=12$, $L=8$, $Y^D=90$. $C_t = \frac{8\cdot90}{12}=60$. Lavoro: $S=30$; pensione: $S=-60$. Fine lavoro: $A_8 = 8\cdot30 = 240$.




## 2.5 Friedman — Ipotesi del reddito permanente (1957)

Il consumo dipende dal **reddito permanente** (aspettative di lungo periodo), non dal reddito corrente.

Il reddito disponibile si scompone in permanente + transitorio:
$$Y_t^D = \bar Y^D + \tilde y_t^D, \qquad \mathbb E[\tilde y_t^D] = 0$$

**Consumo** e **risparmio**:
$$C_t = b\, \bar Y^D \qquad\qquad S_t = Y_t^D - C_t = (1-b)\bar Y^D + \tilde y_t^D$$

- $b$ = PMC rispetto al **reddito permanente**. Il consumo **è costante** (dipende solo da $\bar Y^D$).
- Il risparmio **assorbe** le fluttuazioni: se $\tilde y_t^D > 0$ (reddito corrente > permanente) $\Rightarrow S_t \uparrow$; se $\tilde y_t^D < 0 \Rightarrow S_t \downarrow$.
- Politiche che alzano il reddito permanente $\Rightarrow$ consumo presente $\uparrow$.

> **Esempio:** $\bar Y^D=120$, $b=0.75$, $\tilde y_1^D=30$. $C_1 = 0.75\cdot120 = 90$; $Y_1^D = 150$; $S_1 = 60$.




## 2.6 Considerazioni conclusive — confronto tra teorie

| Teoria | Consumo | Risparmio | Pianificazione intertemporale |
|---|---|---|---|
| **Keynes** | Varia col reddito disponibile **corrente** | Residuo del reddito non consumato | Non centrale |
| **Modigliani** | **Stabile** tra le fasi di vita | Trasferisce risorse tra fasi di vita | Centrale |
| **Friedman** | Risponde al reddito **permanente** | Stabilizza il consumo | Centrale |




<div style="height: 4em;"></div>

# 3. Markowitz e le scelte di portafoglio

## 3.1 Principi fondamentali

Obiettivo: allocare la ricchezza tra $N$ asset per **massimizzare il rendimento atteso dato il rischio** (o minimizzare il rischio dato il rendimento).

**Singolo titolo** $i$:
$$r_i = \mathbb E[\tilde r_i], \qquad \sigma_i^2 = \mathbb E[(\tilde r_i - r_i)^2], \qquad \sigma_i = \sqrt{\sigma_i^2}$$

**Vettori e matrici:**
- Vettore rendimenti $r$, vettore pesi $x$, con $\;\iota^T x = \sum_i x_i = 1$.
- Matrice varianze-covarianze $\Sigma$, con $\sigma_{ij} = \rho_{ij}\,\sigma_i\,\sigma_j$.
- $x_i \ge 0$ = posizione **lunga**; $x_i < 0$ = posizione **corta** (short/leva).

**Leva finanziaria** (norma $L^1$): $\; \|x\|_1 = \sum_i \|x_i\| = \ell$. Se $\ell = 1$ portafoglio **long-only**; se $\ell > 1$ ci sono posizioni corte.

**Portafoglio:**
$$r_p = x^T r = \sum_i x_i r_i, \qquad \sigma_p^2 = x^T \Sigma x = \sum_i\sum_j x_i x_j \sigma_{ij}, \qquad \sigma_p = \sqrt{\sigma_p^2}$$

**Numero di termini**: con $N$ asset, $\Sigma$ ($N\times N$) contiene $N$ varianze e $\frac{N(N-1)}{2}$ covarianze distinte (nella somma della varianza compaiono $N(N-1)$ covarianze, uguali a coppie). Es. $N=20$: 20 varianze e 380 covarianze (=190 distinte).




## 3.2 Portafoglio di 2 titoli

$$r_p = x_1 r_1 + x_2 r_2, \qquad \sigma_p^2 = (x_1\sigma_1)^2 + (x_2\sigma_2)^2 + 2 x_1 x_2 \sigma_1\sigma_2\rho_{12}$$

Casi speciali (long-only, $\sigma_1 < \sigma_2$):

**$\rho_{12} = 1$** (correlazione positiva perfetta):
$$\sigma_p = x_1\sigma_1 + x_2\sigma_2 \quad(\text{media ponderata delle volatilità})$$
Minimo rischio: tutto nel titolo meno rischioso, $x_1^m = 1$, $\sigma_p^m = \sigma_1$. **Non si può azzerare** la varianza.

**$\rho_{12} = -1$** (correlazione negativa perfetta):
$$\sigma_p = |x_1\sigma_1 - x_2\sigma_2|$$
Si può **azzerare** la varianza scegliendo:
$$x_1^m = \frac{\sigma_2}{\sigma_1+\sigma_2}, \qquad x_2^m = \frac{\sigma_1}{\sigma_1+\sigma_2} \quad\Longrightarrow\quad \sigma_p^m = 0$$

**$-1 < \rho_{12} < 1$** (caso generale): i pesi di minima varianza sono
$$x_1^m = \frac{\sigma_2^2 - \sigma_{12}}{\sigma_1^2 + \sigma_2^2 - 2\sigma_{12}}, \qquad x_2^m = 1 - x_1^m \qquad (\sigma_{12}=\rho_{12}\sigma_1\sigma_2)$$

**Principio di diversificazione** (chiave per i quiz):
- A parità di pesi e varianze, se $\rho_{12} \downarrow$ allora $\sigma_p \downarrow$ (e viceversa se $\rho_{12}\uparrow$ allora $\sigma_p\uparrow$).
- La varianza del portafoglio è **minima** quando $\rho_{12} = -1$.
- Con $\rho_{12} < 1$, il portafoglio può avere $\sigma_P < \sigma_A$ (rischio minore di entrambi); con $\rho_{12} = 1$ risulta sempre $\sigma_A \le \sigma_P \le \sigma_B$.


### Metodo esercizi (2 titoli)

1. $r_p = x_1 r_1 + x_2 r_2$.
2. $\sigma_p^2 = (x_1\sigma_1)^2 + (x_2\sigma_2)^2 + 2x_1x_2\rho_{12}\sigma_1\sigma_2$, poi $\sigma_p = \sqrt{\sigma_p^2}$.
3. Minima varianza: usa la formula di $x_1^m$ (o, se $\rho=-1$, $x_1^m = \frac{\sigma_2}{\sigma_1+\sigma_2}$).

> **Esempio:** $\sigma_1=0.1$, $\sigma_2=0.15$, $\rho_{12}=0.4$, $r_1=0.07$, $r_2=0.11$.
> Equally weighted: $r_p = 0.09$, $\sigma_p^2 = 0.0111 \Rightarrow \sigma_p = 0.1055$.
> Minima varianza: $x_1^m = 0.8049$, $x_2^m = 0.1951$, $\sigma_p^m = 0.0960$.




## 3.3 La scelta ottimale di portafoglio

**Funzione di utilità media-varianza:**
$$U(r_p, \sigma_p^2) = r_p - \frac{\gamma}{2}\sigma_p^2 = x^T r - \frac{\gamma}{2}x^T\Sigma x, \qquad \gamma > 0 \text{ (avversione al rischio)}$$

**Costanti notevoli:** $\;A = r^T\Sigma^{-1}r$, $\;B = r^T\Sigma^{-1}\iota = \iota^T\Sigma^{-1}r$, $\;C = \iota^T\Sigma^{-1}\iota$.


### Formulazione 1 — massimizzazione dell'utilità

$$\max_x\; x^T r - \frac{\gamma}{2}x^T\Sigma x \quad \text{s.t.}\quad x^T\iota = 1$$
$$\mathcal{L} = x^T r - \frac{\gamma}{2}x^T\Sigma x + \lambda(1 - x^T\iota)$$

FOC: $\;r - \gamma\Sigma x^\ast - \lambda^\ast\iota = 0$. Soluzione:
$$\lambda^\ast = \frac{B-\gamma}{C}, \qquad x^\ast = \Sigma^{-1}\!\left(\frac{1}{\gamma}r + \frac{\gamma - B}{\gamma C}\iota\right)$$


### Formulazione 2 — minimizzazione della varianza con rendimento target $k$

$$\min_x\; \frac{1}{2}x^T\Sigma x \quad \text{s.t.}\quad x^T r = k,\;\; x^T\iota = 1$$
$$\mathcal{L} = \frac{1}{2}x^T\Sigma x + \lambda_1(k - x^T r) + \lambda_2(1 - x^T\iota)$$

Soluzione:
$$\lambda_1^\ast = \frac{Ck - B}{AC - B^2}, \qquad \lambda_2^\ast = \frac{A - Bk}{AC - B^2}, \qquad x^\ast = \Sigma^{-1}\!\left(\frac{Ck-B}{AC-B^2}r + \frac{A-Bk}{AC-B^2}\iota\right)$$


### Equivalenza tra le due formulazioni

$$k = \frac{AC - B^2}{C\gamma} + \frac{B}{C} \qquad\Longleftrightarrow\qquad \gamma = \frac{AC - B^2}{Ck - B}$$

Interpretazioni:
- La curva $k$–$\gamma$ è **decrescente**: $\gamma \uparrow \Rightarrow k \downarrow$ (più avversione al rischio, minor rendimento target).
- Se $\gamma \to 0$ (avversione nulla) $\Rightarrow k \to +\infty$.
- Se $B^2 \approx AC$, il denominatore $AC-B^2$ è piccolo $\Rightarrow$ pesi **instabili**.


### Metodo esercizio (con matrice $\Sigma$)

1. Calcola i **pesi** dalle quote investite: $x_i = \frac{\text{valore}_i}{\text{totale}}$.
2. $r_p = x^T r$.
3. $\sigma_p^2 = x^T\Sigma x$ (svolgi la forma quadratica), poi $\sigma_p = \sqrt{\sigma_p^2}$.

> **Esempio:** Equity 100k, Bond 50k, Commodity 50k $\Rightarrow x = (0.5,\,0.25,\,0.25)$. Con $r=(0.20,0.10,0.10)$: $r_p = 0.15$; $\sigma_p^2 = x^T\Sigma x = 0.0153 \Rightarrow \sigma_p = 0.1237$.


## 3.4 Costi di transazione e vincoli aggiuntivi

**Con costi di transazione** proporzionali alle variazioni dei pesi:
$$\min_x\; \frac{1}{2}x^T\Sigma x + \theta\|\Delta x\|_1 \quad \text{s.t.}\quad x^T r = k,\;\; x^T\iota = 1$$
dove $\Delta x = x - x_0$ (variazione rispetto al portafoglio precedente) e $\theta$ è il costo unitario.
- $\theta = 0 \Rightarrow$ si torna al problema classico di **Markowitz**.
- $\theta \uparrow \Rightarrow$ **riduce** le variazioni nei pesi (penalizza il turnover).

**Vincoli aggiuntivi tipici:**
- Non negatività (long-only): $\;x_i \ge 0$.
- Boundary per singolo asset: $\;l_i \le x_i \le u_i$ (limita la quota di ciascun titolo).
- Settore: $\;\sum_{i\in S_j} x_i \le U_j$ (limita l'esposizione a un settore).
- Leva massima: $\;\|w\|_1 \le \ell_{\max}$.
- Tracking error (deviazione dal benchmark): $\;TE = \sqrt{x^T\Sigma x - 2x^T\Sigma x_b + x_b^T\Sigma x_b} \le TE_{\max}$.

Note per i quiz:
- Con vincoli complessi **spesso non esiste** soluzione analitica $\Rightarrow$ **metodi numerici**. Senza costi né vincoli il problema ha **soluzione chiusa**.
- Il tracking error massimo $\downarrow \Rightarrow$ portafoglio più simile al benchmark.
- Con vincoli long-only + settoriali, il portafoglio ottimo può trovarsi su un punto **dominato** rispetto al problema libero.


### Metodo esercizio (leva e costi)

1. **Leva**: $\|x\|_1 = \sum_i \|x_i\|$; verifica $\|x\|_1 \le \ell_{\max}$.
2. $\Delta x = x^\ast - x_0$; costo $= \theta\|\Delta x\|_1 = \theta\sum_i\|\Delta x_i\|$.
3. (Se richiesto) $r_p = x^T r$ e $\sigma_p^2 = x^T\Sigma x$.

> **Esempio:** $x_0=(0.3,0.3,0.2,0.1,0.1)$, $x^\ast=(0.4,0.4,0.1,0.05,0.05)$, $\theta=0.02$, $\ell_{\max}=1.5$.
> $\|x^\ast\|_1 = 1.0 < 1.5$ ✓. $\Delta x=(0.1,0.1,-0.1,-0.05,-0.05)$, $\|\Delta x\|_1 = 0.4$, costo $= 0.02\cdot0.4 = 0.008$.




<div style="height: 4em;"></div>

# 4. Sistemi pensionistici

## 4.1 Aspetti definitori e tassonomici

**Sistema pensionistico**: istituzione che definisce **finanziamento** e **calcolo** delle prestazioni pensionistiche a favore delle generazioni non attive.

**Tipi di prestazione**: vecchiaia/anzianità, invalidità, reversibilità (legami familiari con deceduti), sociale (assenza di reddito oltre l'età pensionabile). *(La "pensione universitaria" NON esiste — trappola dei quiz.)*

**I pilastri:**

| Pilastro | Nome | Descrizione |
|---|---|---|
| **Zero** | Pensione sociale | Pensione minima garantita, finanziata dalle **tasse** (assegno sociale) |
| **Primo** | Pensione pubblica | Sistema **obbligatorio** gestito dallo Stato, finanziato dai contributi (INPS) |
| **Secondo** | Previdenza compl. **collettiva** | Previdenza aziendale/collettiva, cofinanziata dai datori di lavoro (fondi pensione) |
| **Terzo** | Previdenza compl. **individuale** | Risparmio privato volontario con incentivi fiscali (PIP) |
| **Quarto** | Risorse informali | Fonti aggiuntive (affitto seconda casa, investimenti, supporto familiare) |




## 4.2 Pensione pubblica

**Due funzioni**: (1) previdenziale/assicurativa (copre il rischio di riduzione del reddito), (2) assistenziale (garantisce un reddito minimo). Servono **gestione pubblica** e **partecipazione obbligatoria**.

**Due dimensioni di funzionamento:**

*Modalità di finanziamento:*
- **Capitalizzazione** (trasferimento **intertemporale**): i contributi versati oggi finanziano la **futura pensione dello stesso individuo**. Rendimento legato al tasso di mercato $r$.
- **Ripartizione** (trasferimento **intergenerazionale**): i contributi della generazione attiva finanziano le **pensioni correnti** dei pensionati. Rendimento legato alla crescita del monte salariale $g$.

*Metodo di calcolo:*
- **Contribuzione definita** (metodo contributivo): la pensione dipende dai contributi versati e dal rendimento della gestione. Variabile endogena = **pensione erogata**.
- **Prestazione definita** (metodo retributivo): la pensione è una quota della retribuzione vicino al pensionamento. Variabile endogena = **contributo versato**.

**Parametri del modello a due periodi / due generazioni:** $a$ = aliquota di contribuzione, $i$ = rendimento della gestione, $r$ = tasso di mercato, $g$ = crescita del monte salariale ($g = w + n + wn$, con $w$ crescita salari e $n$ crescita popolazione), $k$ = aliquota di rendimento (parte del salario che diventa pensione).


### Le quattro combinazioni — tabella riassuntiva

| Sistema | Condizione di equilibrio | Rendimento | Tasso di sostituzione | Aliquota di equilibrio |
|---|---|---|---|---|
| **Capitalizzazione + contrib. definita** | $i = r$ | $r$ | $a(1+r)$ | — |
| **Capitalizzazione + prest. definita** | $a = \dfrac{k}{1+r}$ | $r$ | $k$ | $a = \dfrac{k}{1+r}$ |
| **Ripartizione + contrib. definita** | $i = g$ | $g$ | $a(1+g)$ | — |
| **Ripartizione + prest. definita** | $a = \dfrac{k}{1+g}$ | $g$ | $k$ | $a = \dfrac{k}{1+g}$ |

> **Regole mnemoniche:** capitalizzazione → rendimento $r$; ripartizione → rendimento $g$. Contribuzione definita → tasso di sostituzione $= a(1+\text{rend.})$; prestazione definita → tasso di sostituzione $= k$.

**Tasso di sostituzione**: rapporto tra la **prima pensione** e l'**ultima retribuzione**.

**Effetti di transizione:**
- *Effetto prima generazione* (introduzione ripartizione): la prima generazione anziana riceve la pensione senza aver versato contributi → rendimento infinito/indeterminato.
- *Effetto ultima generazione* (passaggio ripartizione → capitalizzazione): **doppio onere** — paga le pensioni correnti E versa per la propria.

**Rischi** e chi colpiscono:

| Rischio | Descrizione |
|---|---|
| Finanziario | Rendimenti degli investimenti inadeguati (colpisce soprattutto la **capitalizzazione**) |
| Salariale | Salari crescono più lentamente (colpisce la **ripartizione**) |
| Demografico | Cambiamenti nella struttura della popolazione (colpisce la **ripartizione**) |
| Politico | Cambiamenti delle politiche pensionistiche |
| Inflazionistico | Erosione del potere d'acquisto delle pensioni |

> Nei sistemi a **contribuzione definita** i rischi colpiscono i **pensionati**; nella **prestazione definita** colpiscono la **generazione attiva**. Un aumento dell'aspettativa di vita → aumento del rischio di sostenibilità.


### Modello multiperiodale (contribuzione definita)

Individuo che lavora $L$ periodi e resta in pensione $E$ periodi (prima pensione in $t=0$). Si eguaglia il **montante contributivo** $M$ al **valore attuale delle prestazioni** $V$:
$$M = \sum_{\tau=1}^{L} aW_{-\tau}(1+i)^{\tau}, \qquad V = P\sum_{t=0}^{E-1}(1+i)^{-t} = P\cdot v, \qquad P = \frac{M}{v}$$

**Prestazione definita**: $\;P = k W_p = \beta L W_p$, dove $W_p$ è la retribuzione pensionabile (ultima retribuzione, o media rivalutata delle ultime $T$ / di tutte le retribuzioni).


### Il sistema italiano (in breve)

Riforme chiave: **Amato 1992**, **Dini 1995** (contributivo pro-rata), **Maroni 2004** (TFR alla previdenza compl.), **Fornero 2011** (contributivo per tutti, età legata all'aspettativa di vita). Poi Quota 100/102/103, Opzione Donna, APE.
Oggi: sistema a **ripartizione + contribuzione definita**; vecchiaia a 67 anni con 20 di contributi; vigilanza sulla previdenza pubblica INPS.
Criticità: invecchiamento, bassa natalità, aspettativa di vita crescente → riforme parametriche (ridurre pensione pro-capite; ridurre rapporto percettori/contribuenti).




## 4.3 Previdenza complementare

Rappresenta **secondo e terzo pilastro**. Serve a integrare il gap dovuto all'indebolimento del primo pilastro. Funziona a **capitalizzazione**, con prestazione legata ai contributi versati. Offre **vantaggi fiscali** in ogni fase (deducibilità dei contributi, aliquota agevolata su rendimenti e prestazione finale).

**Secondo pilastro (adesione collettiva):**
- **Fondi negoziali/chiusi**: riservati a categorie, istituiti da contrattazione collettiva.
- **Fondi aperti ad adesione collettiva**: istituiti da banche, assicurazioni, SGR e SIM.
- **Fondi preesistenti**: esistevano prima della normativa.

**Terzo pilastro (adesione individuale):**
- **Fondi aperti ad adesione individuale** (banche, assicurazioni, SGR, SIM).
- **PIP** (Piani Individuali Pensionistici), istituiti da **imprese di assicurazione**.

**Fonti di finanziamento**: contributo del lavoratore + contributo del datore + **TFR maturando**.

**Comparti di gestione** (scelti in base a orizzonte temporale e propensione al rischio): azionario, bilanciato (azioni + obbligazioni), obbligazionario, **garantito** (garantisce la restituzione del capitale versato).

**Erogazione**: rendita vitalizia o parte in capitale + rendimento + benefici fiscali. **Vigilanza: COVIP.**


### Calcolo della prestazione periodica

Si versa $B$ per $L$ periodi (da $t=0$) e si riceve $P$ per $E$ periodi (da $t=L$). Si eguaglia il VA dei versamenti al VA delle prestazioni:
$$\nu_L = \left(1+\frac{1}{r}\right)\!\left[1 - \frac{1}{(1+r)^{L-1}}\right], \qquad \nu_E = \left(1+\frac{1}{r}\right)\!\left[1 - \frac{1}{(1+r)^{E-1}}\right]\frac{1}{(1+r)^{L}}$$
$$V_L = B\,\nu_L, \qquad V_E = P\,\nu_E, \qquad \boxed{P = \frac{B\,\nu_L}{\nu_E}} \quad\text{oppure}\quad \boxed{B = \frac{P\,\nu_E}{\nu_L}}$$

> **Esempio:** $B=1200$, $L=40$, $r=0.10$, $E=20$. $V_L = 12908.35$; $V_E = 0.2069\,P$; $P = 12908.35 / 0.2069 = 62384.11$.
> **Esempio inverso:** rendita desiderata $P=24000$ per $E=20$ da $t=40$, $r=0.10$, $L=40$. $\nu_L = 10.76$; $V_E = 4966.01$; $B = 4966.01 / 10.76 = 461.66$.




## 4.4 Risorse informali (quarto pilastro)

Meccanismi di supporto **non istituzionalizzati** che integrano reddito/benessere in vecchiaia, cruciali quando primo e secondo pilastro sono insufficienti. Esempi: supporto familiare, risparmi personali e proprietà (es. casa di proprietà), lavoro informale, comunità/reti sociali/ONG.

I **piani di investimento non istituzionalizzati** funzionano in modo **analogo a un sistema a capitalizzazione**: stesse formule di $\nu_L$, $\nu_E$ viste sopra, con $B = \frac{P\,\nu_E}{\nu_L}$.




<div style="height: 4em;"></div>

# 5. Formulario riassuntivo

**Concetti e misure (micro):**
$$Y_t = A_{t-1}r + W_t, \quad Y_t^D = Y_t - T_t, \quad S_t = Y_t^D - C_t, \quad A_t = A_{t-1} + S_t$$

**Macro:**
$$Y_t = C_t + I_t + G_t + (X_t - M_t), \quad S_t = S_t^{Pr} + (T_t - G_t) = I_t + (X_t - M_t)$$
$$D_t = D_{t-1}(1+r) + (G_t - T_t), \quad \frac{D_t}{Y_t} = \frac{D_{t-1}(1+r) + G_t - T_t}{Y_{t-1}(1+g)}$$

**Equilibrio del consumatore:** $\;u'(q^\ast) = p\,u'(M^\ast)$, $\;C^\ast = pq^\ast$.

**Keynes:** $\;C_t = \bar C + c\,Y_t^D$, $\;S_t = -\bar C + (1-c)Y_t^D$.

**Fisher:** $\;C_0 + \frac{C_1}{1+r} = Y_0 + \frac{Y_1}{1+r}$, $\;$ Eulero: $\;u'(C_0^\ast) = (1+r)\beta u'(C_1^\ast)$, $\;S_0 = Y_0 - C_0$.

**Modigliani:** $\;C_t = \frac{L\,Y^D}{E}$.

**Friedman:** $\;C_t = b\,\bar Y^D$, $\;Y_t^D = \bar Y^D + \tilde y_t^D$.

**Markowitz (2 titoli):**
$$r_p = x_1r_1 + x_2r_2, \quad \sigma_p^2 = (x_1\sigma_1)^2 + (x_2\sigma_2)^2 + 2x_1x_2\rho_{12}\sigma_1\sigma_2$$
$$x_1^m = \frac{\sigma_2^2 - \sigma_{12}}{\sigma_1^2 + \sigma_2^2 - 2\sigma_{12}} \quad(\rho=-1:\; x_1^m = \tfrac{\sigma_2}{\sigma_1+\sigma_2},\; \sigma_p^m=0)$$

**Markowitz (scelta ottimale):** $\;U = r_p - \frac{\gamma}{2}\sigma_p^2$; $\;A=r^T\Sigma^{-1}r$, $B=r^T\Sigma^{-1}\iota$, $C=\iota^T\Sigma^{-1}\iota$; $\;k = \frac{AC-B^2}{C\gamma}+\frac{B}{C}$.

**Pensioni (equilibrio):**

| | Contribuzione definita | Prestazione definita |
|---|---|---|
| Capitalizzazione | $i=r$; TS $=a(1+r)$ | $a=\frac{k}{1+r}$; TS $=k$ |
| Ripartizione | $i=g$; TS $=a(1+g)$ | $a=\frac{k}{1+g}$; TS $=k$ |

**Previdenza complementare:** $\;P = \frac{B\,\nu_L}{\nu_E}$, con $\nu_L, \nu_E$ definiti sopra.


### Checklist finale prima dell'esame

- [ ] So ricostruire la **tabella multi-periodo** micro (ordine: $Y, T, Y^D, C, S, A$).
- [ ] So calcolare **saldo primario, risparmio privato/nazionale, debito e rapporto debito/PIL** e dire se cresce.
- [ ] So impostare **Lagrangiano + FOC** per equilibrio del consumatore e per Markowitz.
- [ ] Conosco la **condizione di Eulero** e la statica comparata di Fisher (segni di $Y_0, Y_1, \beta, r$).
- [ ] So distinguere **Keynes / Modigliani / Friedman** (consumo, risparmio, pianificazione).
- [ ] So calcolare **rendimento, varianza e minima varianza** di un portafoglio (2 titoli e forma matriciale).
- [ ] Ho memorizzato la **tabella 2×2 dei sistemi pensionistici** (equilibrio, rendimento, TS).
- [ ] So applicare le formule di **$\nu_L, \nu_E$** per versamenti e prestazioni.
