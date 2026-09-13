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
par(mfrow = c(1, 2), mar = c(3, 3, 3, 1), family = "Spectral")

# --- Pannello sinistro: Riemann, partizione del dominio ---
plot(x, y, type = "l", lwd = 2, main = "Riemann: partiziona il dominio",
     xlab = "", ylab = "", xaxt = "n", yaxt = "n", bty = "n")
strisce <- seq(0, 1, by = 0.1)
for (i in seq_len(length(strisce) - 1)) {
    a <- strisce[i]
    b <- strisce[i + 1]
    altezza <- f((a + b) / 2)
    rect(a, 0, b, altezza, col = "grey85", border = "grey50")
}
lines(x, y, lwd = 2)
abline(v = strisce, lty = 3, col = "grey60")

# --- Pannello destro: Lebesgue, partizione del codominio ---
plot(x, y, type = "l", lwd = 2, main = "Lebesgue: partiziona il codominio",
     xlab = "", ylab = "", xaxt = "n", yaxt = "n", bty = "n", ylim = c(-0.05, 1.2))
livello <- 0.7
abline(h = livello, lty = 2, col = "grey40")
delta <- 0.02 * max(y)
poly_alto <- which(y >= livello - delta & y <= livello + delta)
rect(x[min(poly_alto)], -0.05, x[max(poly_alto)], 0, col = "grey40", border = NA)
segments(x[poly_alto], 0, x[poly_alto], livello, col = "grey75", lwd = 1)
points(x[c(min(poly_alto), max(poly_alto))], rep(livello, 2), pch = 16, col = "black")
text(0.5, 1.12, "insieme di livello: si misura la controimmagine", cex = 0.8)

dev.off()
