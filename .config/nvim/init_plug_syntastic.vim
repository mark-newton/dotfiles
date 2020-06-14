
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": ['php','python'],
    \ "passive_filetypes": ['html'] }
let g:syntastic_python_pylint_post_args="--max-line-length=180"
nnoremap <silent> <leader>qa :SyntasticCheck<CR>
