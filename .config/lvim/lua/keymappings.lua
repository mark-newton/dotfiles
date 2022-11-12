-- Whickkey overrides
lvim.builtin.which_key.mappings["w"] = { "<C-w>w", "Swap window" }
lvim.builtin.which_key.mappings["v"] = { "<cmd>:vsplit<cr>", "VSplit" }
lvim.builtin.which_key.mappings["h"] = { "<cmd>:split<cr>", "HSplit" }

-- My extras
lvim.keys.normal_mode["<f1>"] = ":lua vim.lsp.buf.hover()<CR>"
lvim.keys.normal_mode["<f2>"] = ":vs<CR>"
lvim.keys.normal_mode["<f3>"] = ":clo<CR>"
vim.cmd([[
    set pt=<F4>
    vmap <f5> gc
    map <f7> <C-W>w
    nmap <f9> :set list! list? <CR>
    nmap <leader>ws :below new<cr>
    nmap <leader>c :clo<cr>
    nmap <leader>w <C-w>w
    nmap <leader>li :set list! list? <cr>
    nnoremap <silent> <leader><space> :noh<cr>
    noremap <leader>h :<C-u>split<CR>
    noremap <leader>v :<C-u>vsplit<CR>
    noremap <C-j> <C-w>j
    noremap <C-k> <C-w>k
    noremap <C-l> <C-w>w
    noremap <C-h> <C-w>W
    nnoremap <leader>+ :vertical resize +5<CR>
    nnoremap <leader>- :vertical resize -5<CR>
    nmap <space> za
    nmap <leader>o zR
    nmap sw ysiw
    nmap sl yss
    vmap s S
]])
