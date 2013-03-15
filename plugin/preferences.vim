"
" Jeff Tickle's .vimrc
"
" Vim configuration resource file.  Specifies desired
" behavior for the vim editor.
"

set showmode          " Tell you if you're in insert mode
set tabstop=4         " Set the tabstop to 4 spaces
set shiftwidth=4      " Shiftwidth should match tabstop
set softtabstop=4     " Finally make backspace do what it's fucking supposed to
set expandtab         " Convert tabs to <tabstop> number of spaces
set wrap              " Do not wrap lines longer than the window
set number            " Always show line numbers
set wrapscan          " Wrap to the top of the file while searching
set ruler             " Show the cursor position all the time
set showmatch         " Show matching [] () {} etc...
set smartindent       " Let vim help you with your code indention
set autoindent        " Brent said do this
set smarttab          " This too
set nohlsearch        " Don't highlight strings you're searching for
set formatoptions+=ro " Automatically insert the comment character when
                       " you hit <enter> (r) or o/O (o) in a block comment.
set backspace=2       " makes backspace work like you expect

set incsearch         " Search while typing the search string
set ignorecase        " Ignore case by default in searching because we are human

" In Javascript, only ever do one indent regardless of how many {{{
" happened in the previous line
let g:SimpleJsIndenter_BriefMode = 1

cabbrev tlo TlistOpen
cabbrev tlc TlistClose

" In HTML, only indent two characters at a time, because that seems to be
" convention
autocmd BufRead,BufNewFile *.htm* setlocal sw=2 sts=2 et

filetype plugin indent on


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

" Adds HTML skeleton to file
function HTMLFrame()
    let s:line=line(".")
    call setline( s:line,"<!DOCTYPE html>")
    call append(  s:line,"<html>")
    call append(s:line+1,"  <head>")
    call append(s:line+2,"    <title></title>")
    call append(s:line+3,"  </head>")
    call append(s:line+4,"  <body>")
    call append(s:line+5,"    ")
    call append(s:line+6,"  </body>")
    call append(s:line+7,"</html>")
    unlet s:line
endfunction

" Adds PHP skeleton to file
function PHPFrame()
    let s:line=line(".")
    call setline( s:line,"<?php")
    call append(  s:line,"")
    call append(s:line+1,"/**")
    call append(s:line+2," * Description")
    call append(s:line+3," * @author Jeff Tickle <jtickle at tux dot appstate dot edu>")
    call append(s:line+4," */")
    call append(s:line+5,"")
    call append(s:line+6,"?>")
    unlet s:line
endfunction

" Adds Javascript skeleton to file
function JSFrame()
    let s:line = line(".")
    call setline(s:line, "define([")
    call append(s:line,  "], function() {")
    call append(s:line+1,"}")
    unlet s:line
endfunction

" If opening new C++ or C file, automatically insert program comments
autocmd BufNewFile *.C,*.c execute FileHeading()

" If opening new C/C++ header file, automatically insert class comments
autocmd BufNewFile *.h execute ClassHeading()

" If opening new HTML file, automatically insert a basic HTML skeleton
autocmd BufNewFile *.htm* execute HTMLFrame()

autocmd BufNewFile *.php* execute PHPFrame()
autocmd BufNewFile *.js* execute JSFrame()

imap <F2>  <esc>mz:execute FileHeading()<enter>`zA
imap <F3>  <esc>mz:execute FunctionHeading()<enter>'zjA
imap <F4>  <esc>mz:execute ClassHeading()<enter>'zA

function! RunPhpcs()
    let l:filename=@%
    let l:phpcs_output=system('phpcs --report=csv '.l:filename)
    let l:phpcs_list=split(l:phpcs_output, "\n")
    unlet l:phpcs_list[0]
    cexpr l:phpcs_list
    cwindow
    copen
endfunction

set efm+=\"%f\"\\,%l\\,%c\\,%t%*[a-zA-Z]\\,\"%m\"\\,%*[^\\,]\\,%*[^\\,]
command! Phpcs execute RunPhpcs()
