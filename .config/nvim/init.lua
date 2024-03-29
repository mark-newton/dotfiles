-- OPTIONS {{{
vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.g.have_nerd_font = true

vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.breakindent = true
-- vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.cmdheight = 1
vim.opt.completeopt = { "menuone", "noselect" }
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
vim.opt.pumheight = 10
vim.opt.relativenumber = false
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.shortmess:append("c")
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.wrap = false
vim.opt.writebackup = false

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
vim.opt.foldenable = false -- turn off by default (turn on by filetype)
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
--vim.keymap.set("n", "<leader>a", "<cmd>%y+<cr>") -- remapping leader-a to ai keymaps
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

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
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.volt",
  callback = function()
    vim.opt.filetype = "html"
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "vim" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
    vim.opt.foldenable = true
    vim.opt.foldmethod = "marker"
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
    vim.opt_local.smartindent = true
    vim.opt_local.cindent = true
    vim.opt_local.indentexpr = ""
    vim.opt.kp = ":help"
    vim.opt.foldenable = true
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "coffee" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Show cursor line on active window only
local cursorGrp = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  pattern = "*",
  command = "set cursorline",
  group = cursorGrp,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  pattern = "*",
  command = "set nocursorline",
  group = cursorGrp,
})
--}}}

-- FUNCTIONS {{{

-- Diagnostic signs
local function sign_define(args)
  vim.fn.sign_define(args.name, {
    texthl = args.name,
    text = args.text,
    numhl = "",
  })
end
sign_define({ name = "DiagnosticSignError", text = "" })
sign_define({ name = "DiagnosticSignWarn", text = "" })
sign_define({ name = "DiagnosticSignHint", text = "" })
sign_define({ name = "DiagnosticSignInfo", text = "" })

-- Update last modified date
function LastMod()
  local save_cursor = vim.fn.getpos(".")
  local l
  if vim.fn.line("$") > 20 then
    l = 20
  else
    l = vim.fn.line("$")
  end
  vim.fn.cursor(1, 1)
  if vim.fn.search("@modified", "W", l) > 0 then
    vim.cmd("1," .. l .. "g/@modified /s/@modified .*/@modified " .. os.date("%d-%b-%Y"))
  end
  vim.fn.setpos(".", save_cursor)
end
vim.cmd([[
  autocmd BufWrite * :lua LastMod()
]])
vim.api.nvim_set_keymap("n", "<leader>mod", ":lua LastMod()<CR>", { noremap = true, silent = true })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

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
  ui = {
    border = "rounded",
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
}
--}}}

-- Lazy Plugins
require("lazy").setup({
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
        ["<leader>a"] = { name = "[A]i", _ = "which_key_ignore" },
        ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
        ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
        ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
        ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
        ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
      })
    end,
  },
  --}}}

  -- AI plugins {{{
  -- NOTE: the chatgpt plugins require $OPENAI_API_KEY to be set
  {
    "Exafunction/codeium.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({})
    end,
  },

  {
    "robitx/gp.nvim",
    config = function()
      require("gp").setup({
        toggle_target = "vsplit",
        style_chat_finder_border = "rounded",
        style_popup_border = "rounded",
      })

      vim.keymap.set("n", "<leader>an", "<cmd>GpChatNew<cr>", { desc = "[A]i [N]ew chat" })
      vim.keymap.set("n", "<leader>at", "<cmd>GpChatToggle<cr>", { desc = "[A]i [T]oggle chat" })
      vim.keymap.set("v", "<leader>ap", ":<C-u>'<,'>GpChatPaste<cr>", { desc = "[A]i [P]aste into chat" })
      vim.keymap.set("n", "<leader>a4", "<cmd>GpAgent ChatGPT4<cr>", { desc = "[A]i chat agent gpt[4]" })
      vim.keymap.set("n", "<leader>a3", "<cmd>GpAgent ChatGPT3-5<cr>", { desc = "[A]i chat agent gpt[3].5" })
      vim.keymap.set("n", "<leader>as", "<cmd>GpChatFinder<cr>", { desc = "[A]i [S]earch chats" })
      vim.keymap.set("n", "<leader>sa", "<cmd>GpChatFinder<cr>", { desc = "[S]earch [A]i chats" })
    end,
  },
  --}}}

  -- LSP {{{
  -- neodev provides lua libs
  { 'folke/neodev.nvim', opts = {} },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      -- { "j-hui/fidget.nvim", opts = {} }, -- enable if you want LSP diagnostics
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
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

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
          filetypes = { "html", "volt" },
        },
        intelephense = {
          filetypes = { "php", "phtml" },
          init_options = {
            licenceKey = "~/intelephense/licence.txt",
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = {
                globals = {'vim'},
                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                disable = { 'missing-fields' }
              },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed (:Mason)
      require("mason").setup({
        ui = {
          border = "rounded",
        },
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
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
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
      pcall(require("telescope").load_extension, "noice")
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

  -- treesitter {{{
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "bash", "lua", "php" },
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
          enable = false, -- indent is buggy
        },
        matchup = {
          enable = true,
        },
      })
      -- to see default folds go to https://github.com/nvim-treesitter/nvim-treesitter/tree/master/queries
      require("vim.treesitter.query").set(
        "php",
        "folds",
        [[
          [
            (function_definition)
            (interface_declaration)
            (trait_declaration)
            (function_static_declaration)
            (method_declaration)
          ] @fold
        ]]
      )
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
        php = { "pint" },
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
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        build = "make install_jsregexp"
      },
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup({})
      require("luasnip.loaders.from_vscode").lazy_load()

      local check_backspace = function()
        local col = vim.fn.col "." - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        -- completion = { completeopt = "menu,menuone,noselect,noinsert" },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          },
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          -- <c-l> will move you to the right of each of the expansion locations.
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          -- <c-h> will move you to the left of each of the expansion locations.
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
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        experimental = {
          ghost_text = true,
        },
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
          ['<Down>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
          ['<Up>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
        }),
        sources = cmp.config.sources({
          {
            name = "path",
            option = {
              trailing_slash = true
            }
          },
        },{
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            }
          }
        }),
      })
    end,
  },
  --}}}

  -- mini plugins {{{
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      -- Examples:
      --  - yaf  - [Y]ank [A]round [F]unction
      --  - ya)  - [Y]ank [A]round [)]paren
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- Examples:
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      --  Check out: https://github.com/echasnovski/mini.nvim for more
    end,
  },
  --}}}

  -- vim-sleuth {{{
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  --}}}

  -- comment {{{
  { "numToStr/Comment.nvim", opts = {} }, -- gc commenting
  --}}}

  -- comment highlights {{{
  { -- adds highlight comment tags HACK FIX TODO NOTE WARNING
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
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
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Go to next [C]hange" })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Go to prev [C]hange" })

          map("n", "<leader>gd", gs.diffthis, { desc = "[G]it [D]iff" })
          map("n", "<leader>gp", gs.preview_hunk, { desc = "[G]it [P]review hunk" })
          map("n", "<leader>gr", gs.reset_hunk, { desc = "[G]it [R]eset hunk" })
        end,
      })
    end,
  },
  --}}}

  -- lualine {{{
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = "",
          section_separators = "",
          globalstatus = true,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {
            {
              'filetype',
              icon_only = true,
              padding = { left = 1, right = 0 },
            },
            {
              'filename',
              path = 4,
              color = function()
                return { fg = vim.bo.modified and 'orange' or 'white' }
              end,
              padding = { left = 0, right = 1 },
            },
          },
          lualine_c = {
            {
              'branch',
              icon = {''},
            },
            {
              'diff',
              symbols = { added = " ", modified = " ", removed = " ", },
            },
          },
          lualine_x = {
            {
              function()
                local msg = '[no lsp]'
                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                local clients = vim.lsp.get_active_clients()
                if next(clients) == nil then
                  return msg
                end
                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return '['..client.name..']'
                  end
                end
                return msg
              end,
              padding = { left = 0, right = 1 },
            },
            { 'diagnostics', padding = { left = 0, right = 1 } },
            'encoding',
            'filesize'
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%d-%b %R")
            end,
          },
        },
      })
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
            "content",
          },
          right = {
            " ",
            "number_of_folded_lines",
            " ",
            function(config)
              return config.fill_char:rep(3)
            end,
          },
        },
        fill_char = "·",
      })
    end,
  },
  --}}}

  -- noice {{{
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        view = "cmdline",
      },
      views = {
        cmdline_popup = {
          position = {
            -- row = 11,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
          win_options = {
            winhighlight = { NormalFloat = "NormalFloat", FloatBorder = "FloatBorder" },
          },
        },
        hover = {
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "FloatBorder" },
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            -- row = 14,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "FloatBorder" },
          },
        },
        mini = {
          timeout = 4000,
          win_options = {
            winblend = 0,
          },
        },
      },
      lsp = {
        hover = { enabled = false },
        signature = { enabled = false },
      },
      presets = {
        bottom_search = true,
        long_message_to_split = true,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },
  --}}}

  -- colorscheme tokyonight {{{
  {
    "folke/tokyonight.nvim",
    event = "VeryLazy", -- uncomment when NOT using Tokyo
    -- lazy = false,    -- uncomment when using Tokyo
    -- priority = 1000, -- uncomment when using Tokyo
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
          hl.DiffAdd = { bg = "#315532", fg = "#ffffff" }
          hl.DiffDelete = { bg = "#713431", fg = "#ffffff" }
          hl.DiffText = { bg = "#29416f", fg = "#ffffff" }
          hl.DiffChange = { bg = "NONE", fg = "#afd7ff" }
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
      -- vim.cmd.colorscheme 'tokyonight' -- uncomment when using Tokyo
      -- vim.cmd.hi("Comment gui=none")   -- uncomment when using Tokyo
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
        DiffAdd = { guibg = "#315532", guifg = "#ffffff" }, -- new line
        DiffDelete = { guibg = "#713431", guifg = "#ffffff" }, -- del line
        DiffText = { guibg = "#29416f", guifg = "#ffffff" }, -- change text
        DiffChange = { guibg = "NONE", guifg = "#afd7ff" }, -- change line
        DiagnosticVirtualTextError = { guibg = "#2d202a", guifg = "#db4b4b" },
        DiagnosticVirtualTextHint = { guibg = "#1a2b32", guifg = "#1abc9c" },
        DiagnosticVirtualTextInfo = { guibg = "#192b38", guifg = "#0db9d7" },
        DiagnosticVirtualTextWarn = { guibg = "#2e2a2d", guifg = "#e0af68" },
        FloatBorder = { guibg = "NONE", guifg = "#5c9fd7" },
        Folded = { guibg = "NONE", guifg = "#7A8EA9" },
        MatchParen = { guibg = "NONE", guifg = "pink1" },
        NormalFloat = { guibg = "NONE" },
        WhichKeyFloat = { guibg = "NONE" },
        TelescopePreviewBorder = { guibg = "NONE", guifg = "#5c9fd7" },
        TelescopePromptBorder = { guibg = "NONE", guifg = "#5c9fd7" },
        TelescopeResultsBorder = { guibg = "NONE", guifg = "#5c9fd7" },
        VertSplit = { guibg = "NONE", guifg = "#9FDBFB" },
        Search = { guibg = "#62ddc1", guifg = "#1b1e28"}, -- search matches
        IncSearch = { guibg = "#d9d5a5", guifg = "#1b1e28"}, -- current search
        LspReferenceText = { guibg = "#3b3e4e" }, -- hover highlights
        LspReferenceWrite = { guibg = "#3b3e4e" }, -- hover highlight refs
        LspReferenceRead = { guibg = "#3b3e4e" }, -- hover highlight active
        CursorLine = { guibg = "#212431" },
      }
      require("color-overrides").set_overrides(override_reset, override_set)
    end,
  },
  --}}}
}, lazyOpts)
--}}}
