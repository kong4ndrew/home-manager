-- LuaSnip Config --

local ls     = require('luasnip')
local s      = ls.snippet
local t      = ls.text_node
local i      = ls.insert_node
local extras = require('luasnip.extras')
local rep    = extras.rep
local fmt    = require('luasnip.extras.fmt').fmt

require('luasnip.loaders.from_vscode').lazy_load()

ls.setup({
    keep_roots          = true,
    link_roots          = true,
    link_children       = true,
    update_events       = 'TextChanged, TextChangedI',
    enable_autosnippets = true,
})

-- <C-k> is the expansion key; this will expand the current item or
-- jump to the next item within the snippet
vim.keymap.set({'i', 's'}, '<C-k>', function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

-- <C-j> is the jump backwards key; this always moves to the previous
-- item within the snippet
vim.keymap.set({'i', 's'}, '<C-j>', function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

-- <C-l> is to select within a list of options; this is useful for
-- choice nodes.
vim.keymap.set({'i', 's'}, '<C-l>', function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

-- This is basically a pointless keymap if you use nix...
vim.keymap.set('n', '<leader><leader>s', '<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>')

--===-===-===-===-===-===-===-===-===- SNIPPETS ===-===-===-===-===-===-===-===-===-

-- mk triggers $math-mode$
ls.add_snippets('tex', {
    s('mk', {
        t('$'),
        i(1),
        t('$'),
    })
})

-- dk triggers \[display-mode\]
ls.add_snippets('tex', {
    s('dk', fmt([[
    \[
    {}
    \]
    ]], {
        i(1),
    }))
})
--
-- tk triggers \text{}
ls.add_snippets('tex', {
    s('tk', {
        t('\\text{ '),
        i(1),
        t(' }'),
    })
})

ls.add_snippets('tex', {
    s('tbk', {
        t('\\textbf{ '),
        i(1),
        t(' }'),
    })
})

-- bk prepares \begin{environment} ... \end{environment}
-- When using fmt, you must escape curly braces with an extra curly brace {} -> {{}}
ls.add_snippets('tex', {
    s('bk', fmt(
    [[
    \begin{{{}}}
        {}
    \end{{{}}}
    ]], {
        i(1), i(0), rep(1)
    }))
})

-- fk triggers \frac{}{}
ls.add_snippets('tex', {
    s('fk', fmt(
    [[
    \frac{{{}}}{{{}}}
    ]], {
        i(1), i(2),
    }))
})

-- pfk triggers \left(\frac{}{}\right)
ls.add_snippets('tex', {
    s('pfk', fmt(
    [[
    \left(\frac{{{}}}{{{}}}\right)
    ]], {
        i(1), i(2),
    }))
})

-- bfk triggers \left[\frac{}{}\right]
ls.add_snippets('tex', {
    s('bfk', fmt(
    [[
    \left[\frac{{{}}}{{{}}}\right]
    ]], {
        i(1), i(2),
    }))
})

-- ex triggers EXAMPLE
ls.add_snippets('tex', {
    s('ex', fmt(
    [[
    \helvet{{\textcolor{{NavyBlue}}{{\textbf{{EXAMPLE {}}}}}}} \normalfont \hspace{{0.8cm}}
    ]], {
        i(1),
    }))
})

-- sol triggers SOLUTION
-- When using text nodes, escape backslashes with an extra one. Ex \ -> \\
-- Escaping curly braces aren't necessary in text nodes.
ls.add_snippets('tex', {
    s('sol', {
        t('\\helvet{\\textcolor{NavyBlue}{SOLUTION}} \\normalfont \\hspace{1cm}')
    })
})

ls.add_snippets('tex', {
    s('tsk', fmt(
    [[
    \begin{{tasks}}[label=({}), label-width={}cm]({})
        \task {}
    \end{{tasks}}
    ]], {
        i(1, '\\alph*'),
        i(2, '0.5'),
        i(3, '2'),
        i(4),
    }))
})
