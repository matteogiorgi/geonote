# Genera img/lagrange_tangenza.png: le curve di livello di f(x, y) = xy e il
# vincolo x^2 + y^2 = 1 (matematica_statistica/teoria_lagrange.md, §1.3).
# Nei quattro punti stazionari le iperboli xy = ±1/2 toccano la circonferenza
# e i gradienti di f e di g sono paralleli; nel punto non stazionario (1, 0)
# il gradiente di f e' tangente al vincolo, e lungo quella direzione f
# cresce restando ammissibili.

col_vincolo <- "#1b9e77"
col_f <- "#d95f02"

schiarisci <- function(col, quantita = 0.85) {
    rgb_col <- col2rgb(col) / 255
    rgb_nuovo <- rgb_col + (1 - rgb_col) * quantita
    rgb(rgb_nuovo[1, ], rgb_nuovo[2, ], rgb_nuovo[3, ])
}

grad_f <- function(p) c(p[2], p[1])
grad_g <- function(p) 2 * p

# Freccia di lunghezza fissata nella direzione di v, per confrontare le
# direzioni dei gradienti indipendentemente dal loro modulo.
freccia <- function(p, v, lunghezza, ...) {
    v <- lunghezza * v / sqrt(sum(v^2))
    arrows(p[1], p[2], p[1] + v[1], p[2] + v[2], length = 0.09, ...)
}

s <- seq(-1.75, 1.75, length.out = 400)
# Le curve di livello si disegnano solo dentro un disco, cosi' la figura
# non termina con un taglio quadrato.
z <- outer(s, s, function(x, y) ifelse(x^2 + y^2 <= 1.7^2, x * y, NA))

# Spectral e' il font usato dalla pagina GitHub (geoteo.net/static/style.css);
# richiede il device Cairo per essere referenziato per nome famiglia.
png("img/lagrange_tangenza.png", width = 1800, height = 850, res = 150, type = "cairo")
par(mar = c(1, 1, 6.2, 1), family = "Spectral")
plot(NA,
    xlim = c(-3.4, 3.4), ylim = c(-1.6, 1.6), asp = 1,
    xlab = "", ylab = "", xaxt = "n", yaxt = "n", bty = "n"
)
mtext("Moltiplicatori di Lagrange: tangenza tra curve di livello e vincolo", side = 3, line = 3.0, cex = 1.15, font = 2)
mtext("f(x, y) = xy sulla circonferenza x² + y² = 1 (esempio del §1.3)", side = 3, line = 1.5, cex = 0.75)

abline(h = 0, v = 0, col = "grey88")

# Curve di livello "di passaggio" chiare; quelle dei valori ottimi
# (xy = 1/2 e xy = -1/2) piene, nel colore di f.
livelli <- setdiff(seq(-1.5, 1.5, by = 0.25), c(-0.5, 0, 0.5))
contour(s, s, z, levels = livelli, add = TRUE, drawlabels = FALSE, col = schiarisci(col_f, 0.6), lty = 2, lwd = 0.9)
contour(s, s, z, levels = c(-0.5, 0.5), add = TRUE, drawlabels = FALSE, col = col_f, lwd = 1.8)

t <- seq(0, 2 * pi, length.out = 400)
lines(cos(t), sin(t), lwd = 2.5, col = col_vincolo)

p <- 1 / sqrt(2)
stazionari <- rbind(c(p, p), c(-p, -p), c(p, -p), c(-p, p))
for (i in seq_len(nrow(stazionari))) {
    q <- stazionari[i, ]
    freccia(q, grad_g(q), 0.55, lwd = 2.2, col = col_vincolo)
    freccia(q, grad_f(q), 0.38, lwd = 2.2, col = col_f)
}
points(stazionari, pch = 19, cex = 1.4, col = "black")

# Etichette su fondo bianco, all'esterno del disco delle curve di livello.
etichetta <- function(x, y, testo, adj) {
    w <- strwidth(testo, cex = 0.72) * 1.1
    h <- strheight(testo, cex = 0.72) * 1.8
    rect(x - adj * w, y - h / 2, x + (1 - adj) * w, y + h / 2, col = "white", border = NA)
    text(x, y, testo, adj = c(adj, 0.5), cex = 0.72)
}
etichetta(-1.85, 1.15, "min, f = -1/2", 1)
etichetta(-1.85, -1.15, "max, f = 1/2", 1)
etichetta(1.85, -1.15, "min, f = -1/2", 0)
segments(c(-1.85, -1.85, 1.85), c(1.15, -1.15, -1.15), stazionari[c(4, 2, 3), 1], stazionari[c(4, 2, 3), 2], col = "grey70", lty = 3)

# Punto non stazionario (1, 0): grad g = (2, 0) e' normale al vincolo,
# grad f = (0, 1) e' tangente, quindi i due gradienti sono ortogonali.
q <- c(1, 0)
freccia(q, grad_g(q), 0.55, lwd = 2.2, col = col_vincolo)
freccia(q, grad_f(q), 0.38, lwd = 2.2, col = col_f)
points(q[1], q[2], pch = 21, bg = "white", cex = 1.4, lwd = 1.5)
etichetta(1.85, 0.36, "punto non stazionario (1, 0), f = 0:", 0)
etichetta(1.85, 0.22, "grad f tangente al vincolo, f cresce verso l'alto", 0)
etichetta(1.85, 1.15, "max, f = 1/2", 0)
segments(1.85, 1.15, stazionari[1, 1], stazionari[1, 2], col = "grey70", lty = 3)

legend("bottomleft",
    legend = c("vincolo g = x² + y² - 1 = 0 e grad g", "curve di livello xy = ±1/2 e grad f", "altre curve di livello di f"),
    col = c(col_vincolo, col_f, schiarisci(col_f, 0.6)), lty = c(1, 1, 2),
    lwd = c(2.5, 1.8, 0.9), bty = "n", cex = 0.72, inset = c(0.0, 0.02), seg.len = 2.2
)

dev.off()
