set t_Co=256
if has("termguicolors")
  set termguicolors
  " set Vim-specific sequences for RGB colors
  if exists('$TMUX')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
endif
set background=dark
color codecourse

" Git gutter
hi! GitGutterAdd guibg=NONE guifg=#5fd7a7

" Signify
hi! SignifySignAdd guifg=#5fd7a7 guibg=NONE gui=NONE
hi! SignifySignDelete guifg=#d16969 guibg=NONE gui=NONE
hi! SignifySignChange guifg=#d7ba7d guibg=NONE gui=NONE

" Floaterm
hi! Floaterm guibg=#161B1F ctermbg=NONE
"hi! FloatermNC guibg=NONE ctermbg=NONE
"hi! FloatermBorder guifg=#C179DB guibg=NONE ctermbg=NONE
