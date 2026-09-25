" Adattatore Vim per il second brain.
" Uso: nel vimrc, dopo aver esportato BRAIN,
"   execute 'source' $BRAIN . '/editors/vim/brain.vim'

" Ricarica i file modificati da un agente mentre sono aperti.
set autoread
augroup brain
    autocmd!
    autocmd FocusGained,BufEnter,CursorHold * silent! checktime
    " A capo a 72 colonne nelle note dell'archivio.
    execute 'autocmd BufRead,BufNewFile ' . $BRAIN . '/*.md setlocal textwidth=72'
augroup END

" gf segue i link relativi senza configurazione: 'path' contiene gia'
" '.', cioe' la cartella del file corrente, e i link includono '.md'.
