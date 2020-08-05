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

" Plugins
call plug#begin(expand('~/.config/nvim/plugged'))
if !exists('g:vscode')
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'ConradIrwin/vim-bracketed-paste'
  Plug 'mbbill/undotree'
  Plug 'itchyny/lightline.vim'
  Plug 'mengelbrecht/lightline-bufferline'
  Plug 'mhinz/vim-signify'
  Plug 'mhinz/vim-startify'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'ryanoasis/vim-devicons'
  "Plug 'vim-scripts/CSApprox'
  Plug 'vim-utils/vim-man'
  Plug 'voldikss/vim-floaterm'
  Plug 'sheerun/vim-polyglot'
  Plug 'StanAngeloff/php.vim'
  Plug 'arnaud-lb/vim-php-namespace'
  "Plug 'rayburgemeestre/phpfolding.vim'
  Plug 'theprimeagen/vim-be-good', { 'do': './install.sh' }

  "The following are for replacing COC with native nvim LSP
  "Plug 'neovim/nvim-lsp'
  "Plug 'nvim-lua/diagnostic-nvim'
  "Plug 'nvim-lua/completion-nvim'
  "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  "Plug 'Shougo/deoplete-lsp'
endif
call plug#end()

" Basics
"set iskeyword+=-                    " treat dash separated words as a word text object"
set formatoptions-=cro              " Stop newline continution of comments
if !exists('g:vscode')
  set binary
  set bomb
  set cin
  set encoding=utf-8
  set expandtab
  set fileencoding=utf-8
  set fileencodings=utf-8
  set fileformats=unix,dos,mac
  set gcr=a:blinkon0
  set hidden
  set hlsearch
  set ignorecase
  set lazyredraw
  set list
  set modeline
  set modelines=10
  set nobackup
  set cursorline
  set noerrorbells
  set noshowmode
  set noswapfile
  set nowrap
  set nowritebackup
  set pumheight=15
  set scrolloff=3
  set shiftwidth=2
  set signcolumn=yes
  set smartcase
  set smartindent
  set smarttab
  set tabstop=2 softtabstop=2
  set ttyfast
  set undodir=~/.config/nvim/undodir
  set undofile
  set synmaxcol=2048

  if exists('$SHELL')
    set shell=$SHELL
  else
    set shell=/bin/sh
  endif
  let g:session_directory = "~/.config/nvim/session"
  let g:session_autoload = "no"
  let g:session_autosave = "no"
  let g:session_command_aliases = 1
endif
nnoremap n nzzzv
nnoremap N Nzzzv

" Leader
let mapleader = ","

" Source configs
if exists('g:vscode')
  source $HOME/.config/nvim/init_vscode.vim
else
  source $HOME/.config/nvim/init_colours.vim
  source $HOME/.config/nvim/init_plug_coc.vim
  source $HOME/.config/nvim/init_plug_floaterm.vim
  source $HOME/.config/nvim/init_plug_fugitive.vim
  source $HOME/.config/nvim/init_plug_fzf.vim
  source $HOME/.config/nvim/init_plug_lightline.vim
  source $HOME/.config/nvim/init_plug_startify.vim
  source $HOME/.config/nvim/init_plug_surround.vim

  "The following are for replacing COC with native nvim LSP
  "source $HOME/.config/nvim/init_plug_lsp.vim
  "source $HOME/.config/nvim/init_plug_deoplete.vim
endif

" Speed improvements
set redrawtime=5000
syntax sync minlines=200
syntax sync maxlines=500
set synmaxcol=200
set nocursorline
set nocursorcolumn

" Wincent settings
scriptencoding utf-8
let s:middot='·'
let s:raquo='»'
let s:small_l='ℓ'
function! WincentFoldtext() abort
  let l:lines='[' . (v:foldend - v:foldstart + 1) . s:small_l . ']'
  let l:first=substitute(getline(v:foldstart), '\v *', '', '')
  let l:dashes=substitute(v:folddashes, '-', s:middot, 'g')
  return s:raquo . s:middot . s:middot . l:lines . l:dashes . ': ' . l:first
endfunction
set diffopt+=foldcolumn:0             " don't show fold column in diff view
set fillchars+=vert:\
if has('folding')
  if has('windows')
    set fillchars=diff:∙               " BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
    set fillchars+=fold:·              " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
    set fillchars+=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  endif
  if has('nvim-0.3.1')
    set fillchars+=eob:\              " suppress ~ at EndOfBuffer
  endif
  set foldmethod=manual               " default foldmethod - override in filetype settings
  set foldlevel=1
  set foldlevelstart=1
  set foldnestmax=2
  set foldtext=WincentFoldtext()
  set nofoldenable
endif

if !has('nvim')
  " Sync with corresponding nvim :highlight commands in ~/.vim/plugin/autocmds.vim:
  set highlight+=@:Conceal            " ~/@ at end of window, 'showbreak'
  set highlight+=D:Conceal            " override DiffDelete
  set highlight+=N:FoldColumn         " make current line number stand out a little
  set highlight+=c:LineNr             " blend vertical separators with line numbers
endif
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j                " remove comment leader when joining comment lines
endif
set list                              " show whitespace
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
                                      " + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)
set modelines=5                       " scan this many lines looking for modeline
set nojoinspaces                      " don't autoinsert two spaces after '.', '?', '!' for join command

" Settings by filetype
filetype on
au BufNewFile,BufRead *.ihtml set filetype=php
au BufNewFile,BufRead *.volt set filetype=html
autocmd FileType coffee setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType php setlocal shiftwidth=4 softtabstop=4 expandtab foldmethod=indent
autocmd FileType php set kp=:help

"let php_folding=1
"set foldnestmax=1

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

" Function to enable folding
let g:foldstate=0
func! DoFold()
  if (!g:foldstate)
    let g:foldstate=1
    set foldenable
    nmap <space> za
  endif
endfunc
nmap <silent> <space> :call DoFold()<cr>

" Function to toggle line numbers
let g:dnum=0
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

" Stop using arrow keys
"nnoremap <Left> :echoe "Use h"<CR>
"nnoremap <Right> :echoe "Use l"<CR>
"nnoremap <Up> :echoe "Use k"<CR>
"nnoremap <Down> :echoe "Use j"<CR>

" Stop using function keys
"nnoremap <f1> :echoe "use K"<CR>
"nmap <f2> :echoe "use ,ws"<CR>
"nmap <f3> :echoe "use ,c"<CR>
"nmap <f4> :echoe "not reqd"<CR>
"map <f7> :echoe "use ,ww or alt-arrow or ctl-hjkl"<CR>
"map <f8> :echoe "use ,wl"<CR>
"map <f9> :echoe "use ,li"<CR>
"map <f10> :echoe "use ,ln"<CR>

" Mappings: function keys (legacy)
nnoremap <f1> K
nmap <f2> :below new<cr>
nmap <f3> :clo<cr>
set pt=<F4>
vmap <f5> gc
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
nmap <leader>wh :below new<cr>
nmap <leader>wv :below vnew<cr>
nmap <M-b> <C-w>W
nmap <M-f> <C-w>w

" Mappings: general
map <C-n> :30Lex<CR>
nnoremap <leader>. :lcd %:p:h<CR>
"noremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader><space> :noh<cr>
nnoremap <leader>u :UndotreeShow<CR>
imap ii <Esc>

" Mappings: commenting
" map <leader># :s/^/#/<CR>:nohlsearch<CR>
" map <leader>/ :s/^/\/\//<CR>:nohlsearch<CR>
" map <leader>" :s/^/\"/<CR>:nohlsearch<CR>
" map <leader>- :s/^/--/<CR>:nohlsearch<CR>
" map <f5> :s/^/\/\//<CR>:nohlsearch<CR>
" map <f6> :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>

" Mappings: splits
noremap <leader>h :<C-u>split<CR>
noremap <leader>v :<C-u>vsplit<CR>
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>w
noremap <C-h> <C-w>W
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
" let php_folding=0
" set foldnestmax=1
"nnoremap <space> za

" On save, search the first 20 lines for '@modified' and update with current date
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
