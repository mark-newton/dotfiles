" Deoplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources.php = ['omni', 'buffer']

" colorschemes
Plug 'arcticicestudio/nord-vim'
Plug 'Badacadabra/vim-archery'
Plug 'rainglow/vim'

" PHP Plugins
Plug 'StanAngeloff/php.vim'
Plug 'shawncplus/phpcomplete.vim'
Plug 'rayburgemeestre/phpfolding.vim'
Plug 'alvan/vim-php-manual'
let g:php_manual_online_search_shortcut = '<S-F1>'

" Tab complete
Plug 'ervandew/supertab'
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
set completeopt=longest,menuone
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" Other plugins
Plug 'tpope/vim-surround'

" Disable plugins - not needed / performance
Plug 'gorodinskiy/vim-coloresque',{'on':[]}
