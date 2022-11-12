local status, toggleterm = pcall(require, "toggleterm")
if not status then
    return
end

toggleterm.setup({
    active = true,
    size = 20,
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 1,
    direction = "float",
    close_on_exit = true,
    float_opts = {
        border = "curved",
    },
})
