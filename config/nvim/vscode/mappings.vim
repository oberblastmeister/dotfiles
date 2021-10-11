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

nnoremap dp <Cmd>call VSCodeNotify('merge-conflict.accept.current')<CR>
nnoremap dg <Cmd>call VSCodeNotify('merge-conflict.accept.incoming')<CR>
nnoremap db <Cmd>call VSCodeNotify('merge-conflict.accept.both')<CR>
nnoremap dD <Cmd>call VSCodeNotify('merge-conflict.compare')<CR>

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

nnoremap <space>= <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>
nnoremap <space>a <Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<CR>
nnoremap <space>l <Cmd>call VSCodeNotify('codelens.showLensesInCurrentLine')<CR>

nnoremap <space><space> <Cmd>call VSCodeNotify('editor.action.openLink')<CR>

nnoremap <space>q <Cmd>Quit<CR>
nnoremap <space>Q <Cmd>Quit!<CR>

nnoremap <S-Tab> <Cmd>call VSCodeNotify('editor.toggleFold')<CR>
nnoremap <silent> zM <Cmd>call VSCodeNotify('editor.foldAll')<CR>
nnoremap <silent> zR <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>

xnoremap K <Cmd>call VSCodeNotifyVisual('editor.action.showHover', 1)<CR>