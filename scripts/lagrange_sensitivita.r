# Genera img/lagrange_sensitivita.png: il significato di lambda come
# sensitivita' del valore ottimo (matematica_statistica/teoria_lagrange.md, §4.2).
# Problema: min x + y s.t. x^2 + y^2 = c. Il minimo e' in
# x = y = -sqrt(c/2), con f*(c) = -sqrt(2c) e lambda*(c) = 1/sqrt(2c).
# A sinistra i vincoli per quattro valori di c, con il punto di minimo e la
# curva di livello che lo tocca; a destra f*(c) e la sua tangente in c = 1,
# di pendenza -lambda*(1).

col_vincolo <- "#1b9e77"
col_f <- "#d95f02"

schiarisci <- function(col, quantita = 0.85) {
    rgb_col <- col2rgb(col) / 255
    rgb_nuovo <- rgb_col + (1 - rgb_col) * quantita
    rgb(rgb_nuovo[1, ], rgb_nuovo[2, ], rgb_nuovo[3, ])
}

f_star <- function(c) -sqrt(2 * c)
lambda_star <- function(c) 1 / sqrt(2 * c)

valori_c <- c(0.5, 1, 1.5, 2)

# Spectral e' il font usato dalla pagina GitHub (geoteo.net/static/style.css);
# richiede il device Cairo per essere referenziato per nome famiglia.
png("img/lagrange_sensitivita.png", width = 1800, height = 850, res = 150, type = "cairo")
par(mfrow = c(1, 2), oma = c(0, 0, 4.4, 0), mar = c(4, 4, 1.5, 2), family = "Spectral")

# Pannello sinistro: vincoli x^2 + y^2 = c e minimi di x + y.
plot(NA,
    xlim = c(-2.1, 2.1), ylim = c(-2.1, 2.1), asp = 1,
    xlab = "x", ylab = "y", bty = "n", cex.axis = 0.8
)
abline(h = 0, v = 0, col = "grey88")
t <- seq(0, 2 * pi, length.out = 400)
for (c in valori_c) {
    principale <- c == 1
    r <- sqrt(c)
    lines(r * cos(t), r * sin(t),
        col = if (principale) col_vincolo else schiarisci(col_vincolo, 0.5),
        lwd = if (principale) 2.5 else 1.4
    )
    # Curva di livello x + y = f*(c), tangente al vincolo nel minimo.
    abline(a = f_star(c), b = -1,
        col = if (principale) col_f else schiarisci(col_f, 0.55),
        lty = 2, lwd = if (principale) 1.6 else 1
    )
    m <- -sqrt(c / 2)
    points(m, m, pch = 19, cex = if (principale) 1.4 else 1, col = if (principale) col_f else schiarisci(col_f, 0.3))
}
text(-sqrt(1 / 2), -sqrt(1 / 2), labels = "c = 1", pos = 4, offset = 0.8, cex = 0.75, col = col_f, font = 2)
title(main = "vincoli x² + y² = c e minimi di x + y", cex.main = 0.85, font.main = 1)

# Pannello destro: f*(c) e tangente in c = 1.
cc <- seq(0.1, 2.5, length.out = 300)
plot(cc, f_star(cc),
    type = "l", lwd = 2.5, col = col_vincolo,
    xlab = "c", ylab = "f*(c)", bty = "n", cex.axis = 0.8,
    ylim = c(-2.4, 0)
)
abline(a = f_star(1) + lambda_star(1), b = -lambda_star(1), col = col_f, lty = 2, lwd = 1.8)
points(valori_c, f_star(valori_c), pch = 19, cex = 1, col = schiarisci(col_f, 0.3))
points(1, f_star(1), pch = 19, cex = 1.4, col = col_f)
text(1, f_star(1),
    labels = sprintf("c = 1: pendenza = -λ* = %.3f", -lambda_star(1)),
    pos = 4, offset = 0.9, cex = 0.75, col = col_f, font = 2
)
legend("topright",
    legend = c("valore ottimo f*(c) = -√(2c)", "tangente in c = 1"),
    col = c(col_vincolo, col_f), lty = c(1, 2), lwd = c(2.5, 1.8),
    bty = "n", cex = 0.72, seg.len = 2.2
)
title(main = "valore ottimo in funzione di c", cex.main = 0.85, font.main = 1)

mtext("Moltiplicatori di Lagrange: λ come sensitività del valore ottimo", side = 3, line = 2.4, cex = 1.15, font = 2, outer = TRUE)
mtext("min x + y s.t. x² + y² = c (esempio del §4.2): allargando il vincolo l'ottimo scende con pendenza -λ*", side = 3, line = 0.9, cex = 0.75, outer = TRUE)

dev.off()
