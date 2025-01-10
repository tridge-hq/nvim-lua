vim.cmd([[colorscheme tokyonight-moon]])

---------------
-- nvim-tree --
require("nvim-tree").setup({
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  view = {
    width = 40,
  },
})

---------------
-- which-key --
local wk = require("which-key")
wk.setup({})

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
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    -- lua
    null_ls.builtins.formatting.stylua,

    -- js
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.diagnostics.eslint_d,

    -- python
    null_ls.builtins.diagnostics.ruff.with({ extra_args = { "--extend-select", "I" } }),
    null_ls.builtins.formatting.ruff.with({ extra_args = { "--extend-select", "I" } }),
    null_ls.builtins.formatting.ruff_format,

    -- sql
    null_ls.builtins.formatting.sqlfmt,
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
  },
})

-----------
-- scope --
require("scope").setup()

----------------
-- bufferline --
require("bufferline").setup()

--------------
-- gitsigns --
require("gitsigns").setup({})

------------------
-- comment --
require('Comment').setup({
  toggler = {
        ---Line-comment toggle keymap
        line = '<Leader>cc',
    },
  opleader = {
        ---Line-comment keymap
        line = '<Leader>cc',
    },
})

-----------
-- Mason --
require("mason").setup()

require("mason-null-ls").setup({
  automatic_installation = true,
})

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "go",
    "javascript",
    "lua",
    "markdown_inline",
    "python",
    "sql",
    "toml",
    "yaml",
  },
  indent = {
    enable = true,
  },
  highlight = {
    enable = false,
  },
})

---------------
-- text-case --
require("textcase").setup({})

--------------
-- sort.vim --
require("sort").setup({
  -- Input configuration here.
  -- Refer to the configuration section below for options.
})

-------------
-- tabnine --
require("tabnine").setup({
  disable_auto_comment = true,
  accept_keymap = "<Tab>",
  dismiss_keymap = "<C-]>",
  debounce_ms = 800,
  suggestion_color = { gui = "#808080", cterm = 244 },
  exclude_filetypes = { "NvimTree" },
  log_file_path = nil, -- absolute path to Tabnine log file
})

------------
-- ollama --
require("ollama").setup({
  -- All the user commands added by the plugin
  cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
  opts = {
    model = "llama2",
    url = "http://127.0.0.1:11434",
    serve = {
      on_start = false,
      command = "ollama",
      args = { "serve" },
      stop_command = "pkill",
      stop_args = { "-SIGTERM", "ollama" },
    },
  },
})
