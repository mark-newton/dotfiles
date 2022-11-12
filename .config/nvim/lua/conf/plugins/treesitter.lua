local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

treesitter.setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "php" },
    },
    ignore_install = { "haskell" },
    indent = {
        enable = true,
        disable = { "yaml", "python", "php" },
    },
    matchup = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    autotag = { enable = true },
    ensure_installed = {
        "bash",
        "c",
        "css",
        "dockerfile",
        "gitignore",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "php",
        "python",
        "rust",
        "typescript",
        "vim",
        "yaml",
    },
    auto_install = true,
})
