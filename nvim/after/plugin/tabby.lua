-- Tabby Config --

-- Taken from xiehuc's lualine color and bubble theme found here:
-- https://github.com/nanozuki/tabby.nvim/discussions/51 and adapted
-- to work with tabby's new setup method
local util = require('tabby.util')

local hl_tabline_fill = util.extract_nvim_hl('lualine_c_normal')
local hl_tabline = util.extract_nvim_hl('lualine_b_normal')
local hl_tabline_sel = util.extract_nvim_hl('lualine_a_normal')
local hl_win = util.extract_nvim_hl('lualine_b_visual')
local hl_win_sel = util.extract_nvim_hl('lualine_a_visual')

require('tabby.tabline').set(
  function(line)
    return {
      {
        { '  ', hl = { fg = hl_win_sel.fg, bg = hl_win_sel.bg } },
        line.sep('', hl_win_sel, hl_tabline_fill),
      },
      line.tabs().foreach(function(tab)
        local hl = tab.is_current() and hl_tabline_sel or hl_tabline
        return {
          line.sep(' ', hl, hl_tabline_fill),
          tab.is_current() and '' or '',
          tab.number(),
          tab.name(),
          line.sep(' ', hl, hl_tabline_fill),
          hl = hl,
          margin = ' ',
        }
      end),
      line.spacer(),
      line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
        local hl = win.is_current() and hl_win_sel or hl_win
        return {
          line.sep(' ', hl, hl_tabline_fill),
          win.is_current() and '' or '',
          win.buf_name(),
          line.sep(' ', hl, hl_tabline_fill),
          hl = hl,
          margin = ' ',
        }
      end),
      {
        line.sep(' ', hl_tabline_sel, hl_tabline_fill),
        { '  ', hl = hl_tabline_sel },
      },
      hl = hl_tabline_fill
    }
  end)

