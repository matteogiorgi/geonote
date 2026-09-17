# Genera img/ottimizzazione_lp.png: la regione ammissibile dell'esempio di
# LP (teoria_ottimizzazione.md, §1.2) con i suoi 4 vertici e tre curve di
# livello di 5x+4y, per mostrare visivamente perche' l'ottimo cade sul
# vertice (3, 1.5) dove la curva di livello tocca il poliedro per l'ultima
# volta (§1.3).

vertici <- rbind(
    c(0, 0), c(4, 0), c(3, 1.5), c(0, 3)
)
valori <- c(0, 20, 21, 12)

col_regione <- "#1b9e77"
col_livello <- "#d95f02"

schiarisci <- function(col, quantita = 0.85) {
    rgb_col <- col2rgb(col) / 255
    rgb_nuovo <- rgb_col + (1 - rgb_col) * quantita
    rgb(rgb_nuovo[1, ], rgb_nuovo[2, ], rgb_nuovo[3, ])
}

# Spectral e' il font usato dalla pagina GitHub (geoteo.net/static/style.css);
# richiede il device Cairo per essere referenziato per nome famiglia.
png("img/ottimizzazione_lp.png", width = 1800, height = 850, res = 150, type = "cairo")
par(mar = c(2, 2, 6.2, 2), family = "Spectral")
plot(NA,
    xlim = c(-0.6, 6.6), ylim = c(-0.6, 4.6),
    xlab = "", ylab = "", xaxt = "n", yaxt = "n", bty = "n"
)
mtext("Programmazione lineare: regione ammissibile e ottimo", side = 3, line = 3.0, cex = 1.15, font = 2)
mtext("vertici del poliedro e curve di livello di 5x+4y (esempio del §1.2)", side = 3, line = 1.5, cex = 0.75)

abline(h = 0, v = 0, col = "grey80")

polygon(vertici, col = schiarisci(col_regione), border = col_regione, lwd = 2)

# Tre curve di livello 5x+4y = k, disegnate sopra il riempimento del
# poligono (altrimenti il tratto dashed sparirebbe dove passa nella
# regione ammissibile): le prime due (dashed, piu' chiare) sono solo di
# passaggio, la terza (k = 21, solida) e' quella che tocca il poliedro per
# l'ultima volta, esattamente nel vertice ottimo — l'etichetta di
# quest'ultima e' gia' sul vertice, non serve ripeterla sulla retta.
for (k in c(8, 16)) {
    abline(a = k / 4, b = -5 / 4, col = schiarisci(col_livello, 0.35), lty = 2, lwd = 1.4)
}
abline(a = 21 / 4, b = -5 / 4, col = col_livello, lwd = 2)

text(3.6, 0.6, labels = "6x+4y=24", pos = 4, offset = 1.6, cex = 0.75, col = col_regione)
text(1.5, 2.25, labels = "x+2y=6", pos = 3, cex = 0.75, col = col_regione)

# I tre vertici non ottimi in teal (come il bordo della regione), l'ottimo
# in arancio (come la curva di livello che lo tocca) per legare visivamente
# vertice e curva.
for (i in seq_len(nrow(vertici))) {
    ottimo <- valori[i] == max(valori)
    x <- vertici[i, 1]
    y <- vertici[i, 2]
    col_punto <- if (ottimo) col_livello else col_regione
    points(x, y, pch = 19, cex = if (ottimo) 2.4 else 1.6, col = col_punto)
    pos_lab <- c(1, 1, 4, 2)[i]
    text(x, y,
        labels = sprintf("(%s, %s)\n%d", format(x, drop0trailing = TRUE), format(y, drop0trailing = TRUE), valori[i]),
        pos = pos_lab, offset = 0.7, cex = 0.78, font = if (ottimo) 2 else 1, col = col_punto
    )
}

legend("topright",
    legend = c("vincoli (bordo della regione ammissibile)", "curve di livello di 5x+4y", "ottimo: (3, 1.5), valore 21"),
    col = c(col_regione, col_livello, col_livello), lty = c(1, 2, NA), pch = c(NA, NA, 19),
    lwd = c(2, 1.4, NA), pt.cex = 1.6, bty = "n", cex = 0.72, inset = c(0.0, 0.02), seg.len = 2.2
)

dev.off()
