-- LSP Configs --

local lsp_zero = require('lsp-zero')

-- Setup keybindings only when a language server is attached
lsp_zero.on_attach(function(client, bufnr)
local opts = { buffer = bufnr, remap = false }

vim.keymap.set('n', 'gd'         , function() vim.lsp.buf.definition() end      , opts)
vim.keymap.set('n', 'K'          , function() vim.lsp.buf.hover() end           , opts)
vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
vim.keymap.set('n', '<leader>vd' , function() vim.diagnostic.open_float() end   , opts)
vim.keymap.set('n', '[d'         , function() vim.diagnostic.goto_next() end    , opts)
vim.keymap.set('n', ']d'         , function() vim.diagnostic.goto_prev() end    , opts)
vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end     , opts)
vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end      , opts)
vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end          , opts)
vim.keymap.set('i', '<C-h>'      , function() vim.lsp.buf.signature_help() end  , opts)

end)

-- Use :LspZeroViewConfigSource sourcekit to see config options!
require('lspconfig').sourcekit.setup({ })
require('lspconfig').nixd.setup({ })
require('lspconfig').bashls.setup({ })
require('lspconfig').lua_ls.setup({
    settings = {
        diagnostics = {
            globals = { 'vim' }
        }
    }
})
-- lsp_zero.setup_servers({ 'sourcekit', 'lua_ls', 'nixd', 'bashls' })
