# Genera img/lagrange_sella.png: la Lagrangiana ha un punto di sella, non un
# minimo (matematica_statistica/teoria_lagrange.md, §6.2). Problema:
# min x^2 s.t. x = 1, con L(x, lambda) = x^2 + lambda (x - 1).
# A sinistra le curve di livello di L con la sella in (1, -2) e la curva
# x(lambda) = -lambda/2 dei minimi in x; a destra la funzione duale
# q(lambda) = min_x L = -lambda^2/4 - lambda, concava, con massimo 1 = f*
# raggiunto proprio in lambda* = -2.

col_vincolo <- "#1b9e77"
col_f <- "#d95f02"

schiarisci <- function(col, quantita = 0.85) {
    rgb_col <- col2rgb(col) / 255
    rgb_nuovo <- rgb_col + (1 - rgb_col) * quantita
    rgb(rgb_nuovo[1, ], rgb_nuovo[2, ], rgb_nuovo[3, ])
}

L <- function(x, l) x^2 + l * (x - 1)
q <- function(l) -l^2 / 4 - l

xs <- seq(-1, 3, length.out = 300)
ls <- seq(-5, 1, length.out = 300)
z <- outer(xs, ls, L)

# Spectral e' il font usato dalla pagina GitHub (geoteo.net/static/style.css);
# richiede il device Cairo per essere referenziato per nome famiglia.
png("img/lagrange_sella.png", width = 1800, height = 850, res = 150, type = "cairo")
par(mfrow = c(1, 2), oma = c(0, 0, 4.4, 0), mar = c(4, 4, 1.5, 2), family = "Spectral")

# Pannello sinistro: curve di livello di L(x, lambda).
plot(NA,
    xlim = range(xs), ylim = range(ls),
    xlab = "x", ylab = "λ", bty = "n", cex.axis = 0.8
)
livelli <- seq(-6, 12, by = 1)
contour(xs, ls, z, levels = livelli[livelli != 1], add = TRUE, drawlabels = FALSE, col = "grey70", lwd = 0.9)
# Il livello L = 1 passa per la sella e si spezza in due rette: x = 1 e
# x + lambda = -1 (infatti L - 1 = (x - 1)(x + 1 + lambda)).
contour(xs, ls, z, levels = 1, add = TRUE, drawlabels = FALSE, col = "grey30", lwd = 1.4)
lines(-ls / 2, ls, col = col_vincolo, lwd = 2.2, lty = 2)
points(1, -2, pch = 19, cex = 1.5, col = col_f)
text(1, -2, labels = "sella (1, -2)", pos = 4, offset = 0.8, cex = 0.75, col = col_f, font = 2)
legend("topright",
    legend = c("curve di livello di L", "livello L = 1 (passa per la sella)", "minimi in x: x = -λ/2"),
    col = c("grey70", "grey30", col_vincolo), lty = c(1, 1, 2), lwd = c(0.9, 1.4, 2.2),
    bty = "o", box.col = NA, bg = "white", cex = 0.7, seg.len = 2.2
)
title(main = "L(x, λ) = x² + λ(x - 1)", cex.main = 0.85, font.main = 1)

# Pannello destro: funzione duale.
plot(ls, q(ls),
    type = "l", lwd = 2.5, col = col_vincolo,
    xlab = "λ", ylab = "q(λ)", bty = "n", cex.axis = 0.8,
    ylim = c(-2.2, 1.6)
)
abline(h = 1, col = col_f, lty = 2, lwd = 1.6)
points(-2, 1, pch = 19, cex = 1.5, col = col_f)
text(-2, 1, labels = "max q = q(-2) = 1 = f*", pos = 3, offset = 0.8, cex = 0.75, col = col_f, font = 2)
legend("bottomright",
    legend = c("funzione duale q(λ) = min L(x, λ)", "valore ottimo primale f* = 1"),
    col = c(col_vincolo, col_f), lty = c(1, 2), lwd = c(2.5, 1.6),
    bty = "n", cex = 0.72, seg.len = 2.2
)
title(main = "minimo in x, poi massimo in λ", cex.main = 0.85, font.main = 1)

mtext("Moltiplicatori di Lagrange: la Lagrangiana ha una sella", side = 3, line = 2.4, cex = 1.15, font = 2, outer = TRUE)
mtext("min x² s.t. x = 1 (esempio del §6.2): L non ha minimi in (x, λ), ma min in x e max in λ ritrovano l'ottimo", side = 3, line = 0.9, cex = 0.75, outer = TRUE)

dev.off()
