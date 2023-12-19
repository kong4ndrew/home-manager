-- Tabby Config --

require('tabby.tabline').use_preset('active_wins_at_tail', {
  nerdfont = true,                   -- whether use nerdfont
  lualine_theme = 'dayfox',          -- lualine theme name
  tab_name = {
    name_fallback = function(tabid)
      return tabid
    end,
  },
  buf_name = {
    mode = "'unique'|'relative'|'tail'|'shorten'",
  },

})
