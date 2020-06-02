" Install
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
if !filereadable(vimplug_exists)
    if !executable("curl")
        echoerr "You have to install curl or first install vim-plug yourself!"
        execute "q!"
    endif
    echo "Installing Vim-Plug..."
    echo ""
    silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let g:not_finish_vimplug = "yes"
    autocmd VimEnter * PlugInstall
endif
if !isdirectory($HOME . "/.vim/undodir")
    call mkdir($HOME . "/.vim/undodir", "p", 0700)
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
set noswapfile
set fileformats=unix,dos,mac
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif
let g:session_directory = "~/.vim/session"
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
set undodir=~/.vim/undodir
set undofile
set scrolloff=8
set gcr=a:blinkon0
set scrolloff=3
set laststatus=2
set modeline
set modelines=10
nnoremap n nzzzv
nnoremap N Nzzzv

" Plugins
call plug#begin(expand('~/.vim/plugged'))
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/grep.vim'
Plug 'vim-scripts/CSApprox'
Plug 'bronson/vim-trailing-whitespace'
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
if isdirectory('/usr/local/opt/fzf')
    Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
endif
Plug 'arnaud-lb/vim-php-namespace'
Plug 'davidcelis/vim-ariake-dark'
Plug 'StanAngeloff/php.vim'
Plug 'shawncplus/phpcomplete.vim'
Plug 'rayburgemeestre/phpfolding.vim'
Plug 'alvan/vim-php-manual'
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'ConradIrwin/vim-bracketed-paste'
call plug#end()

" Plugin: fugitive
if exists("*fugitive#statusline")
    set statusline+=%{fugitive#statusline()}
endif

" Plugin: php man
let g:php_manual_online_search_shortcut = '<S-F1>'

" Plugin: tab complete
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
set completeopt=longest,menuone
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" Plugin: gitgutter
set updatetime=100
set signcolumn=yes

" Plugin: syntastic (syntax checking)
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": ['php','python'],
    \ "passive_filetypes": ['html'] }
let g:syntastic_python_pylint_post_args="--max-line-length=180"
nnoremap <silent> <leader>qa :SyntasticCheck<CR>

" Plugin: vim-surround
nmap sw ysiw
nmap sl yss
vmap s S

" Plugin: airline
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline_exclude_preview = 1
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme = 'monochrome'
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#format = 'CustomBranchName'
function! CustomBranchName(name)
    let g:airline_section_b = airline#section#create(['branch'])
    if a:name == 'master'
        call airline#parts#define_accent('master', 'red')
        let g:airline_section_b = airline#section#create([g:airline_symbols.branch. ' ', 'master'])
    endif
    return a:name
endfunction
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
    let g:airline_left_sep = ''
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''
endif

" Plugin: grep
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

"" Plugin: fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
if executable('ag')
    let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
    set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
    let g:rg_derive_root='true'
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    set grepprg=rg\ --vimgrep
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>

" Plugin: syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1

" Colors
syntax on
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
set background=dark
"set colorcolumn=100
augroup MyColors
    autocmd!
    autocmd ColorScheme * hi Normal         guibg=NONE
    autocmd ColorScheme * hi ColorColumn    ctermbg=0 guibg=NONE
    autocmd ColorScheme * hi CursorColumn   guibg=NONE
    autocmd ColorScheme * hi FoldColumn     guibg=NONE
    autocmd ColorScheme * hi Folded         guibg=NONE
    autocmd ColorScheme * hi LineNr         guibg=NONE
    autocmd ColorScheme * hi NonText        guibg=NONE
    autocmd ColorScheme * hi SignColumn     guibg=NONE
    autocmd ColorScheme * hi VertSplit      guibg=NONE
    autocmd ColorScheme * hi GitGutterAdd   guibg=NONE guifg=#5fd7a7
    autocmd ColorScheme * hi EndOfBuffer    guibg=NONE ctermbg=NONE
    autocmd ColorScheme * hi Search         guibg=#313343
    autocmd ColorScheme * hi DiffAdd        cterm=bold ctermfg=193 ctermbg=65  guifg=#1E242F guibg=#9CC696 gui=NONE
    autocmd ColorScheme * hi DiffDelete     cterm=bold ctermfg=234 ctermbg=9   guifg=#1E242F guibg=#E86169 gui=NONE
    autocmd ColorScheme * hi DiffChange     cterm=bold ctermbg=189 ctermbg=60  guifg=#1E242F guibg=#689ACA gui=NONE
    autocmd ColorScheme * hi DiffText       cterm=bold ctermfg=234 ctermbg=12  guifg=#1E242F guibg=#F8C76B gui=NONE
augroup END
colorscheme ariake-dark

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

" Mappings
let mapleader = ","

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
noremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader><space> :noh<cr>
nnoremap <leader>u :UndotreeShow<CR>
imap ` <Esc>

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
autocmd BufWrite *   ks|call LastMod()|'s

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50
