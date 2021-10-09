nnoremap c* <Cmd>call VSCodeNotify('editor.action.changeAll')<CR>

" xmap <space>c  <Plug>VSCodeCommentary
" nmap <space>c  <Plug>VSCodeCommentary
" omap <space>c  <Plug>VSCodeCommentary
" nmap <space>cc <Plug>VSCodeCommentaryLine
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

nnoremap <C-j> <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
xnoremap <C-j> <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
nnoremap <C-k> <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
xnoremap <C-k> <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
nnoremap <C-h> <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
xnoremap <C-h> <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
nnoremap <C-l> <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
xnoremap <C-l> <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>

nnoremap ]g <Cmd>call VSCodeNotify('editor.action.marker.next')<CR>
nnoremap [g <Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>
nnoremap ]G <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
nnoremap [G <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>

nnoremap gy <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
nnoremap gD <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
nnoremap <space>= <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>
nnoremap <space>rn <Cmd>call VSCodeNotify('editor.action.rename')<CR>
nnoremap <space>a <Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<CR>
nnoremap <space>l <Cmd>call VSCodeNotify('codelens.showLensesInCurrentLine')<CR>

nnoremap <space><space> <Cmd>call VSCodeNotify('editor.action.openLink')<CR>

nnoremap <space>q <Cmd>Quit<CR>
nnoremap <space>Q <Cmd>Quit!<CR>

nnoremap <S-Tab> <Cmd>call VSCodeNotify('editor.toggleFold')<CR>
nnoremap <silent> zM <Cmd>call VSCodeNotify('editor.foldAll')<CR>
nnoremap <silent> zR <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>