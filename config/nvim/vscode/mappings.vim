" vendor this for now
function! VSCodeNotifyVisual(cmd, leaveSelection, ...)
    let mode = mode()
    if mode ==# 'V'
        let startLine = line('v')
        let endLine = line('.')
        call VSCodeNotifyRange(a:cmd, startLine, endLine, a:leaveSelection, a:000)
    elseif mode ==# 'v' || mode ==# "\<C-v>"
        let startPos = getpos('v')
        let endPos = getpos('.')
        call VSCodeNotifyRangePos(a:cmd, startPos[1], endPos[1], startPos[2], endPos[2] + 1, a:leaveSelection, a:000)
    else
        call VSCodeNotify(a:cmd, a:000)
    endif
endfunction

nnoremap c* <Cmd>call VSCodeNotify('editor.action.changeAll')<CR>

" nnoremap dp <Cmd>call VSCodeNotify('merge-conflict.accept.current')<CR>
" nnoremap dg <Cmd>call VSCodeNotify('merge-conflict.accept.incoming')<CR>
" nnoremap db <Cmd>call VSCodeNotify('merge-conflict.accept.both')<CR>
" nnoremap dD <Cmd>call VSCodeNotify('merge-conflict.compare')<CR>

nnoremap ]g <Cmd>call VSCodeNotify('editor.action.marker.next')<CR>
nnoremap [g <Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>
nnoremap ]G <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
nnoremap [G <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>
nnoremap ]c <Cmd>call VSCodeNotify('merge-conflict.next')<CR>
nnoremap [c <Cmd>call VSCodeNotify('merge-conflict.previous')<CR>
nnoremap ]h <Cmd>call VSCodeNotify('workbench.action.editor.nextChange')<CR>
nnoremap [h <Cmd>call VSCodeNotify('workbench.action.editor.previousChange')<CR>
nnoremap ]H <Cmd>call VSCodeNotify('workbench.action.compareEditor.nextChange')<CR>
nnoremap [H <Cmd>call VSCodeNotify('workbench.action.compareEditor.previousChange')<CR>

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
nnoremap ]d <Cmd>call VSCodeNotify('editor.debug.action.goToNextBreakpoint')<CR>
nnoremap [d <Cmd>call VSCodeNotify('editor.debug.action.goToPreviousBreakpoint')<CR>

nnoremap <space>= <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>
nnoremap <space>a <Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<CR>
nnoremap <space>l <Cmd>call VSCodeNotify('codelens.showLensesInCurrentLine')<CR>
nnoremap <space><S-/> <Cmd>call VSCodeNotify('workbench.action.replaceInFiles')<CR>
nnoremap <space>/ <Cmd>call VSCodeNotify('search.action.openNewEditor')<CR>
nnoremap <space>lr <Cmd>call VSCodeNotify('editor.action.rename')<CR>
nnoremap <space>b <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>

nnoremap <space><space> <Cmd>call VSCodeNotify('editor.action.openLink')<CR>

nnoremap <space>w <Cmd>Write<CR>
nnoremap <space>q <Cmd>call VSCodeNotify('workbench.action.closeEditorsInGroup')<CR>

nnoremap <silent> zM <Cmd>call VSCodeNotify('editor.foldAll')<CR>
nnoremap <silent> zR <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>

xnoremap K <Cmd>call VSCodeNotifyVisual('editor.action.showHover', 1)<CR>

nnoremap gy <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
nnoremap gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
" nmap o A<cr>

" for some reason this is not on by default, check changelog for
" vscode-neovim, they enabled auto indent for some reason
" filetype indent off


" lua << EOF
" vim.api.nvim_create_augroup('YankHighlight', { clear = true })
" vim.api.nvim_create_autocmd('TextYankPost', {
"   group = 'YankHighlight',
"   callback = function()
"     vim.highlight.on_yank({ higroup = 'Visual', timeout = '250' })
"   end
" })
" EOF
