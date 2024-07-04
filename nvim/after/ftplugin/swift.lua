-- Automatically insert comment leader after <CR> in
-- Insert mode and 'o' in Normal mode
vim.opt_local.formatoptions:prepend('or')

-- Don't put spaces between the commas! It gets added like ' +0'
-- https://neovim.io/doc/user/indent.html#indent-expression
-- '(1s' indents 1 shiftwidth when opening a new line inside of unclosed parens
-- '+0' doesn't indent "continuing lines" according to C-style syntax
-- 'p0' doesn't indent the parameters of a function according to C-style syntax
vim.opt_local.cindent = true
vim.opt_local.cinoptions:append('(1s,+0,p0,:0s')

-- Set these options despite already setting them in set.lua because
-- $VIMRUNTIME/ftplugin/swift.vim sets shiftwidth = 4, softtabstop = 4,
-- smartindent = true, and expandtab = true.
--
-- To see where an option was last set, open neovim with flag -V1 and run
-- ex command ':verbose set tabstop?' inside a buffer of the filetype in question.
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 0
vim.opt_local.shiftwidth = 2

-- Not working for some reason
vim.opt_local.colorcolumn = '100'
