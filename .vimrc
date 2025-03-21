" zo to open a single fold under the cursor.
" zc to close the fold under the cursor.
" zR to open all folds.
" zM to close all folds.

" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')
" 
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
" Plug 'sheerun/vim-polyglot'
" 
call plug#end()

" }}}

" CONFIGURATION ------------------------------------------------------------- {{{
set nocompatible 	" Disable compatibility with vi
filetype on 		" Enable type file detection
filetype plugin on 	" Enable plugins and load plugin for the detected file type
filetype indent on 	" Load an indent file for the detected file type
syntax on 		" Turn syntax highlighting on
set number 		" Add numbers to each line on the left-hand side
set cursorline 		" Highlight cursor line underneath the cursor horizontally
set shiftwidth=4	" Set shift width to 4 spaces
set tabstop=4 		" Set tab width to 4 columns
" set expandtab 	" Use space characters instead of tabs
set nobackup 		" Do not save backup files.
" set scrolloff=10 	" Do not let cursor scroll below or above N number of lines when scrolling.
" set nowrap 		" Do not wrap lines. Allow long lines to extend as far as the line goes.
set incsearch 	" While searching though a file incrementally highlight matching characters as you type.
set ignorecase 		" Ignore capital letters during search.
set smartcase 		" This will allow you to search specifically for capital letters.
set showcmd 		" Show partial command you type in the last line of the screen.
set showmode 		" Show the mode you are on the last line.
set showmatch 		" Show matching words during a search.
set hlsearch 		" Use highlighting when doing a search.
set history=1000 	" Set the commands to save in history default number is 20
set wildmenu 		" Enable auto completion menu after pressing TAB.
set wildmode=list:longest " Make wildmenu behave like similar to Bash completion.
" set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx " Wildmenu will ignore files with these extensions.
set mouse=a
set clipboard=unnamedplus
color slate
set splitright
set shell=zsh
set signcolumn=no

" augroup CursorLine
"   au!
"   au VimEnter,WinEnter,BufWinEnter * setlocal nocursorline
"   au WinLeave * setlocal nocursorline
" augroup END

hi Folded term=standout ctermfg=4 ctermbg=None guifg=DarkBlue guibg=LightGrey
" hi Cursorline ctermfg=None ctermbg=None
hi Visual ctermbg=darkgray

" }}}

" MAPPINGS --------------------------------------------------------------- {{{

" See :help key-notation 
nnoremap <ESC> <ESC> :nohlsearch<CR>

" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w><
noremap <c-right> <c-w>>
" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{
if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" You can split a window into sections by typing `:split` or `:vsplit`.  " Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline 
    autocmd WinEnter * set cursorline 
augroup END

let g:lsp_diagnostics_enabled = 0
let g:lsp_document_highlight_enabled = 0

" fun! GitBranch(file)
"     let l:dir = fnamemodify(system('readlink -f ' . a:file), ':h')
"     let l:cmd = 'git -C ' . l:dir . ' branch --show-current 2>/dev/null'
"     let b:git_current_branch = trim(system(l:cmd))
" endfun
" 
" augroup GitBranch
"     autocmd!
"     autocmd BufEnter,ShellCmdPost,FileChangedShellPost * call GitBranch(expand('%'))
" augroup END

" }}}

" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
" set statusline+=%{StatuslineGit()}
" set statusline+=\ %{b:git_current_branch}\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2

" }}}
