"Pathogen install:
"mkdir -p ~/.vim/autoload ~/.vim/bundle; \
"curl -Sso ~/.vim/autoload/pathogen.vim \
"https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

call pathogen#infect('bundle/{}')
call pathogen#helptags()

set nocompatible " Activar funcionalidades extras del vim
set vb " Desactivar pitido del sistema
set autoindent " Activar autoindentado
set expandtab "Convertir tabulaciones en espacios
set tabstop =4 "Tamanio tabulacion
set sm "Muestra llave/parentesis de comienzo al escribir el del final
set sw =4 "Idem tabstop
set number "Numerar filas
set wrap "Evita el scroll horizontal con lineas muy largas
set autoread " auto reloads the file if it's been changed from the outside

" Codificacion
set encoding=utf-8

" Visualizacion
"set background = dark
syntax enable " Activar sintaxis: coloreado, etc

"Abreviatura
abbr #i #include
abbr #d #define
abbr ddperl #!/usr/bin/perl<CR><CR>use strict;<CR>use warnings;<CR>
abbr ddbash #!/bin/bash
abbr ddpython #!/usr/bin/python
abbr ddtest void test () {<CR><CR>}

" disable auto comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Historial de lineas
set history=500

"--- Teclas de funciones ---
map <F1>  :q<CR>
map <F2>  :w<CR>
map <F3>  :q!<CR>
map <F4>  :set paste<CR>
map <F5>  :set nopaste<CR>
map <F10> :%s/\/\/\(.*\)/\/\*\1\*\//g<CR> 
map <F9>  :s/^\(.*\)$/<!-- \1 -->/<CR>
nnoremap <Tab> :tabnext<CR> 
nnoremap <S-Tab> :tabprev<CR>
" Autocomplete with Ctrl-Space like Eclipse :)
inoremap <Nul> <C-n>

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler 

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Better command-line completion
set wildmenu

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" Be smart when using tabs ;)
set smarttab

" Set to auto read when a file is changed from the outside
set autoread

" VimTip 80: Restore cursor to file position in previous editing session
" for unix/linux/solaris
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

:highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
:set colorcolumn=80

" Disable visual bell
set novisualbell

au BufRead,BufNewFile *.eyp set filetype=perl
