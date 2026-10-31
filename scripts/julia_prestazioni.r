# Genera img/julia_prestazioni.png: il modello di prestazioni di Julia
# (fondamenti/fondamenti_julia.md, §8). A sinistra la stima Monte Carlo di pi
# con n = 10^6 punti (§11.1) scritta con un ciclo esplicito o vettorizzata,
# in Julia, Go, Octave, R e Guile; a destra il costo della prima chiamata di
# una funzione Julia (compilazione inclusa) rispetto alle chiamate successive.
# I tempi sono misurati sulla stessa macchina (Julia 1.13.1, Go 1.22.2,
# Octave 8.4.0, R 4.3.3, Guile 3.0.9 con compilazione automatica): contano
# gli ordini di grandezza, non le cifre.

col_ciclo <- "#d95f02"
col_vett <- "#1b9e77"
col_primo <- "#d95f02"
col_dopo <- "#1b9e77"

# Tempi in millisecondi, stima di pi con n = 10^6.
mc <- data.frame(
    nome = c(
        "Julia, ciclo", "Go, ciclo", "Julia, vettorizzato", "Octave, vettorizzato",
        "R, vettorizzato", "Guile, ciclo (named let)", "R, ciclo", "Octave, ciclo"
    ),
    ms = c(2.5, 7.4, 7.9, 42, 83, 295, 5398, 9018),
    etichetta = c("2,5", "7,4", "7,9", "42", "83", "295", "5.398", "9.018"),
    ciclo = c(TRUE, TRUE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE)
)
mc <- mc[order(mc$ms, decreasing = TRUE), ]

# Prima chiamata e chiamate successive, in secondi.
ttfx <- data.frame(
    nome = c("stima_pi(10^6)", "rendita(30, big(1)//20)", "A \\ b, A 200×200", "sort(rand(10^6))"),
    primo = c(0.033, 0.138, 0.64, 1.81),
    dopo = c(0.0028, 0.000067, 0.00057, 0.057)
)

# Spectral e' il font usato dalla pagina GitHub (geoteo.net/static/style.css);
# richiede il device Cairo per essere referenziato per nome famiglia.
png("img/julia_prestazioni.png", width = 1800, height = 850, res = 150, type = "cairo")
par(mfrow = c(1, 2), oma = c(0, 0, 4.4, 0), family = "Spectral")

# Pannello sinistro: barre orizzontali in scala logaritmica.
par(mar = c(4, 11, 1.5, 2))
y <- barplot(mc$ms,
    horiz = TRUE, log = "x", names.arg = mc$nome, las = 1,
    col = ifelse(mc$ciclo, col_ciclo, col_vett), border = NA,
    xlim = c(1, 3e4), xlab = "millisecondi (scala logaritmica)",
    cex.names = 0.72, cex.axis = 0.8, axes = FALSE
)
axis(1, at = 10^(0:4), labels = c("1", "10", "100", "1000", "10000"), cex.axis = 0.8)
text(mc$ms, y,
    labels = mc$etichetta,
    pos = 4, cex = 0.68, col = "grey30"
)
legend("topright",
    legend = c("ciclo esplicito", "vettorizzato"), fill = c(col_ciclo, col_vett),
    border = NA, bty = "n", cex = 0.72
)
title(main = "stima Monte Carlo di π, n = 10⁶", cex.main = 0.85, font.main = 1)

# Pannello destro: prima chiamata contro chiamate successive.
par(mar = c(4, 10, 1.5, 2))
yy <- rev(seq_len(nrow(ttfx)))
plot(NA,
    xlim = c(3e-5, 5), ylim = c(0.5, nrow(ttfx) + 0.5), log = "x",
    xlab = "secondi (scala logaritmica)", ylab = "", yaxt = "n", xaxt = "n", bty = "n"
)
axis(1, at = 10^(-4:0), labels = c("0,0001", "0,001", "0,01", "0,1", "1"), cex.axis = 0.8)
axis(2, at = yy, labels = ttfx$nome, las = 1, tick = FALSE, cex.axis = 0.72)
segments(ttfx$dopo, yy, ttfx$primo, yy, col = "grey70", lwd = 2)
points(ttfx$primo, yy, pch = 19, cex = 1.5, col = col_primo)
points(ttfx$dopo, yy, pch = 19, cex = 1.5, col = col_dopo)
text(sqrt(ttfx$primo * ttfx$dopo), yy,
    labels = paste0("×", round(ttfx$primo / ttfx$dopo)), pos = 3, offset = 0.6, cex = 0.68, col = "grey30"
)
legend("bottomright",
    legend = c("prima chiamata (compilazione inclusa)", "chiamate successive"),
    col = c(col_primo, col_dopo), pch = 19, bty = "n", cex = 0.72
)
title(main = "il costo della prima chiamata", cex.main = 0.85, font.main = 1)

mtext("Julia: cicli veloci, prima chiamata lenta", side = 3, line = 2.4, cex = 1.15, font = 2, outer = TRUE)
mtext("a sinistra lo stesso calcolo in cinque linguaggi (§8, §11.1); a destra prima chiamata e chiamate successive della stessa funzione (§8.1)", side = 3, line = 0.9, cex = 0.75, outer = TRUE)

dev.off()
