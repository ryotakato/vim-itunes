"=============================================================================
" FILE: it_artist.vim
" AUTHOR: Ryota Kato <ryotakato4@gmail.com>
" Last Modified: 2015 Jan 27
" Version: 0.1
"=============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! unite#sources#it_artist#define()
  return s:source_it_artist
endfunction

let s:source_it_artist = {
      \ 'name' : 'it_artist',
      \ 'description' : 'candidates from artists in iTunes Library',
      \}

if has('mac')
  let s:command = 'osascript ' . expand('<sfile>:p:h') . "/it_artist.applescript"
elseif has('win32') || has('win64')
  let s:command = 'cscript /Nologo ' . expand('<sfile>:p:h') . "/it_artist.js"
endif

function! s:source_it_artist.gather_candidates(args, context) "{{{
  if unite#util#has_vimproc()
    let artists = split(vimproc#system(s:command), "\n")
  else
    let artists = split(system(s:command), "\n")
  endif
  
  let result = []
  for artist in artists
    let result += [{
          \ 'word' : artist,
          \ 'kind' : 'it_artist',
          \ 'action__id' : artist
          \}]
  endfor
  return result
endfunction "}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: fdm=marker
