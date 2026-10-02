# Genera img/lagrange_pli.png: il bound del rilassamento lagrangiano per la
# PLI di teoria_computazione/teoria_ottimizzazione.md (§2.1), ripresa in
# matematica_statistica/teoria_lagrange.md (§8.4):
#   max 5x + 4y s.t. 6x + 4y <= 24, x + 2y <= 6, x, y >= 0 interi.
# Si rilassa x + 2y <= 6 con moltiplicatore u >= 0:
#   q(u) = 6u + max { (5 - u) x + (4 - 2u) y : 6x + 4y <= 24, x, y interi >= 0 }.
# q e' convessa e lineare a tratti; il suo minimo (21, in u = 1/2) coincide con
# l'ottimo della PL, e resta sopra l'ottimo intero 20: il duality gap.

col_vincolo <- "#1b9e77"
col_f <- "#d95f02"

# I punti interi di X = {6x + 4y <= 24, x, y >= 0} sono pochi: si enumerano.
X <- subset(expand.grid(x = 0:4, y = 0:6), 6 * x + 4 * y <= 24)
q <- function(u) 6 * u + max((5 - u) * X$x + (4 - 2 * u) * X$y)

us <- seq(0, 2, length.out = 401)
qs <- sapply(us, q)

# Spectral e' il font usato dalla pagina GitHub (geoteo.net/static/style.css);
# richiede il device Cairo per essere referenziato per nome famiglia.
png("img/lagrange_pli.png", width = 1800, height = 850, res = 150, type = "cairo")
par(mar = c(4.2, 4.5, 6.2, 2), family = "Spectral")
plot(us, qs,
    type = "l", lwd = 2.5, col = col_vincolo,
    xlab = "u", ylab = "q(u)", bty = "n", cex.axis = 0.8,
    ylim = c(18.5, 24.5)
)
mtext("Rilassamento lagrangiano: bound duale e duality gap", side = 3, line = 3.0, cex = 1.15, font = 2)
mtext("PLI del §8.4: si rilassa x + 2y ≤ 6 con moltiplicatore u ≥ 0; ogni q(u) è un bound superiore all'ottimo intero", side = 3, line = 1.5, cex = 0.75)

abline(h = 21, col = col_f, lty = 2, lwd = 1.4)
abline(h = 20, col = col_f, lwd = 1.8)
arrows(0.5, 20.05, 0.5, 20.95, length = 0.07, code = 3, col = "grey40")
text(0.5, 20.5, labels = "duality gap = 1", pos = 2, cex = 0.75, col = "grey30")

points(0.5, 21, pch = 19, cex = 1.5, col = col_vincolo)
text(0.54, 20.78, labels = "min q = q(1/2) = 21", adj = c(0, 0.5), cex = 0.75, font = 2, col = col_vincolo)

legend("bottomright",
    legend = c("bound lagrangiano q(u)", "ottimo della PL (rilassamento continuo) = 21", "ottimo intero = 20, in (4, 0)"),
    col = c(col_vincolo, col_f, col_f), lty = c(1, 2, 1), lwd = c(2.5, 1.4, 1.8),
    bty = "n", cex = 0.72, seg.len = 2.2
)

dev.off()
