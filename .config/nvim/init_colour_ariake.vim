syntax on
set termguicolors
set background=dark
colorscheme ariake-dark

" No background overrides
hi! Normal guibg=NONE
hi! ColorColumn ctermbg=0 guibg=NONE
hi! CursorColumn guibg=NONE
hi! FoldColumn guibg=NONE
hi! Folded guibg=NONE
hi! LineNr guibg=NONE
hi! NonText guibg=NONE
hi! SignColumn guibg=NONE
hi! VertSplit guibg=NONE
hi! EndOfBuffer guibg=NONE ctermbg=NONE

" Git gutter
hi! GitGutterAdd guibg=NONE guifg=#5fd7a7

" Floaterm
hi! Floaterm guibg=NONE ctermbg=NONE
hi! FloatermNC guibg=NONE ctermbg=NONE
hi! FloatermBorder guifg=#C179DB guibg=NONE ctermbg=NONE

" Vimdiff
hi! DiffAdd cterm=bold ctermfg=193 ctermbg=65  guifg=#1E242F guibg=#9CC696 gui=NONE
hi! DiffDelete cterm=bold ctermfg=234 ctermbg=9   guifg=#1E242F guibg=#E86169 gui=NONE
hi! DiffChange cterm=bold ctermbg=189 ctermbg=60  guifg=#1E242F guibg=#689ACA gui=NONE
hi! DiffText cterm=bold ctermfg=234 ctermbg=12  guifg=#1E242F guibg=#F8C76B gui=NONE

" Ariake overrides
hi! Search ctermbg=59 guibg=#313343
hi! Pmenu ctermbg=59 guibg=#313343
hi! PmenuSel ctermfg=16 ctermbg=122 cterm=NONE guifg=#1f212a guibg=#9aefea gui=NONE
hi! Todo guifg=#dda2f6 guibg=NONE gui=BOLD
