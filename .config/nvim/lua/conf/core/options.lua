local opt = vim.opt

opt.autoindent = true
opt.background = "dark"
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.cmdheight = 1
opt.colorcolumn = "99999"
opt.conceallevel = 0
opt.cursorline = true
opt.expandtab = true
opt.fileencoding = "utf-8"
opt.foldexpr = ""
opt.foldmethod = "manual"
opt.hidden = true
opt.hlsearch = true
opt.ignorecase = true
opt.inccommand = "split"
opt.iskeyword:append("-")
opt.joinspaces = false
opt.laststatus = 3
opt.list = true
opt.modelines = 5
opt.mouse = "a"
opt.number = true
opt.numberwidth = 4
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 8
opt.shiftwidth = 4
opt.showmode = false
opt.showtabline = 0
opt.sidescroll = 0
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smarttab = true
opt.spell = false
opt.spelllang = "en"
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
opt.termguicolors = true
opt.timeoutlen = 300 -- this seesm to be the leader resolve timeout
opt.title = true
opt.titlestring = "%<%F%=%l/%L - nvim"
opt.undodir = vim.fn.stdpath("cache") .. "/undo"
opt.undofile = true
opt.updatetime = 300
opt.virtualedit = "block"
opt.visualbell = true
opt.wrap = false
opt.writebackup = false
opt.smartindent = true

opt.fillchars = {
    diff = "∙", -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
    eob = " ", -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
    fold = "·", -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
    vert = "┃", -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
}
opt.listchars = {
    nbsp = "⦸", -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
    extends = "»", -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
    precedes = "«", -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
    tab = "▷⋯", -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + MIDLINE HORIZONTAL ELLIPSIS (U+22EF, UTF-8: E2 8B AF)
    trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
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
        let str = indentation . startLineText . " " . s:middot . s:middot . l:lines . s:middot . s:middot . " " . endLineText . spaces
        return str
    endfunction
    " set foldenable
    " let php_folding=1
    " autocmd FileType php set foldmethod=syntax
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
