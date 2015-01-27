"=============================================================================
" FILE: unite/kinds/it_artist.vim
" AUTHOR: Ryota Kato <ryotakato4@gmail.com>
" Last Modified: 2015 Jan 27
"=============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! unite#kinds#it_artist#define() "{{{
  return s:kind
endfunction "}}}

let s:kind = {
      \ 'name' : 'it_artist',
      \ 'default_action' : 'play',
      \ 'action_table' : {}
      \}

" Actions "{{{
let s:kind.action_table.play = {
      \ 'description' : 'play the artist'
      \}

if has('mac')
  let s:command = "osascript " . expand('<sfile>:p:h') . "/play_artist.applescript"
  function! s:kind.action_table.play.func(candidate) "{{{
    call system(s:command . " '" . a:candidate.action__id ."'")
  endfunction "}}}
elseif has('win32') || has('win64')
  let s:command = 'cscript /Nologo ' . substitute(expand('<sfile>:p:h') . "/it_artist_play.js", "/", "\\", "g")
  function! s:kind.action_table.play.func(candidate) "{{{
    call system(s:command . ' ' . a:candidate.action__id)
  endfunction "}}}
endif
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: fdm=marker
