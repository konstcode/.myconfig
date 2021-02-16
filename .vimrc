
set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ycm-core/YouCompleteMe'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'

Plug 'tpope/vim-rails'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

"cool status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'

"git helper PlugInstall
Plug 'tpope/vim-fugitive'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-cucumber'
Plug 'skalnik/vim-vroom'
Plug 'tpope/vim-endwise'
Plug 'ervandew/supertab'
Plug 'mhinz/vim-startify'
Plug 'beigebrucewayne/hacked_ayu.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'airblade/vim-gitgutter'
"Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'Shougo/denite.nvim'
Plug 'tpope/vim-surround'
Plug 'peterhoeg/vim-qml'
Plug 'fedorenchik/qt-support.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'rust-lang/rust.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
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

"ctrlspace need options
"set nocompatible
"set hidden
"set showtabline=0

set showcmd

"enable reading configs from project directories
set exrc
set secure
