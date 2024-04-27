-- Keymaps --

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>e', vim.cmd.Ex)                  -- <leader>e  executes the :Ex command
vim.keymap.set('n', '<leader>re', vim.cmd.Rex)                -- <leader>re executes the :Re command

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")                  -- When in visual mode, 'J' will move the selected chunk down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")                  -- When in visual mode, 'K' will move the selected chunk up

vim.keymap.set('n', 'J'    , 'mzJ`z')                         -- Joining lines will keep cursor where it originally was. (mark 'z' + 'J' + return back to mark 'z')
vim.keymap.set('v', 'y'    , 'mzy`z')                         -- After highlighting in visual mode, yanking will keep cursor at the bottom-most line
vim.keymap.set('n', '<C-d>', '<C-d>M')                        -- <C-d> will keep the cursor in the middle of the screen (<C-d> + 'M')
vim.keymap.set('n', '<C-u>', '<C-u>M')                        -- <C-u> will keep the cursor in the middle of the screen (<C-u> + 'M')
vim.keymap.set('n', '<C-f>', '<C-f>M')                        -- <C-f> will keep the cursor in the middle of the screen (<C-f> + 'M')
vim.keymap.set('n', '<C-b>', '<C-b>M')                        -- <C-b> will keep the cursor in the middle of the screen (<C-b> + 'M')
vim.keymap.set('n', '<C-m>', '<C-e>M')                        -- <C-m> will also keep the cursor in the middle of the screen ('<C-e>' + 'M')
vim.keymap.set('n', '<C-y>', '<C-y>M')                        -- <C-y> will also keep the cursor in the middle of the screen ('<C-y>' + 'M')
vim.keymap.set('n', 'n'    , 'nzzzv')                         -- When searching, keeps cursor in the middle of the screen
vim.keymap.set('n', 'N'    , 'Nzzzv')                         -- When searching, keeps cursor in the middle of the screen

vim.keymap.set('x', '<leader>p', '\"_dP')                     -- When pasting over something, don't replace vim clipboard with whatever was just replaced

vim.keymap.set('n', '<leader>y', '\"+y')                      -- <leader>(yanks) will copy to system clipboard
vim.keymap.set('v', '<leader>y', '\"+y')
vim.keymap.set('n', '<leader>Y', '\"+Y')

vim.keymap.set('n', '<leader>d', '\"_d')                      -- <leader>(deletes) will not copy to vim clipboard
vim.keymap.set('v', '<leader>d', '\"_d')
vim.keymap.set('n', '<leader>D', '\"_D')
vim.keymap.set('n', '<leader>c', '\"_c')                      -- <leader>(changes) will not copy to vim clipboard
vim.keymap.set('n', '<leader>C', '\"_C')

vim.keymap.set('n', 'Q', '<nop>')

vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')              -- Quick fix naviation-related
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- Incrementally changes every instance of the word your cursor is on
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })              -- Sets executable permission on the current file

vim.keymap.set('n', '`.'   , '`.zz')                          -- Jumping to last change will position the cursor in the middle of the screen
vim.keymap.set('n', "'."   , "'.zz")
vim.keymap.set('n', '<C-o>', '<C-o>zz')                       -- Jumping to previous/next jumps will position the cursor in the middle of the screen
vim.keymap.set('n', '<C-i>', '<C-i>zz')

vim.keymap.set('n', '<leader>t', vim.cmd.tabnew)              -- <leader>t creates new tab
vim.keymap.set('n', '<C-S-j>'  , 'gT')                        -- <C-S-j> goes to previous tab
vim.keymap.set('n', '<C-S-k>'  , 'gt')                        -- <C-S-k> goes to next tab
