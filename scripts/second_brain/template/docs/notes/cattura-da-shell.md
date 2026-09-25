---
title: Cattura da shell
tags: [second-brain, cattura, shell, posix]
created: 2026-09-25
---

# Cattura da shell

## Principio

La cattura è il punto in cui un'idea entra nel sistema, e deve costare
il meno possibile: zero decisioni e zero dipendenze. Niente titolo,
niente tag, niente scelta della cartella. Tutto quello che richiede
pensiero è rimandato al triage (vedi
[istruzioni agent-agnostiche](istruzioni-agent-agnostiche.md)).

Per lo stesso motivo la cattura non dipende da nessun editor e da nessun
agente: deve funzionare anche quando entrambi sono rotti, assenti o
lenti ad avviarsi. È il pezzo più semplice del
[nucleo](nucleo-e-adattatori.md), e deve restarlo.

## L'inbox come interfaccia

L'unico contratto è questo: *un file di testo che compare in `inbox/`
è un appunto*. Lo script qui sotto è solo il modo più comodo di
rispettarlo. Qualsiasi altra via che deposita un file in `inbox/`
(una sincronizzazione dal telefono, un'email salvata, un file copiato a
mano) è una cattura valida.

I file in `inbox/` sono esentati dal [formato](formato-delle-note.md):
niente frontmatter, nome a timestamp. Diventano note vere solo dopo il
triage.

## Lo script

`bin/capture`:

```sh
#!/bin/sh
# capture: scrive un appunto grezzo nell'inbox dell'archivio
#
# uso:
#   capture "testo dell'appunto"
#   comando | capture
#   capture                  (da terminale: apre $EDITOR)
#
# L'archivio è quello in cui ci si trova (la cartella corrente o una che
# la contiene); fuori da un archivio, quello che contiene lo script; se
# lo script non sta in un archivio (un link simbolico messo altrove),
# quello in $BRAIN.

set -eu

# un archivio ha AGENTS.md, inbox/ e notes/
is_archive() {
    [ -f "$1/AGENTS.md" ] && [ -d "$1/inbox" ] && [ -d "$1/notes" ]
}

root=''
d=$(pwd -P)
while :; do
    if is_archive "$d"; then
        root=$d
        break
    fi
    [ "$d" != / ] || break
    d=$(dirname "$d")
done
if [ -z "$root" ] && is_archive "$(dirname "$0")/.."; then
    root="$(dirname "$0")/.."
fi
if [ -z "$root" ] && [ -n "${BRAIN:-}" ] && is_archive "$BRAIN"; then
    root=$BRAIN
fi
if [ -z "$root" ]; then
    echo "capture: archivio non trovato (né qui, né accanto allo script, né in \$BRAIN)" >&2
    exit 1
fi
dir="$root/inbox"
f="$dir/$(date +%Y%m%d-%H%M%S)-$$.md"

if [ $# -gt 0 ]; then
    printf '%s\n' "$*" >"$f"
elif [ -t 0 ]; then
    "${EDITOR:-vi}" "$f"
else
    cat >"$f"
fi

# niente appunti vuoti
if [ ! -s "$f" ]; then
    rm -f "$f"
    echo "capture: appunto vuoto, nulla salvato" >&2
    exit 1
fi
```

Tre modi d'uso, scelti in base a cosa arriva:

- **Argomenti**: il testo sulla riga di comando, per le idee di una riga.
- **Standard input**: l'output di un altro comando, per catturare
  qualcosa che è già testo.
- **Nessuno dei due**: se lo standard input è un terminale, apre
  l'editor su un file nuovo, per appunti più lunghi. L'editor è quello di
  `$EDITOR`, quindi la scelta resta fuori dallo script.

Il nome del file unisce data, ora e PID, così due catture nello stesso
secondo non si sovrascrivono. Un appunto vuoto (editor chiuso senza
salvare, pipe senza output) non lascia file.

L'archivio è quello in cui ci si trova (la cartella corrente o una che
la contiene); fuori da un archivio, quello che contiene lo script; se
lo script non sta in un archivio, quello in `$BRAIN`. Così, con più
archivi, `capture` lanciato dentro uno di essi scrive lì. Se non trova
un archivio, lo script si ferma con un errore invece di creare
un'inbox nel posto sbagliato.

## Installazione

`init.sh` aggiunge queste righe in fondo a `~/.profile`; a mano, vanno
nel profilo della shell:

```sh
export BRAIN="$HOME/brain"
PATH="$BRAIN/bin:$PATH"
```

Il profilo si legge al login; per la shell corrente basta
`. ~/.profile`. Se l'archivio non è stato creato con `init.sh`, lo
script va anche reso eseguibile:

```sh
chmod +x "$BRAIN/bin/capture"
```

## Esempi

```sh
capture "rivedere la dimostrazione della proprietà di Markov forte"
xclip -o -selection clipboard | capture  # la clipboard di X
man 1 sh | col -b | capture             # una pagina di manuale intera
```

Da un editor, basta mandare il testo allo script. In Vim, per esempio,
`:'<,'>w !capture` cattura la selezione visuale. È un esempio di
adattatore: comodo, ma lo script non ne sa nulla.

## Perché

**Nessuna decisione al momento della cattura.** Ogni decisione chiesta
nel momento sbagliato è un'occasione per rimandare, e un'idea rimandata
di solito è persa. Organizzare è un lavoro diverso, che si fa meglio a
mente fresca e in blocco.

**Shell POSIX.** Funziona su qualsiasi sistema simil-Unix senza
installare nulla, e fra dieci anni funzionerà ancora.

**Un contratto invece di uno strumento.** Definire la cattura come "un
file in `inbox/`" significa che posso aggiungere nuove vie di ingresso
senza toccare il resto del sistema.

## Collegamenti

- [Second brain](../areas/second-brain.md)
- [Nucleo e adattatori](nucleo-e-adattatori.md)
- [Formato delle note](formato-delle-note.md)
- [Istruzioni agent-agnostiche](istruzioni-agent-agnostiche.md)
