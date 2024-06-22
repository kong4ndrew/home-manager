-- Lualine Config -- 

local dayfox = require('lualine.themes.dayfox')
dayfox.normal.a.bg = '#DF8666'--'#C48200'
dayfox.normal.b.bg = '#F3E2DB'--'#EDD9B2'
dayfox.visual.a.bg = '#8C0150'
dayfox.visual.b.bg = '#D199B9'

require('lualine').setup({
    options = {
        theme = dayfox,
        component_separators = {},
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_x = {'encoding', 'fileformat'},
        lualine_y = {'filetype', 'progress'},
    },
})

--  
--  
--  
-- ┃
