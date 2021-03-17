"########################################
"########################################
" Codecourse Contrast (rainglow)
"
" https://github.com/rainglow/vim
"
" Copyright (c) Dayle Rees.
"########################################
"########################################


"########################################
"# Settings.                            #
"########################################

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "codecourse"

" blue orig: #1ea8fc
"########################################
"# Base Colors.                         #
"########################################

hi Cursor         guifg=#05080a guibg=#ffffff gui=NONE
hi Visual         guifg=#ffffff guibg=#569CD6 gui=NONE
hi CursorLine     guifg=NONE guibg=#161B1F gui=NONE
hi CursorLineNr   guifg=#E7BE45 guibg=161B1F gui=NONE
hi CursorColumn   guifg=NONE guibg=NONE gui=NONE
hi ColorColumn    guifg=NONE guibg=NONE gui=NONE
hi LineNr         guifg=#3B4651 guibg=NONE gui=NONE
hi VertSplit      guifg=#16232c guibg=NONE gui=NONE
hi MatchParen     guifg=#5dcdfd guibg=NONE gui=underline
hi StatusLine     guifg=#b6ced8 guibg=#161B1F gui=bold
hi StatusLineNC   guifg=#b6ced8 guibg=NONE gui=NONE
hi Pmenu          guifg=#b6ced8 guibg=#252C34 gui=NONE
hi PmenuSel       guifg=NONE guibg=#3B4651 gui=NONE
"hi IncSearch      guifg=#b6ced8 guibg=#aaaaaa gui=NONE
"hi Search         guifg=NONE guibg=NONE gui=INVERSE
hi IncSearch      guifg=#1e242F guibg=#a7da1e gui=NONE
hi Search         guifg=#ffffff guibg=#569CD6 gui=NONE
hi Directory      guifg=#569cd6 guibg=NONE gui=NONE
hi Folded         guifg=#a5c3cf guibg=NONE gui=NONE
hi Normal         guifg=#ffffff guibg=NONE gui=NONE
hi Boolean        guifg=#ffffff guibg=NONE gui=NONE
hi Character      guifg=#cccccc guibg=NONE gui=NONE
hi Comment        guifg=#608B4E guibg=NONE gui=NONE
hi Conditional    guifg=#569cd6 guibg=NONE gui=NONE
hi Constant       guifg=NONE guibg=NONE gui=NONE
hi Define         guifg=#569cd6 guibg=NONE gui=NONE
hi DiffAdd        guifg=#1E242F guibg=#a7da1e gui=NONE
hi DiffDelete     guifg=#1E242F guibg=#E86169 gui=NONE
hi DiffChange     guifg=#1E242F guibg=#689ACA gui=NONE
hi DiffText       guifg=#1E242F guibg=#F8C76B gui=NONE
hi ErrorMsg       guifg=#1e313d guibg=#e61f44 gui=NONE
hi WarningMsg     guifg=#1e313d guibg=#f7b83d gui=NONE
hi Float          guifg=#aaaaaa guibg=NONE gui=NONE
hi Function       guifg=#569cd6 guibg=NONE gui=NONE
hi Identifier     guifg=#ffffff guibg=NONE gui=NONE
hi Keyword        guifg=#569cd6 guibg=NONE gui=NONE
hi Label          guifg=#cccccc guibg=NONE gui=NONE
hi NonText        guifg=#446d7e guibg=NONE gui=NONE
hi Number         guifg=#aaaaaa guibg=NONE gui=NONE
hi Operator       guifg=#b6ced8 guibg=NONE gui=NONE
hi PreProc        guifg=#6494a9 guibg=NONE gui=NONE
hi Special        guifg=#b6ced8 guibg=NONE gui=NONE
hi SpecialKey     guifg=#b6ced8 guibg=#569cd6 gui=NONE
hi Statement      guifg=#569cd6 guibg=NONE gui=NONE
hi StorageClass   guifg=#5dcdfd guibg=NONE gui=NONE
hi String         guifg=#cccccc guibg=NONE gui=NONE
hi Tag            guifg=#569cd6 guibg=NONE gui=NONE
hi Title          guifg=#569cd6 guibg=NONE gui=bold
hi Todo           guifg=#5DCDFD guibg=NONE gui=bold
hi Type           guifg=NONE guibg=NONE gui=NONE
hi Underlined     guifg=NONE guibg=NONE gui=underline

"########################################
"# Language Overrides                   #
"########################################

hi phpIdentifier     guifg=#9cdcfe
hi phpMethodsVar     guifg=#a3bfd1
hi xmlTag            guifg=#569cd6 guibg=NONE gui=NONE
hi xmlTagName        guifg=#569cd6 guibg=NONE gui=NONE
hi xmlEndTag         guifg=#569cd6 guibg=NONE gui=NONE

"########################################
"# Extras 
"########################################
hi SignColumn ctermfg=NONE guibg=NONE
hi GitSignsAdd guifg=#5fd7a7
hi GitSignsChange guifg=#d7ba7d
hi GitSignsDelete guifg=#d16969
hi Floaterm guibg=#161B1F ctermbg=NONE
hi LspDiagnosticsError guifg=#d16969
hi LspDiagnosticsWarning guifg=#d7ba7d
hi LspDiagnosticsHint guifg=#569cd6
hi LspDiagnosticsInformation guifg=#a3bfd1
hi LspDiagnosticsVirtualTextError guifg=#999999
hi LspDiagnosticsVirtualTextWarning guifg=#999999
hi LspDiagnosticsVirtualTextHint guifg=#999999
hi LspDiagnosticsVirtualTextInformation guifg=#999999
