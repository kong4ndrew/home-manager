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
            blue    = "#057CB0", --"#052CA3",
            magenta = "#8C0150",
            cyan    = "#145C1A",
            white   = "#FFFFFF",
            orange  = "#C93912",
            pink    = "#732C96",
        },
    },
    specs = {
        dayfox = {
            syntax = {
                func = "cyan",
            },
--            diag = {},
        },
    },
})

-- In the future, add a way to reload lualine and kitty as well?
function Colorme(color)
    color = color or 'dayfox'
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = none })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = none })

end

-- Make sure the function callsite comes AFTER the colorscheme setup, NOT before.
Colorme()

