local status, lualine = pcall(require, "lualine")
if not status then
    return
end

local lualine_tokyo = require("lualine.themes.tokyonight")

lualine.setup({
    options = {
        theme = lualine_tokyo,
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha" },
        ignore_focus = {},
        always_divide_middle = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = {
            {'mode', fmt = function(str) return str:sub(1,1) end}
        },
        lualine_b = {'branch'},
        lualine_c = {'filename','diff'},
        lualine_x = {'diagnostics', 'lsp', 'spaces', 'filetype'},
        lualine_y = {'location'},
        lualine_z = {'progress'}
    },
    inactive_sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {'filename','diff'},
        lualine_x = {''},
        lualine_y = {'location'},
        lualine_z = {'progress'}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
})
