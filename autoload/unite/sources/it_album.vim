"=============================================================================
" FILE: it_album.vim
" AUTHOR: Ryota Kato <ryotakato4@gmail.com>
" Last Modified: 2015 Jan 25
" Version: 0.1
"=============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! unite#sources#it_album#define()
  return s:source_it_album
endfunction

let s:source_it_album = {
      \ 'name' : 'it_album',
      \ 'description' : 'candidates from albums in iTunes Library',
      \}

if has('mac')
  let s:command = 'osascript ' . expand('<sfile>:p:h') . "/it_album.applescript"
elseif has('win32') || has('win64')
  let s:command = 'cscript /Nologo ' . expand('<sfile>:p:h') . "/it_album.js"
endif

function! s:source_it_album.gather_candidates(args, context) "{{{
  if unite#util#has_vimproc()
    let albums = split(vimproc#system(s:command), "\n")
  else
    let albums = split(system(s:command), "\n")
  endif
  
  let result = []
  for album in albums
    let a = split(album, "\t")
    let result += [{
          \ 'word' : album,
          \ 'kind' : 'it_album',
          \ 'action__id' : a[0]
          \}]
  endfor
  return result
endfunction "}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: fdm=marker
