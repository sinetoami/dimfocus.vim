"=============================================================================
" File: dimfocus.vim
" Author: Sinésio Neto (sinetoami) <https://github.com/sinetoami>
" License: MIT license
"=============================================================================
let s:blacklist = { 
      \ 'buffername': ['__LanguageClient__'],
      \ 'filetype': ['diff', 'fugitiveblame', 'undotree', 'qf', 'quickfix'],
      \}

function! s:blacklist.add(dict)
  for [akey, avalues] in items(a:dict)
    for aitem in avalues
      if index(self[akey], aitem) < 0
        call add(self[akey], aitem)
      endif
    endfor
  endfor
endfunction

function! s:get_spell_settings() abort
  return {
        \   'spell': &l:spell,
        \   'spellcapcheck': &l:spellcapcheck,
        \   'spellfile': &l:spellfile,
        \   'spelllang': &l:spelllang
        \ }
endfunction

function! s:set_spell_settings(settings) abort
  let &l:spell=a:settings.spell
  let &l:spellcapcheck=a:settings.spellcapcheck
  let &l:spellfile=a:settings.spellfile
  let &l:spelllang=a:settings.spelllang
endfunction

if exists('g:dimfocus#blacklist')
  call s:blacklist.add(g:dimfocus#blacklist)
endif

function! dimfocus#should_colorcolumn() abort
  if index(s:blacklist.buffername, bufname(bufnr('%'))) != -1
    return 0
  endif
  return index(s:blacklist.filetype, &filetype) == -1
endfunction

function! dimfocus#focus_window() abort
  if dimfocus#should_colorcolumn()
    let l:settings=s:get_spell_settings()
    if exists('w:dimfocus_matches')
      for l:match in w:dimfocus_matches
        try
          call matchdelete(l:match)
        catch /.*/
          " In testing, not getting any error here, but being ultra-cautious.
        endtry
      endfor
      let w:dimfocus_matches=[]
    endif
    call s:set_spell_settings(l:settings)
  endif
endfunction

function! dimfocus#blur_window() abort
  if dimfocus#should_colorcolumn()
    let l:settings=s:get_spell_settings()
    if !exists('w:dimfocus_matches')
      " Instead of unconditionally resetting, append to existing array.
      " This allows us to gracefully handle duplicate autocmds.
      let w:dimfocus_matches=[]
    endif
    let l:height=&lines
    let l:slop=l:height / 2
    let l:start=max([1, line('w0') - l:slop])
    let l:end=min([line('$'), line('w$') + l:slop])
    while l:start <= l:end
      let l:next=l:start + 8
      let l:id=matchaddpos(
            \   'DimFocus',
            \   range(l:start, min([l:end, l:next])),
            \   1000
            \ )
      call add(w:dimfocus_matches, l:id)
      let l:start=l:next
    endwhile
    call s:set_spell_settings(l:settings)
  endif
endfunction
