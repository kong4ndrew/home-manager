-- Tabby Config --

require('tabby.tabline').use_preset('active_wins_at_tail', {
  nerdfont = true,           -- whether to use nerdfont or not
  lualine_theme = 'dayfox',  -- lualine theme name
  tab_name = {
    name_fallback = function(tabid)
      return tabid
    end,
  },
  buf_name = {
    mode = "'unique'|'relative'|'tail'|'shorten'",
  },
})
