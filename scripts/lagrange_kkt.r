# Genera img/lagrange_kkt.png: vincolo di disuguaglianza attivo e non attivo
# (matematica_statistica/teoria_lagrange.md, §5.2). Problema:
# min (x - a)^2 + (y - a)^2 s.t. h(x, y) = x + y - 2 <= 0.
# Con a = 2 il minimo libero (2, 2) non e' ammissibile: la soluzione e' (1, 1)
# sul bordo, con -grad f = mu grad h e mu = 2 > 0. Con a = 0.5 il minimo
# libero e' ammissibile, il vincolo non e' attivo e mu = 0.

col_vincolo <- "#1b9e77"
col_f <- "#d95f02"

schiarisci <- function(col, quantita = 0.85) {
    rgb_col <- col2rgb(col) / 255
    rgb_nuovo <- rgb_col + (1 - rgb_col) * quantita
    rgb(rgb_nuovo[1, ], rgb_nuovo[2, ], rgb_nuovo[3, ])
}

freccia <- function(p, v, ...) arrows(p[1], p[2], p[1] + v[1], p[2] + v[2], length = 0.09, ...)

s <- seq(-0.5, 3, length.out = 300)

pannello <- function(a, titolo) {
    z <- outer(s, s, function(x, y) (x - a)^2 + (y - a)^2)
    plot(NA,
        xlim = c(-0.5, 3), ylim = c(-0.5, 3), asp = 1,
        xlab = "x", ylab = "y", bty = "n", cex.axis = 0.8
    )
    polygon(c(-0.5, 2.5, -0.5), c(2.5, -0.5, -0.5), col = schiarisci(col_vincolo), border = NA)
    abline(a = 2, b = -1, lwd = 2.2, col = col_vincolo)
    contour(s, s, z, levels = (1:12 / 4)^2, add = TRUE, drawlabels = FALSE, col = schiarisci(col_f, 0.45), lwd = 0.9)
    points(a, a, pch = 4, cex = 1.3, lwd = 2, col = col_f)

    # Soluzione: proiezione di (a, a) sulla regione x + y <= 2.
    sol <- if (2 * a > 2) c(1, 1) else c(a, a)
    mu <- max(0, 2 * a - 2)
    if (mu > 0) {
        # -grad f = (2, 2) = mu grad h: stessa direzione, lunghezza doppia.
        freccia(sol, 0.25 * mu * c(1, 1), lwd = 2.2, col = col_f)   # -grad f
        freccia(sol, 0.25 * c(1, 1), lwd = 2.6, col = col_vincolo)  # grad h
        text(sol[1], sol[2], labels = sprintf("(1, 1), μ = %g", mu), pos = 1, offset = 1, cex = 0.75, font = 2)
    } else {
        text(sol[1], sol[2], labels = sprintf("(%g, %g), μ = 0", a, a), pos = 1, offset = 1, cex = 0.75, font = 2)
    }
    points(sol[1], sol[2], pch = 19, cex = 1.4)
    title(main = titolo, cex.main = 0.85, font.main = 1)
}

# Spectral e' il font usato dalla pagina GitHub (geoteo.net/static/style.css);
# richiede il device Cairo per essere referenziato per nome famiglia.
png("img/lagrange_kkt.png", width = 1800, height = 850, res = 150, type = "cairo")
par(mfrow = c(1, 2), oma = c(0, 0, 4.4, 0), mar = c(4, 4, 1.5, 2), family = "Spectral")

pannello(2, "centro (2, 2) non ammissibile: vincolo attivo")
legend("topright",
    legend = c("regione x + y ≤ 2 e grad h", "curve di livello di f e -grad f", "minimo libero di f"),
    col = c(col_vincolo, col_f, col_f), lty = c(1, 1, NA), pch = c(NA, NA, 4),
    lwd = c(2.2, 2.2, 2), bty = "o", box.col = NA, bg = "white", cex = 0.7, seg.len = 2.2
)
pannello(0.5, "centro (0.5, 0.5) ammissibile: vincolo non attivo")

mtext("Moltiplicatori di Lagrange: vincoli di disuguaglianza (KKT)", side = 3, line = 2.4, cex = 1.15, font = 2, outer = TRUE)
mtext("min (x - a)² + (y - a)² s.t. x + y ≤ 2 (esempio del §5.2): μ > 0 solo se il vincolo è attivo", side = 3, line = 0.9, cex = 0.75, outer = TRUE)

dev.off()
