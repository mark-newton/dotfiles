-- auto install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
    augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
    return
end

-- add list of plugins to install
return packer.startup(function(use)
    -- packer
    use("wbthomason/packer.nvim")

    -- plenery
    use("nvim-lua/plenary.nvim")

    -- colors
    use("folke/tokyonight.nvim")
    use("cwebster2/color-overrides.nvim")

    -- windows
    use("christoomey/vim-tmux-navigator") -- tmux & split window navigation
    use("szw/vim-maximizer") -- maximizes and restores current window

    -- file explorer
    use("nvim-tree/nvim-tree.lua")
    use("kyazdani42/nvim-web-devicons")

    -- statusline
    use("nvim-lualine/lualine.nvim")

    -- telescope
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

    -- autocompletion
    use("hrsh7th/nvim-cmp") -- completion plugin
    use("hrsh7th/cmp-buffer") -- source for text in buffer
    use("hrsh7th/cmp-path") -- source for file system paths

    -- snippets
    use("L3MON4D3/LuaSnip") -- snippet engine
    use("saadparwaiz1/cmp_luasnip") -- for autocompletion
    use("rafamadriz/friendly-snippets") -- useful snippets

    -- lsp
    use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
    use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig
    use("neovim/nvim-lspconfig") -- easily configure language servers
    use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
    use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
    use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
    use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion
    use("ray-x/lsp_signature.nvim") -- lsp signature shows popup help above function args

    -- formatting & linting
    use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
    use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls
    use("rayburgemeestre/phpfolding.vim") -- most reliable/fast php folding method it seems

    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
    })
    use({
        "andymass/vim-matchup",
        setup = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    })

    -- wakatime for time tracking
    use ('wakatime/vim-wakatime')

    -- other nice stuff
    use("numToStr/Comment.nvim") -- commenting (gc)
    use("JoosepAlviste/nvim-ts-context-commentstring") -- smart comment detection for embedded code
    use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
    use("vim-scripts/ReplaceWithRegister") -- replace with register contents using motion (gr + motion)
    use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
    use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags
    use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side
    use("ThePrimeagen/vim-be-good") -- primeagen vim tutor
    use({ "akinsho/toggleterm.nvim", tag = "*" }) -- floating terminal
    use('RRethy/vim-illuminate') -- shows matching words

    if packer_bootstrap then
        require("packer").sync()
    end
end)
