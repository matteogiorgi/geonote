# Genera img/misura_riemann_lebesgue.png: l'idea che distingue i due
# integrali (teoria_misura.md, §9) — Riemann partiziona il dominio in
# strisce verticali, Lebesgue partiziona il codominio in livelli
# orizzontali e misura la controimmagine di ciascun livello.

f <- function(x) 4 * x * (1 - x)
x <- seq(0, 1, length.out = 400)
y <- f(x)

# Spectral è il font usato dalla pagina GitHub (geoteo.net/static/style.css);
# richiede il device Cairo per essere referenziato per nome famiglia.
png("img/misura_riemann_lebesgue.png", width = 1800, height = 850, res = 150, type = "cairo")
par(mfrow = c(1, 2), mar = c(1.2, 2, 6.2, 2), family = "Spectral")

# --- Pannello sinistro: Riemann, partizione del dominio ---
plot(x, y, type = "l", lwd = 2,
     xlab = "", ylab = "", xaxt = "n", yaxt = "n", bty = "n", ylim = c(-0.08, 1))
mtext("Riemann: partiziona il dominio", side = 3, line = 3.0, cex = 1.15, font = 2)
mtext("l'altezza del rettangolo approssima f al centro di ciascuna striscia", side = 3, line = 1.5, cex = 0.75)
strisce <- seq(0, 1, by = 0.1)
altezze <- sapply(seq_len(length(strisce) - 1), function(i) f((strisce[i] + strisce[i + 1]) / 2))
for (i in seq_along(altezze)) {
    rect(strisce[i], 0, strisce[i + 1], altezze[i], col = "grey85", border = "grey50")
}
lines(x, y, lwd = 2)

# righe tratteggiate verticali: si fermano all'altezza del più alto dei due
# rettangoli adiacenti al confine, senza sbordare sopra di essi
for (k in seq_along(strisce)) {
    vicini <- altezze[c(k - 1, k)]
    cima <- max(vicini, na.rm = TRUE)
    segments(strisce[k], 0, strisce[k], cima, lty = 3, col = "grey60")
}

# --- Pannello destro: Lebesgue, partizione del codominio ---
# Il codominio [0,1] è diviso in fasce; per ciascuna fascia si colora solo
# la parte di area sottesa dalla curva (non l'intera fascia orizzontale),
# e sull'asse x un "rug" con lo stesso colore mostra la controimmagine.
# f(x) = 4x(1-x) è invertibile a tratti: x_meno(c)/x_piu(c) sono i due
# rami (crescente/decrescente) per cui f(x) = c.
x_meno <- function(c) (1 - sqrt(1 - c)) / 2
x_piu <- function(c) (1 + sqrt(1 - c)) / 2

# tinta pastello (mescolata con il bianco) per il riempimento, in modo che
# le righe tratteggiate risaltino; il rug resta a colore pieno per leggerlo
# come "legenda".
schiarisci <- function(col, quantita = 0.55) {
    rgb_col <- col2rgb(col) / 255
    rgb_nuovo <- rgb_col + (1 - rgb_col) * quantita
    rgb(rgb_nuovo[1, ], rgb_nuovo[2, ], rgb_nuovo[3, ])
}

fasce <- seq(0, 1, length.out = 6)
colori <- c("#1b9e77", "#d95f02", "#7570b3", "#e7298a", "#66a61e")
colori_chiari <- schiarisci(colori)

plot(NA, xlim = c(0, 1), ylim = c(-0.08, 1),
     xlab = "", ylab = "", xaxt = "n", yaxt = "n", bty = "n")
mtext("Lebesgue: partiziona il codominio", side = 3, line = 3.0, cex = 1.15, font = 2)
mtext("il colore sull'asse mostra la controimmagine di ciascuna fascia", side = 3, line = 1.5, cex = 0.75)

for (i in seq_len(length(fasce) - 1)) {
    lo <- fasce[i]
    hi <- fasce[i + 1]
    xs <- seq(x_meno(lo), x_piu(lo), length.out = 200)
    alto <- pmin(f(xs), hi)
    polygon(c(xs, rev(xs)), c(alto, rep(lo, length(xs))), col = colori_chiari[i], border = NA)
}
for (livello in fasce) {
    segments(x_meno(livello), livello, x_piu(livello), livello, lty = 3, col = "grey70")
}
lines(x, y, lwd = 2)
abline(h = 0, col = "black")

for (i in seq_len(length(fasce) - 1)) {
    lo <- fasce[i]
    hi <- fasce[i + 1]
    segments(c(x_meno(lo), x_piu(hi)), -0.05, c(x_meno(hi), x_piu(lo)), -0.05, col = colori_chiari[i], lwd = 6, lend = 1)
}

# righe tratteggiate verticali: collegano ogni confine tra fasce sul rug
# alla rispettiva altezza sulla curva
for (livello in fasce[c(-1, -length(fasce))]) {
    segments(x_meno(livello), 0, x_meno(livello), livello, lty = 3, col = "grey30")
    segments(x_piu(livello), 0, x_piu(livello), livello, lty = 3, col = "grey30")
}

dev.off()
