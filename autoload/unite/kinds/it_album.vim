"=============================================================================
" FILE: unite/kinds/it_album.vim
" AUTHOR: Ryota Kato <ryotakato4@gmail.com>
" Last Modified: 2015 Jan 25
"=============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! unite#kinds#it_album#define() "{{{
  return s:kind
endfunction "}}}

let s:kind = {
      \ 'name' : 'it_album',
      \ 'default_action' : 'play',
      \ 'action_table' : {}
      \}

" Actions "{{{
let s:kind.action_table.play = {
      \ 'description' : 'play the album'
      \}

if has('mac')
  let s:command = "osascript " . expand('<sfile>:p:h') . "/play_album.applescript"
  function! s:kind.action_table.play.func(candidate) "{{{
    call system(s:command . " '" . a:candidate.action__id ."'")
  endfunction "}}}
elseif has('win32') || has('win64')
  let s:command = 'cscript /Nologo ' . substitute(expand('<sfile>:p:h') . "/it_album_play.js", "/", "\\", "g")
  function! s:kind.action_table.play.func(candidate) "{{{
    call system(s:command . ' ' . a:candidate.action__id)
  endfunction "}}}
endif
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: fdm=marker
