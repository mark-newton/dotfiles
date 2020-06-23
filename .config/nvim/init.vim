" Install
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vimplug_exists)
    if !executable("curl")
        echoerr "You have to install curl or first install vim-plug yourself!"
        execute "q!"
    endif
    echo "Installing Vim-Plug..."
    echo ""
    silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let g:not_finish_vimplug = "yes"
    autocmd VimEnter * PlugInstall
endif
if !isdirectory($HOME . "/.config/nvim/session")
    call mkdir($HOME . "/.config/nvim/session", "p", 0700)
endif
if !isdirectory($HOME . "/.config/nvim/undodir")
    call mkdir($HOME . "/.config/nvim/undodir", "p", 0700)
endif

" Basics
if has('vim_starting')
    set nocompatible
endif
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
set ttyfast
set backspace=indent,eol,start
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set hidden
set hlsearch
set incsearch
set ignorecase
set smartcase
set nobackup
set nowritebackup
set noswapfile
set fileformats=unix,dos,mac
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif
let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅
set smarttab
set autoindent
set smartindent
set cin
set noshowmode
set noerrorbells
set nowrap
set undodir=~/.config/nvim/undodir
set undofile
set scrolloff=8
set gcr=a:blinkon0
set scrolloff=3
set laststatus=2
set modeline
set modelines=10
nnoremap n nzzzv
nnoremap N Nzzzv

" Mappings
let mapleader = ","

" Plugins
call plug#begin(expand('~/.config/nvim/plugged'))
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'StanAngeloff/php.vim'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'davidcelis/vim-ariake-dark'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'mbbill/undotree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rayburgemeestre/phpfolding.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/CSApprox'
Plug 'vim-utils/vim-man'
Plug 'voldikss/vim-floaterm'
call plug#end()

" Source plugin configs
source $HOME/.config/nvim/init_plug_airline.vim
source $HOME/.config/nvim/init_plug_coc.vim
source $HOME/.config/nvim/init_plug_floaterm.vim
source $HOME/.config/nvim/init_plug_fugitive.vim
source $HOME/.config/nvim/init_plug_fzf.vim
source $HOME/.config/nvim/init_plug_gitgutter.vim
source $HOME/.config/nvim/init_plug_surround.vim
source $HOME/.config/nvim/init_plug_whichkey.vim

" Colours
source $HOME/.config/nvim/init_colour_yitzchok.vim

" Settings by filetype
filetype on
au BufNewFile,BufRead *.ihtml set filetype=php
au BufNewFile,BufRead *.volt set filetype=html
autocmd FileType coffee setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType php setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType php set kp=:help

" Function: to toggle windows layout between horiz & vert
let g:hwin=1
func! ToggleWinLayout()
    if (g:hwin)
        wincmd H
        let g:hwin=0
    else
        wincmd K
        let g:hwin=1
    endif
endfunc

" Function to toggle line numbers
let g:dnum=0
set nonumber
func! ToggleNumbers()
    if (g:dnum)
        set number! relativenumber!
        let g:dnum=0
    else
        set number relativenumber
        let g:dnum=1
    endif
endfunc

" Abbreviations
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Mappings: function keys (legacy)
nnoremap <f1> K
nmap <f2> :below new<cr>
nmap <f3> :clo<cr>
set pt=<F4>
map <f7> <C-W>w
map <f8> :call ToggleWinLayout()<cr>
map <f9> :set list! list? <CR>
map <f10> :call ToggleNumbers()<cr>

" Mappings: function key replacements
nmap <leader>ws :below new<cr>
nmap <leader>c :clo<cr>
nmap <leader>ww <C-w>w
nmap <leader>wl :call ToggleWinLayout()<cr>
nmap <leader>li :set list! list? <cr>
nmap <leader>ln :call ToggleNumbers()<cr>

" Mappings: general
map <C-n> :30Lex<CR>
nnoremap <leader>. :lcd %:p:h<CR>
"noremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader><space> :noh<cr>
nnoremap <leader>u :UndotreeShow<CR>
imap ii <Esc>

" Mappings: commenting
map <leader># :s/^/#/<CR>:nohlsearch<CR>
map <leader>/ :s/^/\/\//<CR>:nohlsearch<CR>
map <leader>" :s/^/\"/<CR>:nohlsearch<CR>
map <leader>- :s/^/--/<CR>:nohlsearch<CR>
map <f5> :s/^/\/\//<CR>:nohlsearch<CR>
map <f6> :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>

" Mappings: splits
noremap <leader>h :<C-u>split<CR>
noremap <leader>v :<C-u>vsplit<CR>
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>

" Mappings: visual blocks
vmap < <gv
vmap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Mappings: git
noremap <leader>ga :Gwrite<CR>
noremap <leader>gc :Gcommit<CR>
noremap <leader>gsh :Gpush<CR>
noremap <leader>gll :Gpull<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gb :Gblame<CR>
noremap <leader>gd :Gvdiff<CR>
noremap <leader>gr :Gremove<CR>
nnoremap <Leader>o :.Gbrowse<CR>

" Mappings: session
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" Copy/paste
if has('macunix')
    set clipboard=unnamed,unnamedplus
    vmap <C-x> :!pbcopy<CR>
    vmap <C-c> :w !pbcopy<CR><CR>
endif
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

" Folding
let php_folding=0
set foldnestmax=1
noremap <space> za
set nofoldenable  "*** disable folding on load - use zi command to toggle
au FileType php setl nofen

" Status line (legacy - not used if airline active)
set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P
set ttimeoutlen=50

" Search the first 20 lines for '@modified' and update with current date
function! LastMod()
    if line("$") > 20
        let l = 20
    else
        let l = line("$")
    endif
    exe "1," . l . "g/@modified /s/@modified .*/@modified " . strftime("%d-%b-%Y")
endfun
autocmd BufWrite * ks|call LastMod()|'s
