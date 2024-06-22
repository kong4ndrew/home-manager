-- Oil Config

require("oil").setup({
    -- Buffer-local options to use for oil buffers
    buf_options = {
        buflisted = true,
        bufhidden = "hide",
    },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    -- Oil will automatically delete hidden buffers after this delay.
    -- Set the delay to false to disable cleanup entirely (allowing <leader>re to be used)
    cleanup_delay_ms = false,
    experimental_watch_for_changes = true,
    view_options = {
        show_hidden = true,
    },
})

vim.keymap.set('n', '<leader>e', '<CMD>Oil<CR>')

-- My replacement for netrw :Rex command
vim.keymap.set('n', '<leader>re', function()
    local oil = require('oil')

    local buffer = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(0)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line = cursor[1]
    local col = cursor[2]

    if name:match('^oil:///') then
        vim.api.nvim_buf_set_mark(buffer, 'Q', line, col, {})
        if pcall(oil.close) then
            oil.close()
        elseif pcall(function() vim.cmd('normal `P') end) then
            vim.cmd('normal `P')
        else oil.open()
        end
    else
        vim.api.nvim_buf_set_mark(buffer, 'P', line, col, {})
        if pcall(function() vim.cmd('normal `Q') end) then
            vim.cmd('normal `Q')
        else oil.open()
        end
    end
end)
