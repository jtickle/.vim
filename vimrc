"
" Jeff Tickle's .vimrc
"
" Vim configuration resource file.  Specifies desired
" behavior for the vim editor.
"

execute pathogen#infect()

set encoding=utf-8

set showmode          " Tell you if you're in insert mode
set tabstop=2         " Set the tabstop to 4 spaces
set shiftwidth=2      " Shiftwidth should match tabstop
set softtabstop=2     " Finally make backspace do what it's fucking supposed to
set expandtab         " Convert tabs to <tabstop> number of spaces
set wrap              " Do not wrap lines longer than the window
set number            " Always show line numbers
set wrapscan          " Wrap to the top of the file while searching
set ruler             " Show the cursor position all the time
set showmatch         " Show matching [] () {} etc...
set smartindent       " Let vim help you with your code indention
set autoindent        " Brent said do this
set smarttab          " This too
"set nohlsearch        " Don't highlight strings you're searching for
set formatoptions+=ro " Automatically insert the comment character when
                       " you hit <enter> (r) or o/O (o) in a block comment.
set backspace=2       " makes backspace work like you expect

set incsearch         " Search while typing the search string
set ignorecase        " Ignore case by default in searching because we are human

set textwidth=0       " Auto linebreak is more trouble than it's worth

" Make tab completion like bash
set wildmode=longest,list,full
set wildmenu

filetype plugin indent on

" In Javascript, only ever do one indent regardless of how many {{{
" happened in the previous line
let g:SimpleJsIndenter_BriefMode = 1

" Assume all Javascript is JSX because even if it's not a React project I won't
" be doing it any other way
let g:jsx_ext_required = 0

cabbrev tlo TlistOpen
cabbrev tlc TlistClose

" Literate Coffeescript
autocmd FileType litcoffee runtime ftplugin/coffee.vim

" In HTML, only indent two characters at a time, because that seems to be
" convention, also don't ever auto-linebreak
autocmd BufRead,BufNewFile *.htm* setlocal sw=2 sts=2 et textwidth=0
autocmd BufRead,BufNewFile *.tpl setlocal sw=2 sts=2 et textwidth=0

" Switch syntax highlighting on, when the terminal can support colors
if &t_Co > 2 || has("gui_running")
    syntax on
    " Change the highlight color for Comment and Special
    " to Cyan.  Blue is too dark for a black background.
    highlight Comment  term=bold ctermfg=cyan guifg=cyan
    highlight Special  term=bold ctermfg=cyan guifg=cyan
    highlight Constant term=bold ctermfg=red  guifg=cyan
endif

" Make vim turn *off* expandtab for files named Makefile or makefile
" We need the tab literal
autocmd BufNewFile,BufRead [Mm]akefile* set noexpandtab

" Make vim recognize a file ending in ".template" to be a C++ source file
autocmd BufNewFile,BufRead *.template set ft=cpp

" Make vim recognize y86 assembly files
autocmd BufNewFile,BufRead *.ys set ft=asm
autocmd BufNewFile,BufRead *.ys set nosmartindent

" Adds main program heading from Program Style Guidelines
function FileHeading() 
    let s:line=line(".") 
    call setline( s:line,"// Program:     ") 
    call append(  s:line,"// Author:      Your name") 
    call append(s:line+1,"// Date:        ".strftime("%b %d %Y")) 
    call append(s:line+2,"// Assignment:  ") 
    call append(s:line+3,"// Purpose:     ")
    call append(s:line+4,"//  ")
    call append(s:line+5,"// Input:       ")
    call append(s:line+6,"// Output:      ")
    call append(s:line+7,"// Related")
    call append(s:line+8,"// Files:       ")
    call append(s:line+9,"// Functions:   ")
    call append(s:line+10,"//              ")
    call append(s:line+11,"") 
    unlet s:line 
endfunction 

" Adds class heading from Program Style Guidelines
function ClassHeading()
    let s:line=line(".")
    call setline( s:line,"// Program Name:     ")
    call append(  s:line,"// Author:           Your name")
    call append(s:line+1,"// Date:             ".strftime("%b %d %Y"))
    call append(s:line+2,"// Assignment:       ")
    call append(s:line+3,"// Purpose:          ")
    call append(s:line+4,"// ")
    call append(s:line+5,"// Public class variables")
    call append(s:line+6,"//            ")
    call append(s:line+7,"// Public functions:")
    call append(s:line+8,"//            ")
    call append(s:line+9,"// Related files:")
    call append(s:line+10,"//            ")
    call append(s:line+11,"")
    unlet s:line
endfunction

" Adds function heading from Program Style Guidelines
function FunctionHeading()
    let s:line=line(".")
    call setline( s:line,"//****************************************************************************")
    call append(  s:line,"//  Function name:  ")
    call append(s:line+1,"//  Author:    Your name")
    call append(s:line+2,"//  Date:      ".strftime("%b %d %Y"))
    call append(s:line+3,"//  Purpose:   ")
    call append(s:line+4,"//  Params:    ")
    call append(s:line+5,"//             ")
    call append(s:line+6,"//  Returns:   ")
    call append(s:line+7,"//****************************************************************************")
    unlet s:line
endfunction

""""""""""
" Python "
""""""""""

function PythonTemplate()
  let s:line = line(".")
  call setline(s:line,   "# <one line - program's name and a brief idea of what it does.>")
  call append(s:line,    "# https://moderntinker.org/projects/")
  call append(s:line+1,  "# Copyright (C) <year>  <name of author>")
  call append(s:line+2,  "# ")
  call append(s:line+3,  "# This program is free software: you can redistribute it and/or modify")
  call append(s:line+4,  "# it under the terms of the GNU General Public License as published by")
  call append(s:line+5,  "# the Free Software Foundation, either version 3 of the License, or")
  call append(s:line+6,  "# (at your option) any later version.")
  call append(s:line+7,  "# ")
  call append(s:line+8,  "# This program is distributed in the hope that it will be useful,")
  call append(s:line+9 ,  "# but WITHOUT ANY WARRANTY; without even the implied warranty of")
  call append(s:line+10, "# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the")
  call append(s:line+11, "# GNU General Public License for more details.")
  call append(s:line+12, "# ")
  call append(s:line+13, "# You should have received a copy of the GNU General Public License")
  call append(s:line+14, "# along with this program.  If not, see <http://www.gnu.org/licenses/>.")
  call append(s:line+15, "")
endfunction

autocmd BufNewFile *.py execute PythonTemplate()
autocmd BufNewFile,BufRead *.py set tw=79

"""""""""""
" Pelican "
"""""""""""

function PelicanTemplate()
  let s:line = line(".")
  call setline(s:line, "")
  call append(s:line,   "########")
  call append(s:line+1, "")
  call append(s:line+2, ":date:     ")
  call append(s:line+3, ":modified: ")
  call append(s:line+4, ":tags:     ")
  call append(s:line+5, ":category: ")
  call append(s:line+6, ":slug:     ")
  call append(s:line+7, ":authors:  ")
  call append(s:line+8, ":summary:  ")
endfunction

" If editing reStructuredText, assume Pelican
autocmd BufNewFile *.rst execute PelicanTemplate()
autocmd BufNewFile,BufRead *.rst set tw=79

imap <F2>  <esc>mz:execute FileHeading()<enter>`zA
imap <F3>  <esc>mz:execute FunctionHeading()<enter>'zjA
imap <F4>  <esc>mz:execute ClassHeading()<enter>'zA
