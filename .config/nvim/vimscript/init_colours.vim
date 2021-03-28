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

" Floaterm
hi! Floaterm guibg=#161B1F ctermbg=NONE
"hi! FloatermNC guibg=NONE ctermbg=NONE
"hi! FloatermBorder guifg=#C179DB guibg=NONE ctermbg=NONE
