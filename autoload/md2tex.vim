" Generate LaTeX file from Markdown
" Author: mas9612 <mas9612@gmail.com>
" License: This file is placed in the public domain.

let s:save_cpo = &cpo
set cpo&vim

let s:base_dir = expand('<sfile>:p:h:h')

function! md2tex#convertToTeX()
  if executable('pandoc') == 1
    let template = s:base_dir . '/autoload/templates/template.latex'
    let output = expand('%:r') . '.tex'
    let command = 'pandoc --listings -s --template=' . template . ' -o ' . output . ' ' . expand('%')
    call system(command)
  else
    echohl ErrorMsg
    echo 'To use Md2Tex command, please install pandoc.'
    echohl None
  endif
endfunction

function! md2tex#convertToPDF()
  if executable('latexmk') == 1
    call md2tex#convertToTeX()

    let tex = expand('%:r') . '.tex'
    if filereadable(tex)
      let command = 'latexmk ' . tex
      call system(command)
      call <SID>removeTemporaryFiles()
    endif
  else
    echohl ErrorMsg
    echo 'To use Md2Pdf command, please install pandoc.'
    echohl None
  endif
endfunction

function! s:removeTemporaryFiles()
  let command = "ls -1 | grep -Ev '(\.md|\.tex|\.pdf)$' | xargs rm"
  call system(command)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
