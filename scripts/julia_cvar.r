# Genera img/julia_cvar.png: perdita aggregata S = X_1 + ... + X_N con
# N ~ Poisson(10) e tre severita' di media 1 (esponenziale, lognormale,
# Pareto), cioe' i tre portafogli del §11.3 di fondamenti/fondamenti_julia.md.
# A sinistra la funzione di sopravvivenza empirica P(S > s) in scala
# logaritmica: stessa media, code diverse. A destra la funzione di
# Rockafellar-Uryasev F(zeta) = zeta + E[(S - zeta)^+] / (1 - alpha) con
# alpha = 0.99: e' convessa, il minimo si trova in zeta = VaR e vale CVaR.
# La simulazione e' rifatta in R con lo stesso modello: i valori differiscono
# da quelli della nota solo per il rumore Monte Carlo.

set.seed(2026)

col_esp <- "#1b9e77"
col_logn <- "#d95f02"
col_par <- "#7570b3"

nsim <- 2e5
lambda <- 10
alpha <- 0.99

severita <- list(
    Esponenziale = function(n) rexp(n, rate = 1),
    Lognormale = function(n) rlnorm(n, meanlog = -0.5, sdlog = 1),
    Pareto = function(n) 0.6 * runif(n)^(-1 / 2.5)
)

simula <- function(rsev) {
    n <- rpois(nsim, lambda)
    s <- rsev(sum(n))
    # somma per sinistro: i primi n[1] valori al primo scenario, e cosi' via
    rowsum(s, rep(seq_len(nsim), n), reorder = TRUE)[, 1][as.character(seq_len(nsim))]
}
perdite <- lapply(severita, function(f) {
    s <- simula(f)
    s[is.na(s)] <- 0 # scenari senza sinistri
    unname(s)
})

f_ru <- function(L, zeta) zeta + mean(pmax(L - zeta, 0)) / (1 - alpha)
var_cvar <- function(L) {
    v <- unname(quantile(L, alpha, type = 7))
    c(var = v, cvar = f_ru(L, v))
}
vc <- sapply(perdite, var_cvar)
colori <- c(col_esp, col_logn, col_par)

# Spectral e' il font usato dalla pagina GitHub (geoteo.net/static/style.css);
# richiede il device Cairo per essere referenziato per nome famiglia.
png("img/julia_cvar.png", width = 1800, height = 850, res = 150, type = "cairo")
par(mfrow = c(1, 2), oma = c(0, 0, 4.4, 0), mar = c(4, 5, 1.5, 2), family = "Spectral")

# Pannello sinistro: sopravvivenza empirica.
plot(NA,
    xlim = c(0, 45), ylim = c(1e-4, 1), log = "y",
    xlab = "perdita aggregata s", ylab = "P(S > s)", bty = "n", cex.axis = 0.8, yaxt = "n"
)
axis(2, at = 10^(-4:0), labels = c("0,0001", "0,001", "0,01", "0,1", "1"), las = 1, cex.axis = 0.75)
griglia <- seq(0, 45, length.out = 400)
for (k in seq_along(perdite)) {
    sopr <- 1 - ecdf(perdite[[k]])(griglia)
    sopr[sopr <= 0] <- NA
    lines(griglia, sopr, col = colori[k], lwd = 2.2)
}
abline(h = 1 - alpha, lty = 2, col = "grey50")
text(40, 1 - alpha, labels = "1 - α = 0,01", pos = 3, cex = 0.7, col = "grey40")
abline(v = lambda, lty = 3, col = "grey60")
text(lambda, 1e-4, labels = "E[S] = 10", pos = 4, cex = 0.7, col = "grey40")
legend("topright",
    legend = names(perdite), col = colori, lwd = 2.2,
    bty = "o", box.col = NA, bg = "white", cex = 0.75
)
title(main = "stessa media, code diverse", cex.main = 0.85, font.main = 1)

# Pannello destro: funzione di Rockafellar-Uryasev.
zetas <- seq(15, 40, length.out = 200)
curve_ru <- lapply(perdite, function(L) sapply(zetas, function(z) f_ru(L, z)))
plot(NA,
    xlim = range(zetas), ylim = c(22, 40),
    xlab = "ζ", ylab = "F(ζ) = ζ + E[(S - ζ)⁺] / (1 - α)", bty = "n", cex.axis = 0.8, las = 1
)
for (k in seq_along(perdite)) {
    lines(zetas, curve_ru[[k]], col = colori[k], lwd = 2.2)
    points(vc["var", k], vc["cvar", k], pch = 19, cex = 1.4, col = colori[k])
}
legend(21, 40.5,
    legend = sprintf("%s: VaR %.1f, CVaR %.1f", names(perdite), vc["var", ], vc["cvar", ]),
    col = colori, pch = 19, bty = "o", box.col = NA, bg = "white", cex = 0.72
)
title(main = "α = 0,99: il minimo è in ζ = VaR e vale CVaR", cex.main = 0.85, font.main = 1)

mtext("Perdita aggregata Poisson composta: VaR e CVaR", side = 3, line = 2.4, cex = 1.15, font = 2, outer = TRUE)
mtext("N ~ Poisson(10), tre severità di media 1 (esempio del §11.3): la formula di Rockafellar-Uryasev ritrova VaR e CVaR come argomento e valore del minimo", side = 3, line = 0.9, cex = 0.75, outer = TRUE)

dev.off()
