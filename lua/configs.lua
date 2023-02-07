vim.cmd [[colorscheme tokyonight-moon]]

---------------
-- nvim-tree --
require('nvim-tree').setup({
  actions = {
    open_file = {
      quit_on_open = true,
    },
  }
})


---------------
-- which-key --
local wk = require('which-key')
wk.setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}
wk.register({
  u = { 'Undotree' },
}, { prefix = '<Leader>' })


--------------
-- Undotree --
vim.g.undotree_WindowLayout = 2
vim.g.undotree_SplitWidth = 40
vim.g.undotree_DiffpanelHeight = 20
vim.g.undotree_DiffAutoOpen = 1


---------------
-- Gitgutter --
vim.g.gitgutter_max_signs = 5000


------------
-- tagbar --
vim.g.tagbar_left = 1


--------------------
-- vim-jsx-pretty --
vim.g.jsx_ext_required = 0
vim.g.vim_jsx_pretty_template_tags = { 'html', 'jsx', 'js' }
vim.g.vim_jsx_pretty_colorful_config = 1
vim.g.vim_jsx_pretty_highlight_close_tag = 1


-------------
-- null-ls --
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    -- lua
    null_ls.builtins.formatting.stylua,
    -- js
    null_ls.builtins.formatting.eslint_d,
    -- python
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
  },
})
-- Ref: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md


--------------
-- Startify --
vim.g.startify_session_persistence = 1


------------
-- feline --
require('feline').setup()
require('feline').winbar.setup()


-----------
-- scope --
require('scope').setup()


----------------
-- bufferline --
vim.opt.termguicolors = true
require('bufferline').setup {}


--------------
-- gitsigns --
require('gitsigns').setup {}


------------------
-- nvim-comment --
require('nvim_comment').setup({
  comment_empty = false,
  comment_empty_trim_whitespace = false,
  line_mapping = '<Leader>cl',
  operator_mapping = '<Leader>cc',
})


-----------
-- Mason --
require('mason').setup()
