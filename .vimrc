
"*** colorscheme
syntax on
set bg=dark
if has("gui_running")
  colorscheme hemisu
  set guifont=Sauce\ Code\ Powerline\ Light:h12
  set guicursor+=a:blinkon0
  set nu
  set go-=r
else
  colorscheme hemisu
  set mouse=n
  set nonu
endif

"*** vimdiff colour overrides
highlight DiffAdd    cterm=bold ctermfg=193 ctermbg=65
highlight DiffDelete cterm=bold ctermfg=234 ctermbg=9
highlight DiffChange cterm=bold ctermfg=189 ctermbg=60
highlight DiffText   cterm=bold ctermfg=234 ctermbg=12

set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
set updatetime=1000

"*** general
"set cursorline      "higlight current line
set nobackup        "auto backup of file to ~filename
set nocp            "not vi compatible (recommended)
set notitle         "show file name in title
set ru              "ruler - display screen coords
set sm              "showmatch - show matching bracket
set visualbell      "don't beep
set noerrorbells    "don't beep
set bs=2            "backspace mode - can backspace before insertion and cr
set list            "show tabs and cr
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅
set smd             "showmode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
nnoremap <f1> K
map <f9> :set list! list? <CR>
map <f10> :set nu! nu? <CR>

"*** formatting
set ts=2            "tabstop - what a tab represents
set sw=2            "shiftwidth - number of space used for autoindent
set sta             "smarttab - indent tab uses sw spaces
set sts=2           "softtabstop - number of space to insert for tab
set et              "expandtab - expand tab to space in insert mode
set ai              "autoindent - auto indent of new line
set si              "smartindent - clever ai
set cin             "cindent - specific c code indenting
set pt=<F4>         "pastetoggle - when on disables ai for pasting

"*** search options
set ws              "wrapscan - wrap to top
set ic              "ignorecase
set scs             "smartcase - override ic when search has uppercase
set hls             "highlight matches
set is              "incsearch - jump to word while typing
nmap <silent><C-H> :nohlsearch<CR>  "ctl-h to turn off search highlight
set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

"*** windows
nmap <f2> :below new<cr>
nmap <f3> :clo<cr>
"map <f5> :SVNVimDiff<cr>
map <f7> <C-W>w
"map <f10> <C-W>+
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
map <f8> :call ToggleWinLayout()<cr>

"*** commenting
let b:did_ftplugin = 1
map ,# :s/^/#/<CR>:nohlsearch<CR>
map ,/ :s/^/\/\//<CR>:nohlsearch<CR>
map ," :s/^/\"/<CR>:nohlsearch<CR>
map ,- :s/^/--/<CR>:nohlsearch<CR>
map ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>
map <f5> :s/^/\/\//<CR>:nohlsearch<CR>
map <f6> :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>

"*** Search the first 20 lines for modified and update with current date
function! LastMod()
  if line("$") > 20
    let l = 20
  else
    let l = line("$")
  endif
  exe "1," . l . "g/modified /s/modified .*/modified " . strftime("%d-%b-%Y")
endfun
autocmd BufWrite *   ks|call LastMod()|'s

"*** folding
let perl_fold=1
let perl_nofold_packages=1
let php_folding=1
noremap <space> za
let g:DisableAutoPHPFolding = 1  "disable PIV folding

"*** syntastic (syntax checking)
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
nnoremap <silent> <leader>qa :SyntasticCheck<CR>

"*** omni auto-complete
function! InsertTabWrapper()
  if pumvisible()
    return "\<c-n>"
  endif
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-x>\<c-o>"
  endif
endfunction
inoremap <expr><tab> InsertTabWrapper()
inoremap <expr><s-tab> pumvisible()?"\<c-p>":"\<c-d>"
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

"*** indent guides
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#777777 ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#777777 ctermbg=235

"*** status line
set ls=2            "status line (2=always on)
set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P
set ttimeoutlen=50
let g:airline_theme = 'powerlineish'
let g:airline_exclude_preview = 1
let g:airline_powerline_fonts=1
if !exists('g:airline_powerline_fonts')
  " Use the default set of separators with a few customizations
  let g:airline_left_sep='›'  " Slightly fancier than '>'
  let g:airline_right_sep='‹' " Slightly fancier than '<'
else
  let g:airline_left_sep=''  " Slightly fancier than '>'
  let g:airline_right_sep='' " Slightly fancier than '<'
endif

"*** gitgutter
let g:gitgutter_enabled = 1
let g:gitgutter_realtime = 1
let g:gitgutter_sign_column_always = 1

"*** fugitive shortcuts
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
" Mnemonic _i_nteractive
nnoremap <silent> <leader>gi :Git add -p %<CR>
nnoremap <silent> <leader>gg :SignifyToggle<CR>

