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
wk.setup {}

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
-- vim.g.jsx_ext_required = 0
-- vim.g.vim_jsx_pretty_template_tags = { 'html', 'jsx', 'js' }
-- vim.g.vim_jsx_pretty_colorful_config = 1
-- vim.g.vim_jsx_pretty_highlight_close_tag = 1


-------------
-- null-ls --
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    -- lua
    null_ls.builtins.formatting.stylua,

    -- js
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.diagnostics.eslint_d,

    -- python
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.ruff.with({
      extra_args = { "--extend-select", "I", "--ignore", "E501" }
    }),
    null_ls.builtins.diagnostics.ruff.with({
      extra_args = { "--extend-select", "I", "--ignore", "E501" }
    }),

    -- sql
    null_ls.builtins.diagnostics.sqlfluff.with({
      extra_args = { "--dialect", "postgres" },
    }),
    null_ls.builtins.formatting.sqlfluff.with({
      extra_args = { "--dialect", "postgres", "-f", "-q", "--FIX-EVEN-UNPARSABLE" },
    }),
  },
  diagnostics_format = "[#{c}] #{m} (#{s})",
  debounce = 250,
})
-- Ref: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md


--------------
-- Startify --
vim.g.startify_session_persistence = 1


------------
-- lualine --
require("lualine").setup({
  options = {
    theme = "tokyonight",
  }
})

-----------
-- scope --
require('scope').setup()


----------------
-- bufferline --
require('bufferline').setup {
  options = {
    buffer_close_icon = '',
  }
}


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

require('mason-null-ls').setup({
  ensure_installed = {
    --python
    'ruff',

    --javascript
    'eslint_d',

    --lua
    'stylua',

    --sql
    'sqlfluff',
  },
  automatic_installation = true,
})

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'go',
    'javascript',
    'lua',
    'markdown_inline',
    'python',
    'sql',
    'toml',
    'yaml',
  },
  indent = {
    enable = true
  },
  highlight = {
    enable = false,
  }
}
