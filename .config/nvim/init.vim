" Set override folder
set rtp+=$HOME/.config/nvim/overrides

" General
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
set cursorline
set hlsearch
set incsearch
set ignorecase
set smartcase
set backspace=indent,eol,start

" Legacy vimscript
source $HOME/.config/nvim/vimscript/init_colours.vim
" source $HOME/.config/nvim/vimscript/init_whichkey.vim

" Most of the config is now in lua
luafile $HOME/.config/nvim/config.lua

" Wincent settings
scriptencoding utf-8
set diffopt+=foldcolumn:0             " don't show fold column in diff view
set fillchars=diff:∙                  " BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
set fillchars+=fold:·                 " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
set fillchars+=vert:┃                 " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
set formatoptions+=j                  " remove comment leader when joining comment lines
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

" Folding (using treesitter)
let s:middot='·'
let s:raquo='»'
let s:small_l='ℓ'
function! GetSpaces(foldLevel)
    if &expandtab == 1
        " Indenting with spaces
        let str = repeat(" ", a:foldLevel / (&shiftwidth + 1) - 1)
        return str
    elseif &expandtab == 0
        " Indenting with tabs
        return repeat(" ", indent(v:foldstart) - (indent(v:foldstart) / &shiftwidth))
    endif
endfunction
function! CustomFoldText() abort
    let l:lines='[' . (v:foldend - v:foldstart + 1) . ' lines' . ']'
    let startLineText = getline(v:foldstart)
    let endLineText = trim(getline(v:foldend))
    let indentation = GetSpaces(foldlevel("."))
    let spaces = repeat(" ", 400)
    let str = indentation . startLineText . " " . s:middot . s:middot . l:lines . s:middot . s:middot . " " . endLineText . spaces
    return str
endfunction
function! WincentFoldtext() abort
  let l:lines='[' . (v:foldend - v:foldstart + 1) . s:small_l . ']'
  let l:first=substitute(getline(v:foldstart), '\v *', '', '')
  let l:dashes=substitute(v:folddashes, '-', s:middot, 'g')
  return s:raquo . s:middot . s:middot . l:lines . l:dashes . ': ' . l:first
endfunction
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
autocmd FileType php set foldmethod=expr foldexpr=nvim_treesitter#foldexpr() "PHP Folding only
set foldlevel=1
set foldlevelstart=1
set foldnestmax=2
set foldtext=CustomFoldText()
nmap <space> za
nmap <leader>o zR

" Function to toggle line numbers
set number
set relativenumber
let g:dnum=1
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
map <f8> :call ToggleWinLayout()<cr>
map <f9> :set list! list? <CR>
map <f10> :call ToggleNumbers()<cr>

" Mappings: function key replacements
nmap <leader>wl :call ToggleWinLayout()<cr>
nmap <leader>li :set list! list? <cr>
nmap <leader>ln :call ToggleNumbers()<cr>

" Copy/paste
if has('macunix')
  set clipboard=unnamed,unnamedplus
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

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
