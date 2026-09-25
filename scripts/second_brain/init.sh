#!/bin/sh
# init.sh: crea un archivio second brain, o completa uno esistente
#
# uso:
#   init.sh [--claude] [--vim] [--docs] [--all] cartella
#
# Il nucleo (cartelle, AGENTS.md, workflows/, bin/) viene creato sempre;
# le opzioni aggiungono gli adattatori e le note di documentazione.
# La cartella è obbligatoria e può stare ovunque: si possono creare più
# archivi. Il primo diventa quello predefinito: in fondo a ~/.profile lo
# script aggiunge BRAIN e PATH, se BRAIN non c'è già.
# Nessun file esistente viene sovrascritto: rilanciare lo script è
# sempre sicuro.

set -eu

usage() {
    cat <<EOF
uso: $(basename "$0") [opzioni] cartella

  --claude   adattatore per Claude Code (CLAUDE.md, .claude/commands/)
  --vim      adattatore per Vim (editors/vim/brain.vim)
  --docs     note di documentazione del sistema (areas/, notes/)
  --all      tutte le opzioni precedenti
  -h         mostra questo aiuto

cartella: dove creare l'archivio (obbligatoria; se ne possono creare più d'uno)
EOF
}

die() {
    echo "init.sh: $*" >&2
    exit 1
}

tpl="$(cd "$(dirname "$0")" && pwd -P)/template"
[ -d "$tpl/core" ] || die "modelli non trovati in $tpl"

claude='' vim='' docs=''
while [ $# -gt 0 ]; do
    case $1 in
    --claude) claude=claude ;;
    --vim) vim=vim ;;
    --docs) docs=docs ;;
    --all) claude=claude vim=vim docs=docs ;;
    -h | --help)
        usage
        exit 0
        ;;
    -*) die "opzione sconosciuta: $1 (vedi -h)" ;;
    *) break ;;
    esac
    shift
done
[ $# -eq 1 ] || die "serve una cartella, e una sola (vedi -h)"
layers="core $claude $vim $docs"

dest=$1
[ ! -e "$dest" ] || [ -d "$dest" ] || die "$dest esiste e non è una cartella"
mkdir -p "$dest"
dest=$(cd "$dest" && pwd -P)
echo "archivio: $dest"

# cartelle del nucleo, anche vuote
for d in inbox notes projects areas journal archive/inbox workflows bin; do
    mkdir -p "$dest/$d"
done

# copia i file di un livello, senza mai sovrascrivere
copy_layer() {
    (cd "$tpl/$1" && find . -type f | sort) | while read -r f; do
        f=${f#./}
        if [ -e "$dest/$f" ]; then
            echo "  esiste, non toccato: $f"
        else
            mkdir -p "$dest/$(dirname "$f")"
            cp "$tpl/$1/$f" "$dest/$f"
            echo "  creato: $f"
        fi
    done
}

for l in $layers; do
    echo "[$l]"
    copy_layer "$l"
done

chmod +x "$dest"/bin/*

# git non traccia le cartelle vuote
for d in inbox notes projects areas journal archive/inbox; do
    if [ -z "$(ls -A "$dest/$d")" ]; then
        touch "$dest/$d/.gitkeep"
    fi
done

if [ -d "$dest/.git" ]; then
    echo "git: repository già presente"
elif command -v git >/dev/null 2>&1; then
    git -C "$dest" init -q
    echo "git: repository creato"
else
    echo "git: non installato, repository non creato" >&2
fi

# il primo archivio diventa quello predefinito: BRAIN e PATH in ~/.profile
profile="$HOME/.profile"
added='' other=''
if line=$(grep '^export BRAIN=' "$profile" 2>/dev/null); then
    case $line in
    *"\"$dest\""*) echo "profilo: questo è già l'archivio predefinito" ;;
    *)
        other=1
        echo "profilo: $profile ha già un archivio predefinito, non toccato"
        ;;
    esac
else
    added=1
    {
        echo
        echo "# second brain (aggiunto da init.sh)"
        echo "export BRAIN=\"$dest\""
        echo "PATH=\"\$BRAIN/bin:\$PATH\""
    } >>"$profile"
    echo "profilo: BRAIN e PATH aggiunti in fondo a $profile"
fi
if [ -e "$HOME/.bash_profile" ] || [ -e "$HOME/.bash_login" ]; then
    echo "profilo: attenzione, al login bash legge ~/.bash_profile (o ~/.bash_login) e non ~/.profile" >&2
fi

# prossimi passi, secondo le opzioni scelte
n=0
step() {
    n=$((n + 1))
    printf '\n  %d. %s\n' "$n" "$1"
}

echo
echo "Fatto. Prossimi passi:"

if [ -n "$added" ]; then
    step "rifare il login, o caricare subito il profilo nella shell corrente:"
    cat <<'EOF'

       . ~/.profile
EOF
fi

if [ -n "$other" ]; then
    step "questo archivio non è quello predefinito (\$BRAIN): i suoi script si lanciano con il percorso, per esempio:"
    cat <<EOF

       $dest/bin/capture "un'idea"
EOF
fi

if [ -n "$vim" ]; then
    step "nel vimrc, per caricare l'adattatore:"
    cat <<'EOF'

       execute 'source' $BRAIN . '/editors/vim/brain.vim'

     e, se si usa tmux, in ~/.tmux.conf:

       set -g focus-events on
EOF
fi

if [ -n "$claude" ]; then
    step "lanciare Claude Code dentro l'archivio: legge CLAUDE.md e offre /triage, /ask e /connect"
fi

step "rileggere AGENTS.md e completarlo con ciò che l'agente deve sapere"
step "primo commit:"
cat <<EOF

       cd "$dest" && git add -A && git commit -m "Archivio iniziale"
EOF
