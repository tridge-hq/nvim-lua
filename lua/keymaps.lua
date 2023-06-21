-- vim basics
vim.keymap.set({ 'i', 'x' }, '<C-c>', '<C-[>')
vim.keymap.set({ 'i', 'x' }, '<Left>', '<nop>')
vim.keymap.set({ 'i', 'x' }, '<Down>', '<nop>')
vim.keymap.set({ 'i', 'x' }, '<Up>', '<nop>')
vim.keymap.set({ 'i', 'x' }, '<Right>', '<nop>')

vim.keymap.set({ 'n', 'x' }, '<C-J>', '<C-W>j')
vim.keymap.set({ 'n', 'x' }, '<C-K>', '<C-W>k')
vim.keymap.set({ 'n', 'x' }, '<C-H>', '<C-W>h')
vim.keymap.set({ 'n', 'x' }, '<C-L>', '<C-W>l')

vim.keymap.set({ 'n', 'x' }, 'bn', ':bp<CR>')
vim.keymap.set({ 'n', 'x' }, 'bm', ':bn<CR>')
vim.keymap.set({ 'n', 'x' }, 'bd', ':bd<CR>')
vim.keymap.set({ 'n', 'x' }, 'td', ':tabclose<CR>')
vim.keymap.set({ 'n', 'x' }, 'tn', ':tabnew<CR>')
vim.keymap.set({ 'n', 'x' }, 'th', ':tabprev<CR>')
vim.keymap.set({ 'n', 'x' }, 'tj', ':tabfirst<CR>')
vim.keymap.set({ 'n', 'x' }, 'tk', ':tablast<CR>')
vim.keymap.set({ 'n', 'x' }, 'tl', ':tabnext<CR>')

vim.keymap.set({ 'n', 'x' }, 'H', '^')
vim.keymap.set({ 'n', 'x' }, 'L', 'g_')
vim.keymap.set({ 'n', 'x', 'v' }, '<Leader>y', '"*y')
vim.keymap.set('n', '<Leader>zz', ':%s/\\s\\+$//e<CR>')


--------------------------
-- nvim-tmux-navigation --
local nvim_tmux_nav = require('nvim-tmux-navigation')
nvim_tmux_nav.setup { disable_when_zoomed = true }
vim.keymap.set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight)


---------------
-- nvim-tree --
vim.keymap.set('n', '<Leader>nn', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<Leader>nt', ':NvimTreeFindFileToggle<CR>')


---------
-- fzf --
vim.keymap.set('n', '<Leader>f', ':FzfLua files<CR>')
vim.keymap.set('n', '<Leader>b', ':FzfLua buffers<CR>')
vim.keymap.set('n', '<Leader>bl', ':FzfLua bLines<CR>')
vim.keymap.set('n', '<Leader>l', ':FzfLua lines<CR>')
vim.keymap.set('n', '<Leader>gf', ':FzfLua git_files<CR>')
vim.keymap.set('n', '<Leader>gs', ':FzfLua git_status<CR>')
vim.keymap.set('n', '<Leader>gco', 'FzfLua git_commits<CR>')
vim.keymap.set('n', '<Leader>gbc', ':FzfLua git_bcommits<CR>')
vim.keymap.set('n', '<Leader>aa', ':FzfLua grep_project<CR>')

--------------
-- Fugitive --
vim.keymap.set('n', '<Leader>gc', ':G checkout ')
vim.keymap.set('n', '<Leader>gb', ':G branch ')
vim.keymap.set('n', '<Leader>gm', ':G merge ')
vim.keymap.set('n', '<Leader>gg', ':G blame<CR>')
vim.keymap.set('n', '<Leader>gs', ':G<CR>')
vim.keymap.set('n', '<Leader>gd', ':Gdiff<CR>')
vim.keymap.set('n', '<Leader>gl', ':G log<CR>')
vim.keymap.set('n', '<Leader>gf', ':G fetch origin<CR>')
vim.keymap.set('n', '<Leader>ggl', ':G pull origin ')
vim.keymap.set('n', '<Leader>gpp', ':G push origin ')
vim.keymap.set('n', '<silent> <Leader>gw', ':Gwrite<CR>')
vim.keymap.set('n', '<silent> <Leader>gr', ':Gread<CR>')


--------------
-- Undotree --
vim.keymap.set('n', '<Leader>u', ':UndotreeToggle<CR>:UndotreeFocus<CR>')


-------------
-- Tabular --
vim.keymap.set('n', '<Leader>t=', ':Tabularize /=<CR>')
vim.keymap.set('v', '<Leader>t=', ':Tabularize /=<CR>')
vim.keymap.set('n', '<Leader>t:', ':Tabularize /:<CR>')
vim.keymap.set('v', '<Leader>t:', ':Tabularize /:<CR>')
vim.keymap.set('n', '<Leader>t::', ':Tabularize /:\zs<CR>')
vim.keymap.set('v', '<Leader>t::', ':Tabularize /:\zs<CR>')
vim.keymap.set('n', '<Leader>t,', ':Tabularize /,<CR>')
vim.keymap.set('v', '<Leader>t,', ':Tabularize /,<CR>')
vim.keymap.set('n', '<Leader>t<Bar>', ':Tabularize /<Bar><CR>')
vim.keymap.set('v', '<Leader>t<Bar>', ':Tabularize /<Bar><CR>')

------------
-- tagbar --
vim.keymap.set('n', '<Leader>ta', ':TagbarToggle<CR>')


--------------
-- Startify --
vim.keymap.set('n', '<Leader>sl', ':SLoad')
vim.keymap.set('n', '<Leader>sc', ':SClose<CR>')
vim.keymap.set('n', '<Leader>ss', ':SSave')


--------------
-- gitsigns --
vim.keymap.set('n', '<Leader>p', ':Gitsigns preview_hunk_inline<CR>')
vim.keymap.set('n', '<Leader>m', ':Gitsigns toggle_current_line_blame<CR>')
vim.keymap.set('n', '<Leader>gd', ':Gitsigns diffthis<CR>')


------------
-- dadbod --
vim.keymap.set('n', '<Leader>db', ':DBUIToggle<CR>')

------------
--  lsp  ---
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
