vim.opt.autoindent = true
vim.opt.backspace = 'indent,start,eol'
vim.opt.backup = false
vim.opt.belloff  = 'all'
vim.opt.clipboard = 'unnamedplus'
vim.opt.cmdheight = 1
vim.opt.colorcolumn = '99999'
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.conceallevel = 0
vim.opt.cursorline = true
vim.opt.diffopt = vim.opt.diffopt + 'foldcolumn:0'
vim.opt.expandtab = true
vim.opt.fileencoding = "utf-8"
vim.opt.foldexpr = ""
vim.opt.foldmethod = "manual"
vim.opt.formatoptions = vim.opt.formatoptions + 'j'
vim.opt.formatoptions = vim.opt.formatoptions + 'n'
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.joinspaces = false
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.modelines = 5
vim.opt.mouse = "a"
vim.opt.number = false
vim.opt.numberwidth = 4
vim.opt.pumheight = 10
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.showtabline = 0
vim.opt.sidescroll = 0
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.spell = false
vim.opt.spelllang = 'en'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 100
vim.opt.title = true
vim.opt.titlestring = "%<%F%=%l/%L - nvim"
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.virtualedit = 'block'
vim.opt.visualbell  = true
vim.opt.wrap = false
vim.opt.writebackup = false

vim.opt.fillchars = {
    diff        = '∙',          -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
    eob         = ' ',          -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
    fold        = '·',          -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
    vert        = '┃',          -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
}
vim.opt.listchars = {
    nbsp        = '⦸',          -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
    extends     = '»',          -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
    precedes    = '«',          -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
    tab         = '▷⋯',         -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + MIDLINE HORIZONTAL ELLIPSIS (U+22EF, UTF-8: E2 8B AF)
    trail       = '•',          -- BULLET (U+2022, UTF-8: E2 80 A2)
}

-- legacy vimscript
vim.cmd([[
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

    filetype on
    au BufNewFile,BufRead *.ihtml set filetype=php
    au BufNewFile,BufRead *.volt set filetype=html
    autocmd FileType coffee setlocal shiftwidth=2 softtabstop=2 expandtab
    autocmd FileType php setlocal shiftwidth=4 softtabstop=4 expandtab
    autocmd FileType php set kp=:help

    let s:middot='·'
    let s:raquo='»'
    let s:small_l='ℓ'
    function! GetSpaces(foldLevel)
        if &expandtab == 1
            " Indenting with spaces
            let str = repeat(" ", a:foldLevel / (&shiftwidth + 1) - 1)
            return str
        elseif &expandtab == 0
            " Indenting with tabs
            return repeat(" ", indent(v:foldstart) - (indent(v:foldstart) / &shiftwidth))
        endif
    endfunction
    function! CustomFoldText() abort
        let l:lines='[' . (v:foldend - v:foldstart + 1) . ' lines' . ']'
        let startLineText = getline(v:foldstart)
        let endLineText = trim(getline(v:foldend))
        let indentation = GetSpaces(foldlevel("."))
        let spaces = repeat(" ", 400)
        "let str = indentation . startLineText . " " . s:middot . s:middot . l:lines . s:middot . s:middot . " " . endLineText . spaces
        let str = indentation . " " . s:middot . s:middot . s:middot . l:lines . s:middot . s:middot . s:middot . spaces
        return str
    endfunction
    set nofoldenable
    " set foldmethod=expr
    " set foldexpr=nvim_treesitter#foldexpr()
    " autocmd FileType php set foldmethod=expr foldexpr=nvim_treesitter#foldexpr() "PHP Folding only
    "*** neovim treesitter expr not working well - switched to indent
    autocmd FileType php set foldmethod=indent foldexpr=nvim_treesitter#foldexpr() "PHP Folding only
    set foldlevel=1
    set foldlevelstart=1
    set foldnestmax=2
    set foldtext=CustomFoldText()

    let g:dnum=1
    func! ToggleNumbers()
      if (g:dnum)
        set number! relativenumber!
        let g:dnum=0
      else
        set number relativenumber
        let g:dnum=1
      endif
    endfunc
    nmap <f10> :call ToggleNumbers()<cr>
    nmap <leader>ln :call ToggleNumbers()<cr>

    if has('macunix')
      set clipboard=unnamed,unnamedplus
      vmap <C-x> :!pbcopy<CR>
      vmap <C-c> :w !pbcopy<CR><CR>
    endif
    noremap YY "+y<CR>
    noremap <leader>p "+gP<CR>
    noremap XX "+x<CR>

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
