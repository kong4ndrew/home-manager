-- Colorscheme-related Config --

-- Nightfox configuration
require('nightfox').setup({
    options = {
        styles = {
            comments  = "bold,italic",
            keywords  = "bold",
            types     = "bold",
            functions = "italic",
        },
    },
})

-- In the future, add a way to reload lualine and kitty as well?
function colormoi(color)
    color = color or 'dayfox'
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = none })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = none })

end

-- Make sure the function callsite comes AFTER the colorscheme setup, NOT before.
colormoi()

