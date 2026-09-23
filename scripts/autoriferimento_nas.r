# Genera img/autoriferimento_nas.png: costo di ricerca (in GPU-giorni,
# scala log) di quattro metodi di neural architecture search
# (teoria_computazione/teoria_autoriferimento.md, §4.3). Valori dalla tabella comparativa di
# Liu, Simonyan, Yang (DARTS, ICLR 2019): NASNet-A (Zoph et al. 2018,
# ricerca RL), AmoebaNet-A (Real et al. 2019, ricerca evolutiva), ENAS
# (Pham et al. 2018, weight-sharing), DARTS (rilassazione differenziabile).

metodi <- c("ENAS", "DARTS", "NASNet-A", "AmoebaNet-A")
gpu_giorni <- c(0.5, 4, 2000, 3150)
famiglia <- c("weight-sharing", "weight-sharing", "training completo", "training completo")

ord <- order(gpu_giorni)
metodi <- metodi[ord]
gpu_giorni <- gpu_giorni[ord]
famiglia <- famiglia[ord]

colori_famiglia <- c("training completo" = "#d95f02", "weight-sharing" = "#1b9e77")
colori <- colori_famiglia[famiglia]

x <- log10(gpu_giorni)
y <- seq_along(x)
xlim <- c(-0.6, 4.3)

# Spectral è il font usato dalla pagina GitHub (geoteo.net/static/style.css);
# richiede il device Cairo per essere referenziato per nome famiglia.
png("img/autoriferimento_nas.png", width = 1800, height = 850, res = 150, type = "cairo")
par(mar = c(4.2, 8.5, 6.2, 3), family = "Spectral")
plot(NA,
    xlim = xlim, ylim = c(0.5, length(x) + 0.5),
    xlab = "", ylab = "", yaxt = "n", xaxt = "n", bty = "n"
)
mtext("Costo di ricerca in NAS: tre ordini di grandezza", side = 3, line = 3.0, cex = 1.15, font = 2)
mtext("GPU-giorni per trovare un'architettura competitiva su CIFAR-10 (scala log)", side = 3, line = 1.5, cex = 0.75)

marcatori <- c(0.1, 1, 10, 100, 1000, 10000)
axis(1, at = log10(marcatori), labels = marcatori)
axis(2, at = y, labels = metodi, las = 1, tick = FALSE)

segments(xlim[1], y, x, y, col = colori, lwd = 2, lty = 3)
points(x, y, pch = 19, cex = 2.8, col = colori)
text(x, y,
    labels = sprintf("%s GPU-giorni", format(gpu_giorni, trim = TRUE, drop0trailing = TRUE)),
    pos = 4, offset = 1.2, cex = 0.85, family = "Spectral"
)

legend("bottomright",
    legend = c(
        "valuta ogni candidata addestrandola (training completo)",
        "condivide i pesi fra le candidate (weight-sharing)"
    ),
    col = colori_famiglia, pch = 19, pt.cex = 1.6, bty = "n", cex = 0.75, inset = c(0.01, 0.02)
)

dev.off()
