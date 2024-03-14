"-- PRE OPTIONS {{{
let mapleader=','
let maplocalleader = '.'
"}}}

"-- PLUGINS {{{
" Install package manager
" https://github.com/junegunn/vim-plug/
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Git related plugins
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Detect tabstop and shiftwidth automatically
Plug 'tpope/vim-sleuth'

" Adds git related signs to the gutter
Plug 'airblade/vim-gitgutter'

" Theme inspired by Atom
Plug 'joshdick/onedark.vim'

" Set airline as statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" "gc" to comment visual regions/lines
Plug 'tpope/vim-commentary'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" PHP related
Plug 'StanAngeloff/php.vim'
Plug 'alvan/vim-php-manual'
let g:php_manual_online_search_shortcut = '<S-F1>'

call plug#end()
"}}}

"-- OPTIONS {{{
filetype plugin indent on
syntax on
set autoindent
set autoread
set backspace=indent,eol,start
set belloff=all
set breakindent
set cin
"set clipboard=unnamedplus
set completeopt=menuone,noselect
set display=lastline
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set fileencodings=utf-8
set hidden
set history=10000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅
set modeline
set modelines=10
"set mouse=a
let netrw_banner=0
let netrw_browse_split=0
let netrw_winsize=25
set nojoinspaces
set nonumber
set noshowmode
set nostartofline
set shiftwidth=4
set showcmd
set smartcase
set smartindent
set smarttab
set tabstop=4
set timeoutlen=300
set ttyfast

" Colours
syntax on
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
set background=dark
colorscheme codecourse
hi! Normal guibg=#1b1e28

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

" Speed improvements
set redrawtime=5000
syntax sync minlines=200
syntax sync maxlines=500
set synmaxcol=200
set nocursorline
set nocursorcolumn

"}}}

"-- KEYMAPS {{{

" clean search highlight
nnoremap <silent> <leader><esc> :noh<cr>
nnoremap <silent> <leader><space> :noh<cr>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Remap for dealing with word wrap
nnoremap <expr> <silent> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> <silent> j v:count == 0 ? 'gj' : 'j'

" splits
noremap <leader>h :<C-u>split<CR>
noremap <leader>v :<C-u>vsplit<CR>
nmap <leader>x :clo<cr>
nmap <leader>w <C-w>w
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>w
noremap <C-h> <C-w>W
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>

" others
vmap < <gv
vmap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" function keys
nnoremap <f1> K
nmap <f2> :below new<cr>
nmap <f3> :clo<cr>
set pt=<F4>
vmap <f5> gc
map <f7> <C-W>w
map <f9> :set list! list? <CR>
"}}}

"-- AUTOCMDS {{{
filetype on
au BufNewFile,BufRead *.ihtml set filetype=php
autocmd FileType php set kp=:help
au BufNewFile,BufRead *.volt set filetype=html
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType php setlocal shiftwidth=4 softtabstop=4 expandtab
"}}}

"-- FUNCTIONS {{{

" toggle windows layout between horiz & vert
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
nmap <leader>wl :call ToggleWinLayout()<cr>
map <f8> :call ToggleWinLayout()<cr>

" toggle line numbers
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
nmap <leader>ln :call ToggleNumbers()<cr>
map <f10> :call ToggleNumbers()<cr>

" update @modified on save
function! LastMod()
  if line("$") > 20
    let l = 20
  else
    let l = line("$")
  endif
  call cursor(1, 1)
  if search("@modified", 'W', l) > 0
    exe "1," . l . "g/@modified /s/@modified .*/@modified " . strftime("%d-%b-%Y")
  endif
endfun
autocmd BufWrite * ks|call LastMod()|'s
map <leader>mod :call LastMod()<cr>

"}}}

"-- PLUGINS CONFIG {{{

" airline {{{
let g:airline_theme = 'zenburn'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#tabline#enabled = 0
let g:airline_exclude_preview = 1
let g:airline_left_sep=''
let g:airline_powerline_fonts = 1
let g:airline_right_sep=''
let g:airline_skip_empty_sections = 1

if !exists('g:airline_symbols')
 let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  "let g:airline_left_sep = ''
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  "let g:airline_right_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif
"}}}

" gitgutter {{{
set updatetime=100
set signcolumn=yes
"}}}

" fugitive {{{
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Git commit --verbose<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Git<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>
"}}}

"}}}
