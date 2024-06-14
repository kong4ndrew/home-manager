-- Colorscheme-related Config --

-- Nightfox configuration

-- Chore: Try to emulate xcode colorscheme
local shade    = require('nightfox.lib.shade')

local options = {
    styles = {
        comments     = 'bold,italic',
        conditionals = 'italic',
        keywords     = 'bold',
        types        = 'bold',
        functions    = 'italic',
    },
}
        -- bg0     = '',
        -- bg1     = '',
        -- bg2     = '',
        -- bg3     = '',
        -- bg4     = '',
        -- fg0     = '',
        -- fg1     = '',
        -- fg2     = '',
        -- fg3     = '',
        -- sel0    = '',
        -- sel1    = '',
local palettes = {
    dayfox = {
        black   = '#000000',
        red     = '#C41A16',                                              -- Strings
        green   = shade.new('#326D74', '#1C464A','#1C464A', '#326D74'),   -- Project Constants, Project Class Names
        yellow  = shade.new('#815F03', '#643820', '#815F03', '#815F03'),  -- Attributes, Other Preprocessor
        blue    = shade.new('#1C00CF', '#1C00CF', '#0E0EFF', '#1C00CF'),  -- Numbers, URLs
        magenta = shade.new('#9B2393', '#AD3DA4', '#AA0D91', '#9B2393'),  -- Keywords, Preproc State, Heading
        cyan    = shade.new('#0F68A0', '#0B4F79', '#0F68A0', '#0F68A0'),  -- Other Declarations, Type Declarations
        white   = '#FFFFFF',
        orange  = '#643820',                                              -- Unused
        pink    = shade.new('#6C36A9','#3900A0', '#6C36A9', '#6C36A9'),   -- Other Class Names, Other Constants
        comment = '#5D6C79',                                              -- Comments (Note: comment cannot be a shade)
    },
}
-- 
local specs = {
    dayfox = {
        syntax = {
            bracket     = 'black',
            builtin0    = 'magenta',
            builtin1    = 'pink.bright',
            builtin2    = 'pink.dim',
            comment     = 'comment',
            conditional = 'magenta.bright',
            const       = 'pink.bright',
            dep         = 'comment',
            field       = 'magenta.bright',
            func        = 'pink',
            ident       = 'cyan',
            keyword     = 'magenta.bright',
            number      = 'blue',
            operator    = 'black',
            preproc     = 'yellow.bright',
            regex       = 'red',
            statement   = 'black', -- ?
            string      = 'red',
            type        = 'pink.bright',
            variable    = 'magenta.bright',
        },
    },
}
require('nightfox').setup({
    options  = options,
    palettes = palettes,
    specs    = specs,
})

-- require('nightfox').setup({
--     options = {
--         styles = {
--             comments     = 'bold,italic',
--             keywords     = 'bold',
--             conditionals = 'bold',
--             types        = 'bold',
--             functions    = 'italic',
--         },
--     },
--     palettes = {
--         dayfox = {
--             black   = '#000000',
--             red     = '#9A3324',
--             green   = '#067E00',
--             yellow  = '#C48200',
--             blue    = '#046F9E',--'#036894', --'#052CA3',
--             magenta = '#8C0150',
--             cyan    = '#145C1A',
--             white   = '#FFFFFF',
--             orange  = '#C93912',
--             pink    = '#732C96', -- Purple
--         },
--     },
--     specs = {
--         dayfox = {
--             syntax = {
--                 bracket  = 'black',
--                 func     = 'cyan',
--                 operator = 'black',
--                 variable = 'pink',
--                 string   = 'orange',
--             },
--             -- diag = {},
--         },
--     },
-- })

function Colorme(color)
    color = color or 'dayfox'
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

    -- vim.api.nvim_set_hl(0, 'Cursor', { bg = '#FFFFFF' }) This didn't change anything...
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#EDF5FF' })
end

-- Make sure the function callsite comes AFTER the colorscheme setup, NOT before.
Colorme()

