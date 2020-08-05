let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('_', 'max_menu_width', 80)
call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer']})
