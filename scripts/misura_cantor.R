# Genera img/misura_cantor.png: le prime iterazioni della costruzione
# dell'insieme di Cantor (teoria_misura.md, §6), una riga per livello.

cantor_intervalli <- function(n) {
    intervalli <- matrix(c(0, 1), ncol = 2)
    for (k in seq_len(n)) {
        nuovi <- matrix(nrow = 0, ncol = 2)
        for (i in seq_len(nrow(intervalli))) {
            a <- intervalli[i, 1]
            b <- intervalli[i, 2]
            terzo <- (b - a) / 3
            nuovi <- rbind(nuovi, c(a, a + terzo), c(b - terzo, b))
        }
        intervalli <- nuovi
    }
    intervalli
}

n_livelli <- 6

# Spectral è il font usato dalla pagina GitHub (geoteo.net/static/style.css);
# richiede il device Cairo per essere referenziato per nome famiglia.
png("img/misura_cantor.png", width = 1400, height = 900, res = 150, type = "cairo")
par(mar = c(3, 5, 1, 1), family = "Spectral")
plot(NA, xlim = c(0, 1), ylim = c(n_livelli, 0),
     xlab = "", ylab = "", yaxt = "n", xaxt = "n", bty = "n")
axis(1, at = seq(0, 1, 0.2))
axis(2, at = 0:n_livelli, labels = paste0("C_", 0:n_livelli), las = 1)

for (livello in 0:n_livelli) {
    ins <- cantor_intervalli(livello)
    segments(ins[, 1], livello, ins[, 2], livello, lwd = 10, lend = 1, col = "black")
}

dev.off()
