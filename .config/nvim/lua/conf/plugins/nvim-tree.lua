local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
    return
end

vim.g.loaded = 1
vim.g.netrw_banner = false

-- change color for arrows
--vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

nvimtree.setup({
    actions = {
        open_file = {
            window_picker = {
                enable = false,
            },
        },
    },
    filters = {
        dotfiles = true,
    },
    disable_netrw = false,
    hijack_netrw = false,
    renderer = {
        icons = {
            show = {
                git = true,
            },
            glyphs = {
                folder = {
                    arrow_closed = "", -- arrow when folder is closed
                    arrow_open = "", -- arrow when folder is open
                },
            },
        },
    },
})
