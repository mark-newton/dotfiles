local status, cs = pcall(require, "tokyonight")
if not status then
    return
end
cs.setup({
    style = "night",
    styles = {
        sidebars = "dark",
        floats = "dark",
    },
    sidebars = { "qf", "vista_kind", "terminal", "packer" },
    transparent = true,
    on_colors = function(colors)
        -- colors.hint = colors.orange
        -- colors.error = "#ff0000"
    end,
})
vim.cmd([[colorscheme tokyonight]])

local override_reset = { "Folded" }
local override_set = {
    Folded = { ctermbg = "NONE", ctermfg = "blue", guibg = "NONE", guifg = "#7aa2f7" },
}
require("color-overrides").set_overrides(override_reset, override_set)
