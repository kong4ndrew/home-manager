-- Nightfox Config

--[[ How To Customize Highlighting Using Treesitter And Nightfox:

1. Capture treesitter patterns in after/queries/somefiletype/highlights.scm. For example,

   (identifier) @custom_capture or @variable.builtin

2. Link the capture_id to a nightfox group or your own custom group. For example,

   vim.api.nvim_set_hl(0, 'myCustomCapture.swift', {})
   vim.api.nvim_set_hl(0, 'myCustomCapture.swift', { link = 'MyCustomGroup' })

  Note: You can also link standard highlight-groups but put it into an autocommand
  because colors.lua seems to get sourced earlier...For example,

  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      vim.api.nvim_set_hl(0, 'Comment', { link = 'MyCustomGroup' })
    end
  }) 

3. Set dayfox's (or whatever theme's) syntax. You can create custom syntax and palette fields.
   For example,

  palettes = {
    dayfox = {
      ...
      magenta = '#FFFFFF'
      myCustomPalette = shade.new('#FFFFFF', '#FFFFFF', '#FFFFFF', false)
      ...
    }
  }
  dayfox = {
    syntax = {
      ...
      string = 'magenta'
      myCustomSyntaxValue = 'myCustomPalette.dim'
      ...
    }
  }

4. Build the highlight-group using a theme's syntax value, palette. Note that highlight groups are
   NOT differentiated by theme hence all = {...}. Also note that the styles option is NOT a
   template source. So you can't do style = 'dayfox.comment' or style = 'comment'. For example,

   groups = {
     all = {
       MyCustomGroup = { fg = syntax.myCustomSyntaxValue, style = 'italic',  bg = ..., sp = ..., link = ...}
     }
   }

-- Create a new vim group-name (:h group-name):
vim.api.nvim_set_hl(0, 'Asdf', {})

-- For some reason, setting standard highlight-groups like 'Comment'
-- is getting sourced earlier than treesitter captures like '@comment.swift',
-- so you have to set it in a autocommand:
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.api.nvim_set_hl(0, 'Keyword', { link = 'Asdf' })
  end
})

--]]

local shade = require('nightfox.lib.shade')
local palettes = {
  dayfox = {
    white   = '#FFFFFF',                                          -- NOTE: Shades are (base, bright, dim, light)
    black   = '#000000',                                          -- Brackets and Punctuation Delimiters
    red     = '#CD2E1A',                                          -- Strings
    pink    = shade.new('#AD3DA4', '#3900A0', '#6C36A9', false),  -- (keywords, VariableBuiltIn, Constructor, constants, conditionals, Boolean), ,
    cyan    = shade.new('#057CB0', '#0B4F79', '#0F68A0', false),  -- (VariableMember, FunctionMember), ,
    magenta = shade.new('#4B22B0', '#804FB8', '#AA0D91', false),  -- (Special ex. @State, type), (functions, Parameter), 
    green   = shade.new('#3E8087', '#1C464A', '#1C464A', false),  -- (Identifier, variable), ,
    blue    = shade.new('#1C00CF', '#03628C', '#0E0EFF', false),  -- (Numbers), (TypeProject)
    yellow  = shade.new('#815F03', '#643820', '#815F03', false),  -- (Attributes, Other Preprocessor),
    orange  = '#643820',                                          -- Unused
    comment = '#5D6C79',                                          -- Comments (Note: comment cannot be a shade)
    bg0     = '#FDF8F7', -- Status line + float
    bg1     = '#FFFFFF', -- The bg of the unfocused buffers when you telescope prompt, etc.
    bg2     = '#FAC9B8', -- ColorColumn
    bg3     = '#E8F2FF', -- CursorLine
    bg4     = '#007AFF', -- The borders of popups
    fg0     = '#FFA500', -- ? Orange color. usage.md says "Lighter fg"???
    fg1     = '#000000', -- The git branch, filetype in lualine + text in cmp
    fg2     = '#000000', -- The filename, encoding, fileformat in lualine + brackets
    fg3     = '#007AFF', -- LineNr
    sel0    = '#B3D7FF', -- ex commands bg + selection bg in cmp + visual mode selection bg (overriden in groups)
    sel1    = '#C9E3FF', -- The selection bg in ex command popups
  },
}
vim.api.nvim_set_hl(0, '@variable.identifier.swift', { link = 'Identifier' })
vim.api.nvim_set_hl(0, '@keyword.function.swift', { link = 'Keyword' })
vim.api.nvim_set_hl(0, '@boolean.swift', { link = 'Boolean' })

-- Still keep empty hl groups cus if you switch from dayfox to any other nightfox theme, groups (below)
-- get activated. Setting foreground using `fg = palettes.dayfox...` is specific to DAYFOX.
vim.api.nvim_set_hl(0, 'VariableMember', {})
vim.api.nvim_set_hl(0, '@variable.member.swift', { fg = palettes.dayfox.cyan.base })
vim.api.nvim_set_hl(0, '@variable.swift', { fg = palettes.dayfox.cyan.base })

vim.api.nvim_set_hl(0, 'VariableBuiltIn', {})
vim.api.nvim_set_hl(0, '@variable.builtin.swift', { fg = palettes.dayfox.pink.base, bold = true })

vim.api.nvim_set_hl(0, 'FunctionMember', {})
vim.api.nvim_set_hl(0, '@function.member.swift', { fg = palettes.dayfox.cyan.base })

vim.api.nvim_set_hl(0, 'Constructor', {})
vim.api.nvim_set_hl(0, '@constructor.swift', { fg = palettes.dayfox.pink.base, bold = true })

vim.api.nvim_set_hl(0, 'TypeProject', {})
vim.api.nvim_set_hl(0, '@type.project', { fg = palettes.dayfox.blue.bright })

vim.api.nvim_set_hl(0, 'Parameter', {})
vim.api.nvim_set_hl(0, '@parameter.swift', { fg = palettes.dayfox.magenta.bright })
vim.api.nvim_set_hl(0, '@variable.parameter.swift', { fg = palettes.dayfox.magenta.bright })

local groups = {
  all = {
    VariableBuiltIn = { fg = 'palette.pink', style = 'bold' },
    VariableMember  = { fg = 'palette.cyan' },
    FunctionMember  = { fg = 'palette.cyan' },
    Constructor     = { fg = 'palette.pink', style = 'bold' },
    Special         = { fg = 'palette.magenta' },
    Boolean         = { fg = 'palette.pink', style = 'bold' },
    Parameter       = { fg = 'palette.magenta.bright' },
    TypeProject     = { fg = 'palette.blue.bright' },
    Visual          = { bg = 'palette.sel1' },
    CursorLineNr    = { fg = '#8C0150' },
    ColorColumn     = { link = 'StatusLine' },
  },
}

local specs = {
  dayfox = {
    syntax = {
      bracket     = 'black',
      builtin0    = 'pink',
      builtin1    = 'pink.bright',
      builtin2    = 'pink.dim',
      comment     = 'comment',
      conditional = 'pink',
      const       = 'pink',
      dep         = 'comment',
      field       = 'magenta.bright',
      func        = 'magenta.bright',
      ident       = 'green',
      keyword     = 'pink',
      number      = 'blue',
      operator    = 'black',
      preproc     = 'yellow.bright',
      regex       = 'red',
      statement   = 'black', -- ?
      string      = 'red',
      type        = 'magenta',
      variable    = 'cyan',
    },
  },
}

local options = {
  styles = {
    comments     = 'bold,italic',
    conditionals = 'bold',
    keywords     = 'bold',
  },
}

require('nightfox').setup({
  options  = options,
  palettes = palettes,
  specs    = specs,
  groups   = groups,
  modules  = {
    cmp               = true,
    indent_blanklines = true,
    telescope         = true,
  }
})

function Colorme(color)
  color = color or 'dayfox'
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

  -- Note: If you want to change cursor color or the text color under cursor,
  -- do it in kitty home.nix!
end

-- Make sure the function callsite comes AFTER the colorscheme setup, NOT before:
Colorme()

--require('nightfox').setup({
--    options = {
--        styles = {
--            comments     = 'bold,italic',
--            keywords     = 'bold',
--            conditionals = 'bold',
--            types        = 'bold',
--            functions    = 'italic',
--        },
--    },
--    palettes = {
--        dayfox = {
--            black   = '#000000',
--            red     = '#9A3324',
--            green   = '#067E00',
--            yellow  = '#C48200',
--            blue    = '#046F9E',--'#036894', --'#052CA3',
--            magenta = '#8C0150',
--            cyan    = '#145C1A',
--            white   = '#FFFFFF',
--            orange  = '#C93912',
--            pink    = '#732C96', -- Purple
--        },
--    },
--    specs = {
--        dayfox = {
--            syntax = {
--                bracket  = 'black',
--                func     = 'cyan',
--                operator = 'black',
--                variable = 'pink',
--                string   = 'orange',
--                asdf     = 'green',
--            },
--            -- diag = {},
--        },
--    },
--    groups = groups,
--})
