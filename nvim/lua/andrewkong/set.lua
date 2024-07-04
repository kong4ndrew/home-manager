-- Default Vim Settings/Options --

vim.opt.nu             = true
vim.opt.relativenumber = true

vim.opt.tabstop        = 2                                    -- How many spaces <Tab> are. Helpful indenting info -> https://neovim.io/doc/user/usr_30.html#30.5
vim.opt.shiftwidth     = 2                                    -- How many spaces >> and << are
vim.opt.softtabstop    = 0                                    -- <BS> deletes this many spaces; check link above for details
vim.opt.expandtab      = true                                 -- Converts tabs to spaces
vim.opt.smarttab       = false                                -- At the beginning of a line, insert shiftwidth spaces; in the middle of a line, insert tabstop spaces
vim.opt.smartindent    = false                                -- Enabling this causes causes the closing brace to start one level shifted right for some reason
--vim.opt.colorcolumn    = '100'

vim.opt.wrap           = false

vim.opt.swapfile       = false                                -- Disable swapfiles
vim.opt.backup         = false                                -- By default backup = false and writebackup = true...
vim.opt.undodir        = os.getenv('HOME') .. '/.vim/undodir' -- In Lua, .. is the string concatenation operator
vim.opt.undofile       = true

vim.opt.hlsearch       = true                                 -- Prevent search highlights from persisting 
vim.opt.incsearch      = true                                 -- Use incremental search with regex to search complex entries!

--vim.opt.termguicolors  = true                                 -- Enabled by default from version 0.10.0

vim.opt.scrolloff      = 0                                    -- When scrolling with cursor, at least 'x' number of rows will be left between cursor and screen
vim.opt.signcolumn     = 'yes'                                -- A dedicated column for debugging signs etc.
vim.opt.isfname:append("@-@")                                 -- This allows vim to operate on files that have @ in their file name.

vim.opt.updatetime     = 50

vim.opt.foldmethod     = 'expr'                               -- Vim will scan each line for the provided definition of 'foldexpr'
vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'         -- Treesitter's foldexpr definitions
vim.opt.foldenable     = false                                -- Folds are disabled at startup

vim.opt.cursorline     = true                                 -- Enable cursorline highlights
vim.opt.cursorlineopt  = 'both'                               -- Set cursorline highlight option to just the line number of the cursor

vim.opt.showtabline    = 2                                    -- Always display tabline

vim.g.mapleader        = ' '
vim.opt.conceallevel   = 1                                    -- Conceal for markdown and LaTeX files
vim.opt.hlsearch       = false                                -- Turn off highlighting for searches
vim.opt.syntax         = 'off'                                -- Turn off syntax highlighting
