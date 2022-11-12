vim.g.mapleader = ","

local keymap = vim.keymap

---------------------
-- General Keymaps
---------------------

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "<leader><space>", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>v", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>h", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>w", "<C-w>w") -- swap to next window
keymap.set("n", "<leader>x", ":close<CR>") -- close current split window

-- function keys
keymap.set("n", "<f2>", "<C-w>v") -- split window vertically
keymap.set("n", "<f3>", ":clo<CR>") -- close current split window
keymap.set("v", "<f5>", "gc") -- close current split window
keymap.set("n", "<f7>", "<C-w>w") -- swap to next window
keymap.set("n", "<f9>", ":set list! list? <CR>") -- swap to next window

-- folds
keymap.set("n", "<space>", "za")
keymap.set("n", "<leader>o", "zR")

-- surround
keymap.set("n", "sw", "ysiw")
keymap.set("n", "sl", "yss")
keymap.set("v", "s", "S")

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- toggleterm
keymap.set("n", "<leader>t", ":ToggleTerm<CR>")

-- telescope
keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary
