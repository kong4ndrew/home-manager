-- Lualine Config -- 

local dayfox = require('lualine.themes.dayfox')
dayfox.normal.a.bg  = '#DF8666'
dayfox.normal.a.fg  = '#FFFFFF'
dayfox.normal.b.bg  = '#F3E2DB'
dayfox.insert.a.fg  = '#FFFFFF'
dayfox.visual.a.bg  = '#8C0150'
dayfox.visual.a.fg  = '#FFFFFF'
dayfox.visual.b.bg  = '#D199B9'
dayfox.command.a.fg = '#FFFFFF'

require('lualine').setup({
  options = {
    theme = dayfox,
    component_separators = {},
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_x = {},
    lualine_y = {'filetype', 'progress'},
    lualine_z = {'location'}
  },
})

--  
--  
--  
-- ┃
