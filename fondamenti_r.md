# R — fondamenti del linguaggio

R è un linguaggio e ambiente per il calcolo statistico e la produzione di grafici, sviluppato per l'analisi dei dati. È interpretato, orientato ai vettori e dispone di un vastissimo ecosistema di pacchetti (CRAN, Bioconductor).




## 1. Fondamenti


### Assegnazione e operazioni di base

In R l'operatore di assegnazione idiomatico è `<-` (funziona anche `=`).

```r
x <- 5
y = 3
z <- x + y      # 8

# Operazioni aritmetiche
7 %/% 2          # divisione intera -> 3
7 %% 2           # modulo -> 1
2 ^ 10           # potenza -> 1024
```


### Tipi di dato principali

R possiede quattro tipi atomici fondamentali: `numeric` (double), `integer`, `character`, `logical`, oltre a `complex`.

```r
n  <- 3.14          # numeric
i  <- 5L            # integer (suffisso L)
s  <- "ciao"        # character
b  <- TRUE          # logical
cx <- 2 + 3i        # complex

class(n)            # "numeric"
typeof(i)           # "integer"
is.character(s)     # TRUE
```

Un concetto peculiare di R è `NA` (dato mancante), distinto da `NULL` (assenza di oggetto) e `NaN` (Not a Number).




## 2. Strutture dati


### Vettori

Il vettore è la struttura fondamentale: R è "vettorializzato", cioè le operazioni si applicano elemento per elemento.

```r
v <- c(2, 4, 6, 8, 10)
v * 2               # 4 8 12 16 20
v[2]                # 4  (indicizzazione da 1!)
v[c(1, 3)]          # 2 6
v[v > 5]            # 6 8 10 (indicizzazione logica)
seq(0, 1, by = 0.25)
rep(c(1, 2), times = 3)
```

> Nota: in R gli indici partono da **1**, non da 0.


### Matrici

```r
M <- matrix(1:6, nrow = 2, ncol = 3)
M %*% t(M)          # prodotto matriciale
solve(A)            # inversa di A
dim(M)              # 2 3
```

Il prodotto matriciale $C = A B$ ha elementi:

$$
c_{ij} = \sum_{k=1}^{n} a_{ik}\, b_{kj}
$$


### Liste e data frame

La lista può contenere elementi eterogenei; il `data.frame` è la struttura tabellare per eccellenza (colonne di tipi diversi, stessa lunghezza).

```r
lst <- list(nome = "Anna", eta = 30, voti = c(28, 30, 25))
lst$voti            # accesso per nome

df <- data.frame(
  nome = c("Anna", "Bruno"),
  eta  = c(30, 25),
  stringsAsFactors = FALSE
)
df$eta              # colonna
df[df$eta > 26, ]   # filtro per riga
str(df)             # struttura
```




## 3. Controllo di flusso e funzioni

```r
# Condizioni
if (x > 0) {
  print("positivo")
} else {
  print("non positivo")
}

# Cicli
for (i in 1:5) print(i^2)

while (x > 0) x <- x - 1

# Definizione di funzione
media_geom <- function(x) {
  exp(mean(log(x)))
}
media_geom(c(1, 4, 16))   # 4
```

La media geometrica calcolata sopra corrisponde a:

$$
G = \left( \prod_{i=1}^{n} x_i \right)^{1/n} = \exp\!\left( \frac{1}{n} \sum_{i=1}^{n} \ln x_i \right)
$$


### La famiglia `apply`

Al posto dei cicli espliciti, R predilige funzioni di ordine superiore.

```r
sapply(1:5, function(k) k^2)      # vettore: 1 4 9 16 25
lapply(1:3, sqrt)                  # lista
apply(M, 1, sum)                   # somma per riga (MARGIN = 1)
vapply(x, is.numeric, logical(1))  # con tipo di ritorno specificato
```




## 4. Statistica descrittiva

R nasce per la statistica; le funzioni di base sono immediate.

```r
x <- c(4, 8, 15, 16, 23, 42)
mean(x)      # media
median(x)    # mediana
sd(x)        # deviazione standard campionaria
var(x)       # varianza
quantile(x)  # quartili
summary(x)   # riepilogo completo
```

**Media aritmetica:**

$$
\bar{x} = \frac{1}{n} \sum_{i=1}^{n} x_i
$$

**Varianza campionaria** (denominatore $n-1$, correzione di Bessel):

$$
s^2 = \frac{1}{n-1} \sum_{i=1}^{n} (x_i - \bar{x})^2
$$

**Coefficiente di correlazione di Pearson:**

$$
r_{xy} = \frac{\displaystyle\sum_{i=1}^{n} (x_i - \bar{x})(y_i - \bar{y})}
{\sqrt{\displaystyle\sum_{i=1}^{n} (x_i - \bar{x})^2}\;\sqrt{\displaystyle\sum_{i=1}^{n} (y_i - \bar{y})^2}}
$$

```r
cor(x, y)             # correlazione di Pearson
cor(x, y, method = "spearman")
```




## 5. Distribuzioni di probabilità

Per ogni distribuzione R offre quattro funzioni con prefissi `d`, `p`, `q`, `r` (densità, ripartizione, quantile, generazione casuale).

```r
dnorm(0)              # densità della normale in 0
pnorm(1.96)           # P(Z <= 1.96) ~ 0.975
qnorm(0.975)          # quantile ~ 1.96
rnorm(100, mean = 0, sd = 1)   # 100 valori casuali
```

La densità della distribuzione normale $\mathcal{N}(\mu, \sigma^2)$ è:

$$
f(x) = \frac{1}{\sigma \sqrt{2\pi}} \, \exp\!\left( -\frac{(x - \mu)^2}{2\sigma^2} \right)
$$

Altre distribuzioni comuni: `binom`, `pois`, `unif`, `exp`, `t`, `chisq`, `f`.




## 6. Regressione lineare

Il modello lineare è uno strumento centrale in R, gestito da `lm()`.

Il modello di regressione multipla si scrive:

$$
y_i = \beta_0 + \beta_1 x_{i1} + \dots + \beta_p x_{ip} + \varepsilon_i,
\qquad \varepsilon_i \sim \mathcal{N}(0, \sigma^2)
$$

La stima ai minimi quadrati ordinari (OLS) in forma matriciale è:

$$
\hat{\boldsymbol{\beta}} = (\mathbf{X}^\top \mathbf{X})^{-1} \mathbf{X}^\top \mathbf{y}
$$

```r
modello <- lm(mpg ~ wt + hp, data = mtcars)
summary(modello)      # coefficienti, R^2, p-value
coef(modello)         # stime beta
predict(modello, newdata = data.frame(wt = 3, hp = 120))
residuals(modello)
confint(modello)      # intervalli di confidenza
```

Il coefficiente di determinazione misura la bontà di adattamento:

$$
R^2 = 1 - \frac{\sum_{i=1}^{n} (y_i - \hat{y}_i)^2}{\sum_{i=1}^{n} (y_i - \bar{y})^2}
$$




## 7. Grafici

R dispone di un sistema grafico "base" e del pacchetto `ggplot2` (grammar of graphics).

```r
# Grafica base
plot(mtcars$wt, mtcars$mpg,
     xlab = "Peso", ylab = "Consumo",
     main = "Consumo vs Peso", pch = 19)
abline(lm(mpg ~ wt, data = mtcars), col = "red")
hist(mtcars$mpg, breaks = 10)
boxplot(mpg ~ cyl, data = mtcars)
```

```r
# ggplot2
library(ggplot2)
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point(size = 2) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(title = "Consumo vs Peso", color = "Cilindri") +
  theme_minimal()
```




## 8. L'ecosistema tidyverse

Il `tidyverse` è una raccolta di pacchetti per la manipolazione moderna dei dati. L'operatore pipe `|>` (nativo da R 4.1) o `%>%` (magrittr) concatena le operazioni.

```r
library(dplyr)

mtcars |>
  filter(cyl == 6) |>
  group_by(gear) |>
  summarise(
    consumo_medio = mean(mpg),
    n = n()
  ) |>
  arrange(desc(consumo_medio))
```

Verbi principali di `dplyr`: `filter()` (righe), `select()` (colonne), `mutate()` (nuove colonne), `group_by()` + `summarise()` (aggregazione), `arrange()` (ordinamento), `join` (unione tabelle).




## 9. Gestione dei pacchetti

```r
install.packages("ggplot2")   # installazione da CRAN
library(ggplot2)              # caricamento
require(ggplot2)             # come library ma ritorna TRUE/FALSE
update.packages()            # aggiornamento

# Import/export dati
df <- read.csv("dati.csv")
write.csv(df, "output.csv", row.names = FALSE)
readRDS("oggetto.rds")       # formato binario nativo
```




## 10. Riferimenti rapidi

| Operazione | Funzione |
|---|---|
| Aiuto su una funzione | `?nome` oppure `help(nome)` |
| Struttura di un oggetto | `str(x)` |
| Ambiente / variabili | `ls()` |
| Rimuovere una variabile | `rm(x)` |
| Lunghezza / dimensioni | `length()`, `dim()`, `nrow()`, `ncol()` |
| Valori mancanti | `is.na()`, `na.omit()`, `complete.cases()` |
| Applicare una funzione | `sapply`, `lapply`, `apply`, `Map`, `Reduce` |




## 11. Documentazione e risorse

- **Documentazione ufficiale**: <https://www.r-project.org/other-docs.html>
- **Sito ufficiale**: <https://www.r-project.org/>
- **Manuali di riferimento**: <https://cran.r-project.org/manuals.html>
- **CRAN** (pacchetti e documentazione): <https://cran.r-project.org/>
- **R for Data Science**: <https://r4ds.hadley.nz/>
- **Documentazione tidyverse**: <https://www.tidyverse.org/learn/>
- Il libro *Advanced R* di Hadley Wickham è un approfondimento utile per comprendere
  gli aspetti avanzati del linguaggio e della programmazione funzionale in R.

> **Nota sulla versione**: gli esempi fanno riferimento alla serie corrente di R. Verifica sempre
> la versione installata con `R.version.string` e consulta la documentazione dei pacchetti utilizzati.
