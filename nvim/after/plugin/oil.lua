require("oil").setup({
    -- Buffer-local options to use for oil buffers
    buf_options = {
        buflisted = true,
        bufhidden = "hide",
    },
    -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
    delete_to_trash = true,
    -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
    skip_confirm_for_simple_edits = true,
    -- Oil will automatically delete hidden buffers after this delay
    -- You can set the delay to false to disable cleanup entirely
    -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
    -- Set this to false if you want to be able to jump back and forth using <C-o> and <C-i> like <leader>re
    cleanup_delay_ms = false,
    -- Constrain the cursor to the editable parts of the oil buffer
    -- Set to `false` to disable, or "name" to keep it on the file names
    constrain_cursor = "editable",
    -- Set to true to watch the filesystem for changes and reload oil
    experimental_watch_for_changes = true,
    -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
    -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
    -- Additionally, if it is a string that matches "actions.<name>",
    -- it will use the mapping at require("oil.actions").<name>
    -- Set to `false` to remove a keymap
    -- See :help oil-actions for a list of all available actions
    keymaps = {
        -- ["<leader>re"] = "actions.close",
    },
    view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
    },
})

vim.keymap.set('n', '<leader>e', '<CMD>Oil<CR>')

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
