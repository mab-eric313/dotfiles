call plug#begin('~/.vim/plugged')

" Plugins
Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'

call plug#end()

" BASIC SETTINGS ------------------------------------------------------------

set nocompatible
filetype plugin indent on
syntax on
set number
set relativenumber
set shiftwidth=4
set tabstop=4
set encoding=utf-8
set completeopt=menuone,noinsert,noselect
set laststatus=2
set clipboard=unnamedplus
set mouse=a
set splitright
set splitbelow
set wildmenu
set wildmode=list:longest
color slate
if executable('zsh')
	set shell=zsh
else
	set shell=bash
endif

" Configure Netrw
let g:netrw_bufsettings = 'noma nomod relativenumber nobl nowrap ro'

" SEARCH ---------------------------------------------------------------------
set incsearch
set ignorecase
set smartcase
set showmatch
set hlsearch

" KEY MAPPINGS ---------------------------------------------------------------
nnoremap <silent> <space> :nohlsearch<CR>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w><
noremap <c-right> <c-w>>
nnoremap <leader><tab> :tabNext<CR>
nnoremap <leader><S-tab> :tabprevious<CR>
nnoremap <leader>b :Rexplore<CR>



" ASYNCOMPLETE ---------------------------------------------------------------
" let g:asyncomplete_auto_popup = 1
" let g:asyncomplete_auto_completeopt = 1
" let g:asyncomplete_min_chars = 4
" let g:asyncomplete_refresh_delay = 200

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() : "\<CR>"
"
" VIM-LSP --------------------------------------------------------------------
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('$HOME/.vim/vim-lsp.log')

if executable('clangd')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'allowlist': ['c', 'cpp'],
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(expand('%:p:h'))},
        \ })
endif

autocmd FileType c,cpp setlocal omnifunc=lsp#complete

if executable('pylsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_setup
    autocmd!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" LSP -------------------------------------
set signcolumn=yes
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_delay = 100
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_document_highlight_enabled = 1
let g:lsp_code_lens_enabled = 0
let g:lsp_signature_help_enabled = 0

" UI FIXES -------------------------------------------------------------------
highlight VertSplit guifg=#aaaaaa guibg=NONE ctermfg=0 ctermbg=white
highlight SignColumn guibg=NONE ctermbg=NONE

highlight LspReference ctermfg=white guifg=#000000 ctermbg=darkgray guibg=#444444
highlight Search term=reverse ctermfg=0 ctermbg=11 guibg=Yellow

" Statusline
let g:currentmode={
	\'n': 'NORMAL',
	\'i': 'INSERT',
	\'v': 'VISUAL',
	\'V': 'VISUAL-LINE',
	\"\<C-V>": 'VISUAL-BLOCK',
	\'R': 'REPLACE',
	\'c': 'COMMAND',
	\'t': 'TERMINAL'
	\}

" Clear status line when vimrc is reloaded.
set statusline=

set statusline+=%#ModeMsg#\ %{g:currentmode[mode()]}\ %#StatusLine#\ %t\ %m\ %r\ %y\ 

" Use a divider to separate the left side from the right side.
set statusline+=%=

set statusline+=\ %#PmenuSel#\ cur:\%l\|\last:\%L\ %p%%

" Show the status on the second to last line.
set laststatus=2

" }}}
