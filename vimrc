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
set autowrite
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

" Visualizacion
color evening
syntax enable
hi EndOfBuffer ctermfg=lightblue ctermbg=NONE cterm=NONE

" spell check
set spelllang=en_gb
set spellfile=~/.vim/spell/en.utf-8.add
hi clear SpellBad
hi SpellBad cterm=reverse

let ignore_spell_check = [ "c", "cpp", "perl", "python", "sh", "rust" ]
autocmd BufWinEnter * if index(ignore_spell_check, &filetype) < 0
      \ | set spell
      \ | endif

" remove preview when autocompleting
set completeopt-=preview

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

" Ctrl-s toggles spell check. Works in normal mode.
map <C-s>  :set spell! spell?<CR>

" Ctrl-e toggles wrap mode. Works both normal and insert mode.
map <C-e> :set wrap! wrap?<CR>
imap <C-e> <C-O><C-e>

nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprev<CR>

" Move lines up and down
nnoremap <c-j> :m .+1<CR>==
nnoremap <c-k> :m .-2<CR>==
inoremap <c-j> <Esc>:m .+1<CR>==gi
inoremap <c-k> <Esc>:m .-2<CR>==gi
vnoremap <c-j> :m '>+1<CR>gv=gv
vnoremap <c-k> :m '<-2<CR>gv=gv

" map <C-B> :%s/<Esc>[[0-9;]*[mKG]//g<CR>


" Autocomplete with Ctrl-Space to autocomplete with local occurrences:)
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

let g:markdown_fenced_languages = ['c', 'cpp', 'python', 'bash', 'vim', 'go']

" VimTip 80: Restore cursor to file position in previous editing session
" for unix/linux/solaris
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

function s:color_column()
  highlight ColorColumn ctermbg=lightgrey guibg=lightgrey ctermfg=red guifg=red
  set colorcolumn=80
endfunction
autocmd FileType c,cpp,perl,python,sh,gitcommit,markdown call s:color_column()

" Disable visual bell
set novisualbell

au BufRead,BufNewFile *.eyp set filetype=perl
au BufRead,BufNewFile *.lds set filetype=ld

" Highlight trailing white spaces
autocmd FileType * match Error /\s\+$/

" Remove trailing white spaces on save
autocmd BufWritePre * :%s/\s\+$//e

" code formatters ============
augroup formatters

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

augroup END
" code formatters ============

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
let g:syntastic_ignore_files=['^/usr/include/', '\.[ch]$', '\.[ch]pp$', '\.cc$']
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['c', 'cpp', 'python'],
                           \ 'passive_filetypes': ['java'] }

nnoremap <F9> :SyntasticToggleMode<CR>

" gutentags
set statusline+=%{gutentags#statusline()}
let g:gutentags_cache_dir = "~/.my_tags"
let g:gutentags_project_info = []

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

"fugitive
set statusline+=%{FugitiveStatusline()}

set tags=./tags,tags;$HOME

" Rust
let g:rustfmt_autosave = 1
let g:rustfmt_command = '/home/npernas/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustfmt'
let g:rustfmt_options = '--edition 2021'

" empty this list so cargo is not run when you open a file.
let g:syntastic_rust_checkers = []
autocmd BufRead *.rs :setlocal tags=./.rusty-tags;/,$RUST_SRC_PATH/rusty-tags.vi
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --output=.rusty-tags --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

" GO
au filetype go inoremap <buffer> <Nul> <C-x><C-o>

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_imports_autosave = 0
let g:go_fmt_autosave = 1
let g:go_fmt_command = "gofmt"

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Open files in new tabs
let NERDTreeCustomOpenArgs={'file':{'where': 't'}}

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
