set termguicolors
set background=dark

augroup MyColors
    autocmd!
    autocmd ColorScheme * hi Normal         guibg=NONE
                      \ | hi ColorColumn    guibg=NONE
                      \ | hi CursorColumn   guibg=NONE
                      \ | hi FoldColumn     guibg=NONE
                      \ | hi Folded         guibg=NONE
                      \ | hi GitGutterAdd   guibg=NONE
                      \ | hi LineNr         guibg=NONE
                      \ | hi NonText        guibg=NONE
                      \ | hi Pmenu          guibg=#508aaa guifg=#1e242f gui=NONE
                      \ | hi PmenuSel       guifg=#1e242f gui=NONE
                      \ | hi Search         guibg=#47959a guifg=#1e242f gui=NONE
                      \ | hi SignColumn     guibg=NONE
                      \ | hi VertSplit      guibg=NONE
augroup END
colorscheme azure

"*** vimdiff colour overrides
hi DiffAdd    cterm=bold ctermfg=193 ctermbg=65  guifg=#1E242F guibg=#9CC696 gui=NONE
hi DiffDelete cterm=bold ctermfg=234 ctermbg=9   guifg=#1E242F guibg=#E86169 gui=NONE
hi DiffChange cterm=bold ctermbg=189 ctermbg=60  guifg=#1E242F guibg=#689ACA gui=NONE
hi DiffText   cterm=bold ctermfg=234 ctermbg=12  guifg=#1E242F guibg=#F8C76B gui=NONE

"*** Settings
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent
set smartindent
set cin
set noshowmode
set backupdir=~/Backups/vim
let g:indentLine_enabled = 0

"*** function to toggle windows layout between horiz & vert
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

"*** function to toggle line numbers
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
"map <f9> :set list! list? <CR>
map <f9> :IndentLinesToggle<CR>
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

"*** php filetypes
filetype on
au BufNewFile,BufRead *.ihtml set filetype=php
autocmd FileType php set kp=:help

"*** folding
let php_folding=0
set foldnestmax=1
noremap <space> za
set nofoldenable  "*** disable folding on load - use zi command to toggle
au FileType php setl nofen

"*** status line
set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P " legacy statusline - not used if airline active
set ttimeoutlen=50
set ls=2            "status line (2=always on)

"*** airline
let g:airline#extensions#tabline#enabled = 0
let g:airline_exclude_preview = 1
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme = 'nord'
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

"*** gitgutter
set updatetime=100
set signcolumn=yes

"*** syntastic (syntax checking)
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": ['php','python'],
    \ "passive_filetypes": ['html'] }
nnoremap <silent> <leader>qa :SyntasticCheck<CR>

"*** vim-surround
nmap ss ysiw
nmap sl yss
vmap s S

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
