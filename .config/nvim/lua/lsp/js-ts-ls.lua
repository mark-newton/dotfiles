-- npm install -g typescript typescript-language-server
require'lspconfig'.tsserver.setup{on_attach = require'lsp'.common_on_attach}
