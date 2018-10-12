set termguicolors
set background=dark
let ayucolor="mirage"
colorscheme ayu

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

"*** key bindings
nnoremap <f1> K
nmap <f2> :below new<cr>
nmap <f3> :clo<cr>
set pt=<F4>
map <f7> <C-W>w
map <f8> :call ToggleWinLayout()<cr>
map <f9> :set list! list? <CR>
map <f10> :call ToggleNumbers()<cr>
map <C-n> :NERDTreeToggle<CR>

"*** commenting
map ,# :s/^/#/<CR>:nohlsearch<CR>
map ,/ :s/^/\/\//<CR>:nohlsearch<CR>
map ," :s/^/\"/<CR>:nohlsearch<CR>
map ,- :s/^/--/<CR>:nohlsearch<CR>
map ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>
map <f5> :s/^/\/\//<CR>:nohlsearch<CR>
map <f6> :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>

"*** folding
let php_folding=1
set foldnestmax=1
noremap <space> za

"*** status line
set ls=2            "status line (2=always on)
let g:airline#extensions#tabline#enabled = 0
set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P
set ttimeoutlen=50
let g:airline_theme = 'monochrome'
let g:airline_exclude_preview = 1
let g:airline_powerline_fonts = 0
let g:airline_left_sep=''  " Slightly fancier than '>'
let g:airline_right_sep='' " Slightly fancier than '<'

"*** gitgutter
set updatetime=100
set signcolumn=yes

"*** syntastic (syntax checking)
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
nnoremap <silent> <leader>qa :SyntasticCheck<CR>

"*** omni auto-complete with tab
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
set completeopt=longest,menuone

"*** Search the first 20 lines for 'modified' and update with current date
function! LastMod()
  if line("$") > 20
    let l = 20
  else
    let l = line("$")
  endif
  exe "1," . l . "g/modified /s/modified .*/modified " . strftime("%d-%b-%Y")
endfun
autocmd BufWrite *   ks|call LastMod()|'s

"*** Others
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set expandtab
set autoindent
set smartindent
set cin
