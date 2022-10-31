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

let ignore_spell_check = [ "c", "cpp", "perl", "python", "sh", "rust", "go", "typescript" ]
autocmd BufWinEnter * if index(ignore_spell_check, &filetype) < 0
      \ | set spell
      \ | endif

" remove preview when autocompleting
set completeopt-=preview

"Abreviatura
iabbr #i #include
iabbr #d #define

autocmd BufNewFile *.sh 0r ~/.vim/skeletons/bash.sh
autocmd BufNewFile *.py 0r ~/.vim/skeletons/python.py
autocmd BufNewFile *.pl 0r ~/.vim/skeletons/perl.pl

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
" inoremap <Nul> <C-x><C-n>

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
set smartcase

set path+=**


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
  set colorcolumn=120
endfunction
autocmd FileType go,c,cpp,perl,python,sh,gitcommit,markdown call s:color_column()

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

" open splits to the right
set splitright

"fugitive (shows git branch in the status line)
set statusline+=%{FugitiveStatusline()}

" Rust
let g:rustfmt_autosave = 1
let g:rustfmt_command = '/home/npernas/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustfmt'
let g:rustfmt_options = '--edition 2021'

" empty this list so cargo is not run when you open a file.
"let g:syntastic_rust_checkers = []
"autocmd BufRead *.rs :setlocal tags=./.rusty-tags;/,$RUST_SRC_PATH/rusty-tags.vi
"autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --output=.rusty-tags --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

" GO
"au filetype go inoremap <buffer> <Nul> <C-x><C-o>

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_imports_autosave = 0
let g:go_fmt_autosave = 1
let g:go_fmt_command = "golines"
let g:go_fmt_options = {
      \ 'golines': '--base-formatter=gofmt --max-len=120',
    \ }

" CoC
let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-go']
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=200

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.

nmap <C-t> <C-o>
nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-d> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-d>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-d>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
