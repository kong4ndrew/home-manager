-- Treesitter Config --
-- Note: Neovim's built-in :InspectTree command now replaces the need for TSPlayground

require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = false,
    },
})
