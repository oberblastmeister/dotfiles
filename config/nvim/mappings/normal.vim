" noh - no highlight
nmap <esc> :noh <CR>

" add move keys to jumplist and also swap j and k with gj gk
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" delete inner line (without line break)
nmap dil ^D
nmap dal ^D"_dd

" paste without newline
nnoremap gP i<CR><Esc>PkJxJx
nnoremap gp a<CR><Esc>PkJxJx

nnoremap c* *Ncgn

nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h
