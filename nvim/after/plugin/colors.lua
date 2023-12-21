-- Colorscheme-related Config --

-- Nightfox configuration
require('nightfox').setup({
    options = {
        styles = {
            comments     = "bold,italic",
            keywords     = "bold",
            conditionals = "bold",
            types        = "bold",
            functions    = "italic",
        },
    },
    palettes = {
        dayfox = {
            black   = "#000000",
            red     = "#9A3324",
            green   = "#067E00",
            yellow  = "#C48200",
            blue    = "#046F9E",--"#036894", --"#052CA3",
            magenta = "#8C0150",
            cyan    = "#145C1A",
            white   = "#FFFFFF",
            orange  = "#C93912",
            pink    = "#732C96", -- Purple
        },
    },
    specs = {
        dayfox = {
            syntax = {
                bracket  = "black",
                func     = "cyan",
                operator = "black",
                variable = "pink",
            },
            -- diag = {},
        },
    },
})

-- In the future, add a way to reload lualine and kitty as well?
function Colorme(color)
    color = color or 'dayfox'
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = none })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = none })

    -- vim.api.nvim_set_hl(0, "Cursor", { bg = '#FFFFFF' }) This didn't change anything...
    vim.api.nvim_set_hl(0, "CursorLine", { bg = '#EDF5FF' })
end

-- Make sure the function callsite comes AFTER the colorscheme setup, NOT before.
Colorme()

