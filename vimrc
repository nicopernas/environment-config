execute pathogen#infect()
execute pathogen#helptags()

" To install new plugins just run:
" cd ~/.vim/bundle && git clone git://github.com/plugin.git

set nocompatible " Activar funcionalidades extras del vim
set vb " Desactivar pitido del sistema
set autoindent " Activar autoindentado
set sm "Muestra llave/parentesis de comienzo al escribir el del final
set number "Numerar filas
"set wrap "Evita el scroll horizontal con lineas muy largas
"set textwidth=80 " add a new line after 80  chars automatically
set ls=2 " Display file name
set tabpagemax=100

filetype plugin indent on
" On pressing tab, insert 4 spaces
set tabstop=2 shiftwidth=2 expandtab

" Codificacion
set termencoding=utf-8 encoding=utf-8

set backupdir=~/.vim/backup/
set directory=~/.vim/swap
set undodir=~/.vim/undo

" auto reloads the file if it's been changed from the outside
set autoread
au CursorHold,CursorHoldI * checktime
set updatetime=1000

" Visualizacion
set background=dark
color desert
syntax enable " Activar sintaxis: coloreado, etc

"Abreviatura
abbr #i #include
abbr #d #define
abbr ddperl #!/usr/bin/env perl<CR><CR>use strict;<CR>use warnings;<CR>
abbr ddbash #!/bin/bash<CR>set -euo pipefail<CR>
abbr ddpython #!/usr/bin/env python3
abbr ddtest void test () {<CR><CR>}

" disable auto comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Historial de lineas
set history=500

" Ctrl-b toggles paste mode. Works in normal mode.
map <C-b>  :set paste! paste?<CR>

" Ctrl-e toggles wrap mode. Works both normal and insert mode.
map <C-e> :set wrap! wrap?<CR>
imap <C-e> <C-O><C-e>

nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprev<CR>

" Autocomplete with Ctrl-Space to autocomplete with local ocurrences:)
inoremap <Nul> <C-x><C-n>

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
hi Search ctermbg=Yellow
hi Search ctermfg=Red

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
set ignorecase

set path+=**,~/.conan/data


let g:netrw_banner=0        " disable banner
let g:netrw_browse_split=3  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
" hide gitignore'd files
let g:netrw_list_hide=netrw_gitignore#Hide()
" hide dotfiles by default (this is the string toggled by netrw-gh)
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'


" VimTip 80: Restore cursor to file position in previous editing session
" for unix/linux/solaris
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

highlight ColorColumn ctermbg=lightgrey guibg=lightgrey ctermfg=red guifg=red
set colorcolumn=80

" Disable visual bell
set novisualbell

au BufRead,BufNewFile *.eyp set filetype=perl
au BufRead,BufNewFile *.lds set filetype=ld

" Highlight trailing white spaces
autocmd FileType * match Error /\s\+$/

" Remove trailing white spaces on save
autocmd BufWritePre * :%s/\s\+$//e

" run clan-format on all C/C++ sources when saving
function s:run_clang_format()
  silent exec "!clang-format -i -style=file " . bufname("%")
endfunction
autocmd BufWritePost *.c,*.h,*.cpp,*.hpp call s:run_clang_format()


" run autopep8 on all python sources when saving
function s:run_autopep8()
  silent exec "!autopep8 -i " . bufname("%")
endfunction
autocmd BufWritePost *.py call s:run_autopep8()



function s:LinuxKeywords()
    syn keyword cOperator likely unlikely
    syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64
endfunction
autocmd FileType c,cpp call s:LinuxKeywords()

set mouse=a

" syntastic
set statusline+=%F
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers=['flake8']

nnoremap <F9> :SyntasticToggleMode<CR>

" gutentags
set statusline+=%{gutentags#statusline()}
let g:gutentags_cache_dir = '/home/npernas/.my_tags'

" ctrlp
let g:ctrlp_user_command = [
  \ '.git',
  \ 'cd %s && git ls-files . -co --exclude-standard',
  \ 'find %s -type f'
  \ ]

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }

let g:ctrlp_buffer_func = { 'enter': 'BrightHighlightOn' }
function BrightHighlightOn()
  hi cursorline cterm=none ctermbg=darkred ctermfg=white
  set nocursorline
endfunction

set tags=./tags,tags;$HOME
