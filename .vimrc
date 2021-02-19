" PlugInstall to install all plugins

set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

"test configs, at .vim dir
"runtime vim_test 
"runtime rails_plugins
"runtime qt_plugins

"Common 
" Complete engine
" Run after install in plugin install  python3 install.py --all 
Plug 'ycm-core/YouCompleteMe'
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Shougo/denite.nvim'
Plug 'tpope/vim-surround'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'jiangmiao/auto-pairs'
"git helper
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-endwise'
" cow at start
Plug 'mhinz/vim-startify'

"colorscheme
Plug 'beigebrucewayne/hacked_ayu.vim'
Plug 'jpo/vim-railscasts-theme'

"cool status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

"emmet key to use
let g:user_emmet_expandabbr_key = '<C-a>,'

set splitright

"alias for w as W
cnoreabbrev W w
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Q q

" remove all buf expect one
command! BufOnly execute '%bdelete|edit #|normal `"'

" shortcut for nerdtree
nmap <C-n> :NERDTreeToggle<CR>

" for deoplete plugin; change arrow keys to j k
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

"jj for Esc replace
imap jj <Esc>

set number relativenumber       " Display line numbers
set nobackup                    " No auto backups
set clipboard=unnamedplus       " Copy/paste between vim and other programs.
set noswapfile                  " No swap

" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" Always show statusline
set laststatus=2

syntax on
filetype plugin indent on
				
"theme
set background=dark 
colorscheme railscasts

set foldmethod=syntax
set foldnestmax=1
set foldlevel=99

set cursorline
      
"paste key
set pastetoggle=<F10>

" tab width
set tabstop=4
set shiftwidth=4
set expandtab

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

"airline customize
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='luna'
let g:airline_powerline_fonts = 1

set showcmd

"enable reading configs from project directories
set exrc
set secure
