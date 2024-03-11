-- OPTIONS {{{
vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.breakindent = true
-- vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.cmdheight = 1
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.incsearch = true
vim.opt.joinspaces = false
vim.opt.list = true
vim.opt.mouse = "a"
vim.opt.number = false
vim.opt.numberwidth = 4
vim.opt.pumheight = 4
vim.opt.relativenumber = false
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.wrap = false

vim.opt.fillchars = {
  diff = "·", -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  eob = " ", -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  vert = "│", -- BOX DRAWINGS THIN VERTICAL (U+2502), same as tmux
  fold = " ",
  foldsep = " ",
  foldopen = "",
  foldclose = "",
}
vim.opt.listchars = {
  nbsp = "⦸", -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  extends = "»", -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes = "«", -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  tab = "▷⋯", -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + MIDLINE HORIZONTAL ELLIPSIS (U+22EF, UTF-8: E2 8B AF)
  trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
}

-- code folding
vim.opt.foldenable = false  -- turn off by default (turn on by filetype)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldcolumn = "0" -- set to 1 to show the foldcolumn

-- netrw settings
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25
--}}}

-- KEYMAPS {{{
-- clear search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- delete/copy/paste smarts (the _ prefix stops copying into register)
-- NOTE: these mappings assume you don't set clipboard to the system one (use leader y to copy to system)
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "Y", "yg$")
vim.keymap.set("n", "<leader>a", "<cmd>%y+<cr>")
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>d", '"_d')
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set({"n", "v"}, "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- folding
vim.keymap.set("n", "<space>", "za")
vim.keymap.set("n", "<leader>o", "zR")

-- other smarts
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show [D]iagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<leader>v", "<C-w>v") -- split window vertically
vim.keymap.set("n", "<leader>h", "<C-w>s") -- split window horizontally
vim.keymap.set("n", "<leader>w", "<C-w>w") -- swap to next window
vim.keymap.set("n", "<leader>x", ":close<CR>") -- close current split window

-- function keys
vim.keymap.set("n", "<f2>", "<C-w>v") -- split window vertically
vim.keymap.set("n", "<f3>", ":clo<CR>") -- close current split window
vim.keymap.set("v", "<f5>", "gc") -- close current split window
vim.keymap.set("n", "<f7>", "<C-w>w") -- swap to next window
vim.keymap.set("n", "<f9>", ":set list! list? <CR>") -- toggle

--}}}

-- AUTOCMDS {{{
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"},{
  pattern = "*.volt",
  callback = function()
    vim.opt.filetype = "html"
  end
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"lua","vim"},
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
    vim.opt.foldenable = true
    vim.opt.foldmethod = "marker"
  end
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
    vim.opt.kp = ":help"
    vim.opt.foldenable = true
  end
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"html", "coffee"},
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end
})

-- Show cursor line on active window only
local cursorGrp = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  pattern = "*", command = "set cursorline", group = cursorGrp
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  pattern = "*", command = "set nocursorline", group = cursorGrp
})
--}}}

-- LUA FUNCTIONS {{{

-- Add float borders
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
vim.diagnostic.config({
  float = {
    border = "rounded",
  },
})

-- Diagnostic signs
local function sign_define(args)
  vim.fn.sign_define(args.name, {
    texthl = args.name,
    text = args.text,
    numhl = "",
  })
end
sign_define({ name = "DiagnosticSignError", text = "✘" })
sign_define({ name = "DiagnosticSignWarn", text = "▲" })
sign_define({ name = "DiagnosticSignHint", text = "⚑" })
sign_define({ name = "DiagnosticSignInfo", text = "»" })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--}}}

-- LEGACY VIMSCRIPT {{{
-- TODO: move these into lua
vim.cmd([[

  " Update last modified date
  function! LastMod()
    if line("$") > 20
      let l = 20
    else
      let l = line("$")
    endif
    call cursor(1, 1)
    if search("@modified", 'W', l) > 0
      exe "1," . l . "g/@modified /s/@modified .*/@modified " . strftime("%d-%b-%Y")
    endif
  endfun
  autocmd BufWrite * ks|call LastMod()|'s
  nmap <leader>mod :call LastMod()<cr>

]])
--}}}

-- PLUGINS {{{

--Lazy plugin manager (:Lazy) {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Lazy options (added to end of the setup section)
local lazyOpts = {
  ui = { border = "rounded" },
}
--}}}

-- Lazy Plugins
require("lazy").setup(
  {
    -- vim-sleuth {{{
    "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
    --}}}

    -- comment {{{
    { "numToStr/Comment.nvim", opts = {} }, -- gc commenting
    --}}}

    -- gitsigns {{{
    {
      "lewis6991/gitsigns.nvim",
      event = "VimEnter",
      config = function()
        require("gitsigns").setup({
          preview_config = { border = "rounded" },
          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
              if vim.wo.diff then return ']c' end
              vim.schedule(function() gs.next_hunk() end)
              return '<Ignore>'
            end, {expr=true, desc = "Go to next [C]hange" })

            map('n', '[c', function()
              if vim.wo.diff then return '[c' end
              vim.schedule(function() gs.prev_hunk() end)
              return '<Ignore>'
            end, {expr=true, desc = "Go to prev [C]hange" })

            map('n', '<leader>gd', gs.diffthis, { desc = "[G]it [D]iff" })
            map('n', '<leader>gp', gs.preview_hunk, { desc = "[G]it [P]review hunk" })
            map('n', '<leader>gr', gs.reset_hunk, { desc = "[G]it [R]eset hunk" })
          end
        })
      end
    },
    --}}}

    -- which-key {{{
    {
      "folke/which-key.nvim",
      event = "VimEnter", -- Sets the loading event to 'VimEnter'
      config = function() -- This is the function that runs, AFTER loading
        require("which-key").setup({
          window = {
            border = "rounded", -- none, single, double, shadow
          },
        })

        -- Document existing key chains
        require("which-key").register({
          ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
          ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
          ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
          ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
          ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
        })
      end,
    },
    --}}}

    -- telescope {{{
    {
      "nvim-telescope/telescope.nvim",
      event = "VimEnter",
      branch = "0.1.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        { -- If encountering errors, see telescope-fzf-native README for install instructions
          "nvim-telescope/telescope-fzf-native.nvim",
          build = "make",
          cond = function()
            return vim.fn.executable("make") == 1
          end,
        },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "nvim-tree/nvim-web-devicons" },
      },
      config = function()
        require("telescope").setup({
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown(),
            },
          },
        })
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
        vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
        vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
        vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
        vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
        vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
        vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
        vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
        vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "[G]it [S]tatus" })
        vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "[G]it [C]ommits" })
        vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_bcommits<cr>", { desc = "[G]it [B]uffer commits" })

        vim.keymap.set("n", "<leader>/", function()
          builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end, { desc = "[/] Fuzzily search in current buffer" })

        vim.keymap.set("n", "<leader>s/", function()
          builtin.live_grep({
            grep_open_files = true,
            prompt_title = "Live Grep in Open Files",
          })
        end, { desc = "[S]earch [/] in Open Files" })

        vim.keymap.set("n", "<leader>sn", function()
          builtin.find_files({ cwd = vim.fn.stdpath("config") })
        end, { desc = "[S]earch [N]eovim files" })
      end,
    },
    --}}}

    -- LSP {{{
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        { "j-hui/fidget.nvim", opts = {} },
      },
      config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
          callback = function(event)
            local map = function(keys, func, desc)
              vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
            end

            -- Jump to the definition of the word under your cursor.
            --  To jump back, press <C-T>.
            map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
            map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
            map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
            map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
            -- map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
            map(
              "<leader>ws",
              require("telescope.builtin").lsp_dynamic_workspace_symbols,
              "[W]orkspace [S]ymbols"
            )
            map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
            map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
            map("K", vim.lsp.buf.hover, "Hover Documentation")
            map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

            -- The following two autocommands are used to highlight references of the word under the cursor
            -- local client = vim.lsp.get_client_by_id(event.data.client_id)
            -- if client and client.server_capabilities.documentHighlightProvider then
            --   vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            --     buffer = event.buf,
            --     callback = vim.lsp.buf.document_highlight,
            --   })
            --   vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            --     buffer = event.buf,
            --     callback = vim.lsp.buf.clear_references,
            --   })
            -- end
          end,
        })

        vim.diagnostic.config({
          update_in_insert = false,
          virtual_text = false,
          signs = true,
          underline = false,
          float = {
            style = "minimal",
            border = "rounded",
            format = function(diagnostic)
              return string.format(
                "%s (%s) [%s]",
                diagnostic.message,
                diagnostic.source,
                diagnostic.code or diagnostic.user_data.lsp.code
              )
            end,
          },
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        local servers = {
          pyright = {},
          html = {
            filetypes = { 'html', 'volt' },
          },
          intelephense = {
            filetypes = { 'php', 'phtml' },
            init_options = {
              licenceKey = '~/intelephense/licence.txt',
            },
          },
          lua_ls = {
            settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    "${3rd}/luv/library",
                    unpack(vim.api.nvim_get_runtime_file("", true)),
                  },
                },
                completion = {
                  callSnippet = "Replace",
                },
                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                -- diagnostics = { disable = { 'missing-fields' } },
              },
            },
          },
        }

        -- Ensure the servers and tools above are installed (:Mason)
        require("mason").setup({
          ui = {
            border = "rounded",
          }
        })
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
          "stylua", -- Used to format lua code
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({
          handlers = {
            function(server_name)
              local server = servers[server_name] or {}
              server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
              require("lspconfig")[server_name].setup(server)
            end,
          },
        })
      end,
    },
    --}}}

    -- autoformat {{{
    {
      "stevearc/conform.nvim",
      event = { "BufWritePre" },
      cmd = { "ConformInfo" },
      keys = {
        {
          "<leader>f",
          function()
            require("conform").format({ async = true, lsp_fallback = true })
          end,
          mode = "",
          desc = "Format buffer",
        },
      },
      opts = {
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = { { "prettierd", "prettier" } },
        },
        --format_on_save = { timeout_ms = 500, lsp_fallback = true },
        formatters = {
          shfmt = {
            prepend_args = { "-i", "2" },
          },
        },
      },
      init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      end,
    },
    --}}}

    -- autocompletion {{{
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        {
          "L3MON4D3/LuaSnip",
          build = (function()
            if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
              return
            end
            return "make install_jsregexp"
          end)(),
        },
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",

        -- If you want to add a bunch of pre-configured snippets, use this plugin
        -- 'rafamadriz/friendly-snippets',
      },
      config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        luasnip.config.setup({})

        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          completion = { completeopt = "menu,menuone,noinsert" },

          -- For an understanding of why these mappings read `:help ins-completion`
          mapping = cmp.mapping.preset.insert({
            -- Select the [n]ext item
            ["<C-n>"] = cmp.mapping.select_next_item(),
            -- Select the [p]revious item
            ["<C-p>"] = cmp.mapping.select_prev_item(),

            -- Accept ([y]es) the completion.
            --  This will auto-import if your LSP supports it.
            --  This will expand snippets if the LSP sent a snippet.
            ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- NOTE: i'm not sure of select diff
            ["<CR>"] = cmp.mapping.confirm({ select = false }),

            -- Manually trigger a completion from nvim-cmp.
            --  Generally you don't need this, because nvim-cmp will display
            --  completions whenever it has completion options available.
            ["<C-Space>"] = cmp.mapping.complete({}),

            -- Think of <c-l> as moving to the right of your snippet expansion.
            --  So if you have a snippet that's like:
            --  function $name($args)
            --    $body
            --  end
            --
            -- <c-l> will move you to the right of each of the expansion locations.
            -- <c-h> is similar, except moving you backwards.
            ["<C-l>"] = cmp.mapping(function()
              if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              end
            end, { "i", "s" }),
            ["<C-h>"] = cmp.mapping(function()
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              end
            end, { "i", "s" }),
          }),
          sources = cmp.config.sources({
            { name = "codeium" },
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
          }),
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
        })
      end,
    },
    --}}}

    -- comment highlights {{{
    { -- adds highlight comment tags HACK FIX TODO NOTE WARNING
      "folke/todo-comments.nvim",
      event = "VimEnter",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = { signs = false },
    },
    --}}}

    -- mini plugins {{{
    {
      "echasnovski/mini.nvim",
      config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup({ n_lines = 500 })

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require("mini.surround").setup()

        --  Check out: https://github.com/echasnovski/mini.nvim for more
      end,
    },
    --}}}

    -- lualine {{{
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require("lualine").setup({
          options = {
            theme = 'poimandres',
            component_separators = '',
            section_separators = '',
            globalstatus = true,
          }
        })
      end
    },
    --}}}

    -- treesitter {{{
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.configs").setup({
          ensure_installed = { "bash", "css", "dockerfile", "gitignore", "html", "javascript", "json", "lua", "markdown", "php", "python", "yaml" },
          sync_install = true,
          auto_install = true,
          ignore_install = { "haskell" },
          highlight = {
            enable = true,
            disable = { "python" },
            additional_vim_regex_highlighting = false,
          },
          autopairs = {
            enable = true,
          },
          indent = {
            enable = true,
            disable = { "yaml", "python" },
          },
          matchup = {
            enable = true,
          },
        })
        -- to see default folds go to https://github.com/nvim-treesitter/nvim-treesitter/tree/master/queries
        require("vim.treesitter.query").set("php", "folds", [[
          [
            (function_definition)
            (interface_declaration)
            (trait_declaration)
            (function_static_declaration)
            (method_declaration)
          ] @fold
        ]])
      end,
    },
    --}}}

    -- pretty folding {{{
    {
      "anuvyklack/pretty-fold.nvim",
      config = function()
        require("pretty-fold").setup({
          sections = {
            left = {
              'content',
            },
            right = {
              ' ', 'number_of_folded_lines', ' ',
              function(config) return config.fill_char:rep(3) end
            },
          },
          fill_char = '·'
        })
      end
    },
    --}}}

    -- codeium AI {{{
    {
      "Exafunction/codeium.vim",
      event = "BufEnter",
    },
    --}}}

    -- colorscheme tokyonight {{{
    {
      "folke/tokyonight.nvim",
      -- lazy = false,
      -- priority = 1000,
      config = function()
        require("tokyonight").setup({
          style = "night",
          styles = {
            sidebars = "dark",
            floats = "dark",
          },
          sidebars = { "qf", "vista_kind", "terminal", "packer" },
          transparent = true,
          on_colors = function(colors)
            colors.border = colors.blue
          end,
          on_highlights = function(hl, c)
            hl.DiffAdd = { bg = "#608b4e", fg = "#1e1e1e" }
            hl.DiffChange = { bg = "none", fg = "#dcdcaa" }
            hl.DiffDelete = { bg = "#d16969", fg = "#1e1e1e" }
            hl.DiffText = { bg = "#77AEE9", fg = "#1e1e1e" }
            hl.FloatBorder = { fg = c.dark5 }
            hl.NormalFloat = { bg = "none" }
            hl.Folded = { fg = c.dark5 }
            hl.TelescopePreviewBorder = { fg = c.dark5 }
            hl.TelescopePreviewTitle = { fg = c.dark5 }
            hl.TelescopePromptBorder = { fg = c.dark5 }
            hl.TelescopePromptTitle = { fg = c.dark5 }
            hl.TelescopeResultsBorder = { fg = c.dark5 }
            hl.TelescopeResultsTitle = { fg = c.dark5 }
          end,
        })
      end,
      init = function()
        -- vim.cmd.colorscheme 'tokyonight'
        vim.cmd.hi("Comment gui=none")
      end,
    },
    --}}}

    -- colorscheme poimandres {{{
    {
      "olivercederborg/poimandres.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        require("poimandres").setup({
          bold_vert_split = false, -- use bold vertical separators
          dim_nc_background = false, -- dim 'non-current' window backgrounds
          disable_background = true, -- disable background
          disable_float_background = false, -- disable background for floats
          disable_italics = false, -- disable italics
        })
      end,
      init = function()
        vim.cmd("colorscheme poimandres")
      end,
    },
    --}}}

    -- color-overrides {{{
    { -- NOTE: need this when the colorscheme doesn't support overrides (tokyo does)
      "cwebster2/color-overrides.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        local override_reset = {
          "DiffAdd",
          "DiffDelete",
          "DiffChange",
          "DiffText",
          "Folded",
        }
        local override_set = {
          -- DiffAdd = { guibg = "#608b4e", guifg = "#e4f0fb" }, -- green bg, dark text (the line)
          -- DiffDelete = { guibg = "#d16969", guifg = "#e4f0fb" }, -- red bg, dark text (the line)
          -- DiffText = { guibg = "#8dddff", guifg = "#1e1e1e" }, -- blue bg, dark text (the actual change)
          DiffAdd = { guibg = "#1e2b31", guifg = "#65e4c7" }, -- green bg/text (line)
          DiffDelete = { guibg = "#2b2129", guifg = "#c85550" }, -- red bg/text (line)
          DiffChange = { guibg = "none", guifg = "#fffac2" }, -- no bg, yellow text (the line of the change)
          DiffText = { guibg = "#002b3d", guifg = "#90ddff" }, -- blue bg, dark text (the actual change)
          FloatBorder = { guibg = "NONE", guifg = "#9fdbfb" },
          Folded = { guibg = "NONE", guifg = "#7A8EA9" },
          MatchParen = { guibg = "NONE", guifg = "pink1" },
          NormalFloat = { guibg = "NONE" },
          TelescopePreviewBorder = { guibg = "NONE", guifg = "#9FDBFB" },
          TelescopePromptBorder = { guibg = "NONE", guifg = "#9FDBFB" },
          TelescopeResultsBorder = { guibg = "NONE", guifg = "#9FDBFB" },
          VertSplit = { guibg = "NONE", guifg = "#9FDBFB" },
        }
        require("color-overrides").set_overrides(override_reset, override_set)
      end,
    },
    --}}}

  },
  lazyOpts
)
--}}}
