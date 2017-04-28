execute pathogen#infect()
" To install new plugins just run:
" cd ~/.vim/bundle && git clone git://github.com/plugin.git

set nocompatible " Activar funcionalidades extras del vim
set vb " Desactivar pitido del sistema
set autoindent " Activar autoindentado
set tabstop=4 "Tamanio tabulacion
set shiftwidth=4
set sm "Muestra llave/parentesis de comienzo al escribir el del final
set number "Numerar filas
"set wrap "Evita el scroll horizontal con lineas muy largas
set autoread " auto reloads the file if it's been changed from the outside
"set textwidth=80 " add a new line after 80  chars automatically
set ls=2 " Display file name
set tabpagemax=100

" Codificacion
set encoding=utf-8

" Visualizacion
"set background = dark
syntax enable " Activar sintaxis: coloreado, etc

"Abreviatura
abbr #i #include
abbr #d #define
abbr ddperl #!/usr/bin/perl<CR><CR>use strict;<CR>use warnings;<CR>
abbr ddbash #!/bin/bash<CR>set -e<CR>set -u<CR>
abbr ddpython #!/usr/bin/python
abbr ddtest void test () {<CR><CR>}

" disable auto comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Historial de lineas
set history=500

"--- Teclas de funciones ---
map <F1>  :set paste<CR>
map <F2>  :set nopaste<CR>
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprev<CR>
nnoremap <F3> <C-]>

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
au BufRead,BufNewFile *.lds set filetype=ld

" Highlight trailing white spaces
autocmd FileType * match Error /\s\+$/

" Remove trailing white spaces on save
autocmd BufWritePre * :%s/\s\+$//e

function s:LinuxKeywords()
    syn keyword cOperator likely unlikely
    syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64
endfunction
autocmd FileType c,cpp call s:LinuxKeywords()
