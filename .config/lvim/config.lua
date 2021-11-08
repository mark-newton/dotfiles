-- Defaults:
-- Copy settings from ~/.local/share/lunarvim/lvim/utils/installer/config.example.lua

-- lvim settings

-- keymappings [view all the defaults by pressing <leader>Lk]

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.leader = ','
lvim.log.level = 'warn'
lvim.format_on_save = false
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.bufferline.active = false
lvim.builtin.project.active = true
lvim.builtin.project.manual_mode = true

-- nvim-tree
vim.g.netrw_banner = false
lvim.builtin.nvimtree.active = true
lvim.builtin.nvimtree.show_icons.git = true
lvim.builtin.nvimtree.setup.view.side = 'left'
lvim.builtin.nvimtree.setup.disable_netrw = false
lvim.builtin.nvimtree.setup.hijack_netrw = false
lvim.builtin.nvimtree.setup.update_to_buf_dir = {
    enable=false,
    auto_open=false
}

-- treesitter
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "css",
    "html",
    "javascript",
    "json",
    "lua",
    "php",
    "python",
    "rust",
    "typescript",
    "yaml",
}
lvim.builtin.treesitter.ignore_install = { 'haskell' }
lvim.builtin.treesitter.highlight.enabled = true

-- plugins
lvim.plugins = {
    {"folke/tokyonight.nvim"},
    {"tpope/vim-surround"},
    {
        "ray-x/lsp_signature.nvim",
        config = function()
            require "lsp_signature".setup()
        end
    },
    {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function()
        require('neoscroll').setup({
            -- All these keys will be mapped to their corresponding default scrolling animation
            mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
            hide_cursor = true,          -- Hide cursor while scrolling
            stop_eof = true,             -- Stop at <EOF> when scrolling downwards
            use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
            respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
            cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
            easing_function = nil,       -- Default easing function
            pre_hook = nil,              -- Function to run before the scrolling animation starts
            post_hook = nil,             -- Function to run after the scrolling animation ends
        })
        end
    },
}

-- colours
lvim.colorscheme = "tokyonight"
vim.g.tokyonight_style = "night"
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_colors = {
    fg_gutter = 'bg_dark',
    bg_highlight = '#1D1F2D'
}

-- lualine
-- lvim.builtin.lualine.options.theme = "ayu_mirage"
lvim.builtin.lualine.options.theme = "tokyonight"
lvim.builtin.lualine.style = 'lvim'
local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_y = {
  components.location,
}

-- includes
require('settings')
require('keymappings')
