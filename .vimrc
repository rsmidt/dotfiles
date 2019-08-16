set nocompatible
filetype off

if has('nvim')
    call plug#begin('~/.local/share/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

Plug 'sk1418/HowMuch'
Plug 'joshdick/onedark.vim'
Plug 'lervag/vimtex'
Plug 'racer-rust/vim-racer'
Plug 'tpope/vim-dispatch'
Plug 'w0rp/ale'
Plug 'tpope/vim-dispatch'
Plug 'joshdick/onedark.vim'  
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go'
Plug 'tpope/vim-surround'
Plug 'peitalin/vim-jsx-typescript'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-sensible'
Plug 'jceb/vim-orgmode'

if executable('wal')
    Plug 'dylanaraps/wal.vim'
end

call plug#end()

filetype plugin indent on

if executable('wal')
    colorscheme wal
else
    colorscheme onedark
    set termguicolors
endif
    
" System
set background=dark
set showmode
set lazyredraw
set ttyfast
set wildignore+=*/tmp/*,*.so,*.swpr*.zip,*/venv/*,*/node_modules/*,*/dist/*     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
set backupcopy=yes
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Shortcuts
let mapleader = "\<Space>"
nnoremap <Leader>t :noautocmd vimgrep /TODO/j **/*<CR>:cw<CR>
nnoremap <Leader>w :wa<CR>
nnoremap <Leader>q :wq<CR>
inoremap <Leader>, <ESC><S-a>;
nnoremap <Leader>v9 vi)o``
nnoremap oo o<Esc>k
nnoremap OO O<Esc>j

autocmd FileType go nmap <Leader>d :GoDecls<CR>
autocmd FileType go nmap <Leader>D :GoDeclsDir<CR>
autocmd FileType go nmap <Leader>b :wa<CR>:GoBuild<CR>
autocmd FileType go nmap <Leader>a :wa<CR>:GoRun<CR>
autocmd FileType go nmap <Leader>m :wa<CR>:GoMetaLinter<CR>
autocmd FileType go nmap <Leader>i :wa<CR>:GoInstall<CR>

" Editor
set expandtab
set nowrap
set number
set tabstop=4
set shiftwidth=4
set numberwidth=1
set encoding=utf-8
syntax on

" Airline & Statusline
set laststatus=2

if has ('wal')
    let g:airline_theme = 'wal'
else
    let g:airline_theme = 'onedark'
end

let g:airline_powerline_fonts = 1

" Vim JSON
let g:vim_json_syntax_conceal = 0

" fzf
nnoremap <C-p> :Files<Cr>

" TODO
let maplocalleader = ','

" vim-go
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1

" ale
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'typescript': ['tslint'],
\}

" vimtex
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
