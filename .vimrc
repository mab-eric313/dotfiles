" Minimalist .vimrc with LSP and lightweight diagnostics (gutter + echo only)

call plug#begin('~/.vim/plugged')

" Plugins
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'preservim/nerdtree'

call plug#end()

" BASIC SETTINGS ------------------------------------------------------------

set nocompatible
filetype plugin indent on
syntax on
set number
set shiftwidth=4
set tabstop=4
set encoding=utf-8
set completeopt=menuone,noinsert,noselect
set statusline=%f\ %y\ %m\ %r%=%l\:%c\ %p%%
set laststatus=2
set clipboard=unnamedplus
set mouse=a
set splitright
set splitbelow
set wildmenu
set wildmode=list:longest
if executable('zsh')
	set shell=zsh
else
	set shell=bash
endif

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

" ASYNCOMPLETE ---------------------------------------------------------------
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() : "\<CR>"

" VIM-LSP --------------------------------------------------------------------

if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': ['clangd', '--background-index=false', '--clang-tidy=false'],
        \ 'whitelist': ['c', 'cpp'],
        \ })
endif

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

" NerdTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" ENABLE ONLY GUTTER AND ECHO DIAGNOSTIC -------------------------------------
set signcolumn=yes
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

" Optional: Disable ALE entirely if installed
let g:ale_enabled = 0

" UI FIXES -------------------------------------------------------------------
" Gutter (signcolumn) background sama seperti normal background
set fillchars=vert:\│

highlight VertSplit guifg=#aaaaaa guibg=NONE ctermfg=0 ctermbg=white
highlight SignColumn guibg=NONE ctermbg=NONE

" Hindari highlight putih pada simbol LSP (seperti variabel)
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

set statusline+=%#ModeMsg#\ %{g:currentmode[mode()]}\ %#StatusLine#\ %f\ %m\ %r\ %y\ 

" Use a divider to separate the left side from the right side.
set statusline+=%=

set statusline+=\ %#PmenuSel#\ %l\:\%c\ \ %p%%

" Show the status on the second to last line.
set laststatus=2

" }}}
