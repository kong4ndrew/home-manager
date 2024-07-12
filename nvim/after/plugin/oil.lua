-- Oil Config
local oil = require('oil')

oil.setup({
  -- Buffer-local options to use for oil buffers
  buf_options = {
    buflisted = true,
    bufhidden = 'hide',
  },
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  -- Oil will automatically delete hidden buffers after this delay.
  -- Set the delay to false to disable cleanup entirely (allowing <leader>re to be used)
  cleanup_delay_ms = false,
  experimental_watch_for_changes = true,
  keymaps = {
    -- Works in conjunction with <leader>re keymap set below
    ['<CR>'] = function()
      local cursor = vim.api.nvim_win_get_cursor(0)

      vim.api.nvim_buf_set_mark(0, 'Q', cursor[1], cursor[2], {})
      oil.select()
    end,
  },
  view_options = {
      show_hidden = true,
  },
})

vim.keymap.set('n', '<leader>e', '<CMD>Oil<CR>')

-- My replacement for netrw :Rex command. You have to set this outside of oil's
-- custom keymapping for it to work outside of oil buffers.
vim.keymap.set('n', '<leader>re', function()
  local name = vim.api.nvim_buf_get_name(0)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local cwd = vim.fn.getcwd()

  if name:match('^oil:///') then
    vim.api.nvim_buf_set_mark(0, 'Q', cursor[1], cursor[2], {})
    if pcall(oil.close) then
      oil.close()
    elseif pcall(function() vim.cmd('normal `P') end) then
      vim.cmd('normal `P')
    else oil.open(cwd)
    end
  else
    vim.api.nvim_buf_set_mark(0, 'P', cursor[1], cursor[2], {})
    if pcall(function() vim.cmd('normal `Q') end) then
      vim.cmd('normal `Q')
    else oil.open(cwd)
    end
  end

  vim.fn.chdir(cwd)
  vim.print('CWD: ' .. cwd)
end)
