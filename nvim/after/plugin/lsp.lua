-- LSP Zero Configs --

local lsp_zero = require('lsp-zero')


-- Setup keybindings only when a language server is attached. Unnamed argument label for client
-- in the on.attach function because it's not being used at the moment.
lsp_zero.on_attach(function(_, bufnr)
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

-- LSP Semantic Token Integration
--lsp_zero.set_server_config({
--    on_init = function(client)
--        client.server_capabilities.semanticTokenProvider = nil
--    end,
--})

lsp_zero.set_sign_icons({
    error = '',
    warn  = '',
    hint  = '',
    info  = '',
})

-- Use :LspZeroViewConfigSource sourcekit to see config options!
lsp_zero.setup_servers({'nixd', 'bashls', 'texlab'})

lsp_zero.configure('sourcekit', {
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true
            },
        },
    },
})

lsp_zero.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = {'vim'},
            }
        }
    }
})

-- Once you declare cmp.setup, I think you have to manually set up everything related to
-- autocomplete which was otherwise automatically done by lsp-zero. So yeah... keep that in mind.
-- Also make sure to setup cmp after lsp-zero
local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')                              -- For icons in the popup window

cmp.setup({
    window = {
        completion    = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert{
        ['<C-n>']       = cmp.mapping.select_next_item(),
        ['<C-p>']       = cmp.mapping.select_prev_item(),
        ['<C-S-Space>'] = cmp.mapping.complete(),               -- Trigger completion menu
        ['<C-u>']       = cmp.mapping.scroll_docs(-4),          -- Scroll up the documentation window
        ['<C-d>']       = cmp.mapping.scroll_docs(4),           -- Scroll up the documentation window
        ['<C-y>']       = cmp.mapping.confirm({                 -- Confirm completion item
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),

        --['<Tab>'] = cmp.mapping(function(fallback)              -- Also allowing Tab to select next item or expand snippet
        --    if cmp.visible() then
        --        cmp.select_next_item()
        --    elseif luasnip.expand_or_locally_jumpable() then
        --        luasnip.expand_or_jump()
        --    else
        --        fallback()
        --    end
        --end, { 'i', 's' }),

        --['<S-Tab>'] = cmp.mapping(function(fallback)            -- Also allowing S-Tab to select previous item or jump back
        --    if cmp.visible() then
        --        cmp.select_prev_item()
        --    elseif luasnip.locally_jumpable(-1) then
        --        luasnip.jump(-1)
        --    else
        --        fallback()
        --    end
        --end, { 'i', 's' }),

        --['<CR>'] = cmp.mapping(function(fallback)               -- Also allowing <CR> to confirm completion or expand snippet(?)
        --    if cmp.visible() then                               -- Don't enable this, it messes things up if you want to put a newline after expanding a snippet
        --        cmp.confirm({
        --            behavior = cmp.ConfirmBehavior.Replace,
        --            select = true
        --        })
        --    elseif luasnip.expand_or_locally_jumpable() then
        --        luasnip.expand_or_jump()
        --    else
        --        fallback()
        --    end
        --end, { 'i', 's' }),
    },
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'luasnip', keyword_length = 2 },                -- keyword_length is the number of characters needed to trigger autocomplete
        { name = 'buffer' , keyword_length = 3 },
    },
    formatting = {
        format = lspkind.cmp_format({ })
    }
})
