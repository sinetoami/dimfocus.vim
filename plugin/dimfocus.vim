" ==========================================================================
" Plugin: dimfocus.vim
" Author: Sinésio Neto (sinetoami) <https://github.com/sinetoami>
" Version: 0.0.1 - 2019 Jul 01
" License: MIT
" Description: Propose to dim a inactive Vim window.
" ==========================================================================
if exists('g:loaded_dimfocus')
  finish
endif
let g:loaded_dimfocus = 1

let s:save_cpo = &cpo
set cpo&vim

let s:fg = get(g:, 'dimfocus#fg', ['gray', 'gray'])
let s:bg = get(g:, 'dimfocus#bg', ['darkred', 'darkred'])

if has('autocmd')
  function! s:DimFocus()
    augroup DimFocus
      autocmd!

      execute 'hi def DimFocus cterm=none ctermfg='.s:fg[1] . ' ctermbg='.s:bg[1] . ' gui=none guifg='s:fg[0] . ' guibg='.s:bg[0]      
      
      " Make current window more obvious by turning off/adjusting some features in non-current
      " windows.
      if exists('+winhighlight')
        autocmd BufEnter,FocusGained,VimEnter,WinEnter * set winhighlight=
        autocmd BufEnter,FocusGained,VimEnter,WinEnter * call dimfocus#focus_window()
        
	      autocmd FocusLost,WinLeave * set winhighlight=CursorLine:DimFocus,CursorLineNr:DimFocus,Search:DimFocus,IncSearch:DimFocus,Normal:DimFocus,NormalNC:DimFocus,SignColumn:DimFocus,EndOfBuffer:DimFocus,NonText:DimFocus
        autocmd FocusLost,WinLeave * call dimfocus#blur_window() 
      endif

    augroup END
  endfunction

  call s:DimFocus()
endif

let &cpo = s:save_cpo
unlet s:save_cpo
