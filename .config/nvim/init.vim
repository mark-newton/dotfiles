" Most of the config is now in lua
luafile $HOME/.config/nvim/config.lua

" Legacy vimscript
source $HOME/.config/nvim/init_colours.vim

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

" PHP folding
let php_folding=1
set foldnestmax=2
nmap <space> za

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
