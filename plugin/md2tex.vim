" Generate LaTeX file from Markdown
" Author: mas9612 <mas9612@gmail.com>
" License: This file is placed in the public domain.

if exists("g:loaded_md2tex")
  finish
endif
let g:loaded_md2tex = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists(":Md2Tex")
  command! -nargs=0 Md2Tex :call md2tex#convertToTeX()
endif

if !exists(":Md2Pdf")
  command! -nargs=0 Md2Pdf :call md2tex#convertToPDF()
endif

let &cpo = s:save_cpo
unlet s:save_cpo
