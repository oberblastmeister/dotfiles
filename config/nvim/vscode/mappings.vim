nnoremap <C-/> <Cmd>call VSCodeNotify('editor.action.startFindReplaceAction')<CR>
nnoremap <space>/ <Cmd>call VSCodeNotify('workbench.action.replaceInFiles')<CR>

xmap <space>c  <Plug>VSCodeCommentary
nmap <space>c  <Plug>VSCodeCommentary
omap <space>c  <Plug>VSCodeCommentary
nmap <space>cc <Plug>VSCodeCommentaryLine

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

nnoremap <space>w <Cmd>Write<CR>
nnoremap <space>W <Cmd>Wall<CR>

nnoremap <space>x <Cmd>Wq<CR>
nnoremap <space>X <Cmd>Wq!<CR>

nnoremap <space>o <Cmd>Only<CR>

inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-e> <End>
inoremap <C-a> <Home>

nnoremap <space>hr <Cmd>call VSCodeNotify('git.revertSelectedRanges')<CR>
nnoremap <space>hs <Cmd>call VSCodeNotify('git.stageSelectedRanges')<CR>
nnoremap <space>b <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
nnoremap <space>b <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>

nnoremap <S-Tab> <Cmd>call VSCodeNotify('editor.toggleFold')<CR>
nnoremap <silent> zM <Cmd>call VSCodeNotify('editor.foldAll')<CR>
nnoremap <silent> zR <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>