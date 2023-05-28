" ============================================================================
" Settings {{{
" ============================================================================

" treesitter folding
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99 " open all folds when starting to edit buffer

" set timeoutlen=800
" set ttimeoutlen=20

" number of lines kept in terminal buffer
set scrollback=50000

set pumheight=20

" set pumblend=15
" set winblend=0

" no splash screen and shorter messages
set shortmess+=I " no intro
set shortmess+=O
" I think one thing that contributes to vscode's completion being more smooth in my opinion than comparable neovim engines is that the completion popup will follow the cursor which is very nice. It also starts up much quicker than compe. I think it throttles trailing instead of leading.
" I think one thing that contributes to vscode's completion being more smoothe in my opinion is that
set shortmess+=a   " use abbreviations
set shortmess+=W   " dont' echo written when writing, lightline already has symbol
set shortmess+=T
set shortmess+=A   " no swapfile messages
set path+=**

" faster async updates
" set updatetime=500

" do not pass messages to ins-completion-menu
set shortmess+=c

set signcolumn=yes " always show sign column so it doesn't drift

" guistuff
" set guifont=FiraCode\ Nerd\ Font:h11:style=Retina " set guifont
" set guifont=FiraCode\ Nerd\ Font:h12
" set guifont=FiraCode\ Nerd\ Font:10
" set guifont=OperatorMono\ Nerd\ Font:h18:style=Medium

" set default spell checking language (when spell checking is on)
set spelllang=en_us

" set spell file directory
set spellfile=$HOME/Sync/vim/spell/en_us.utf-8.add

set conceallevel=1
" }}}

set title " set the title of the window
