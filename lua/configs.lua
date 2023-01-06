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
  wk.register ({
  u = { 'Undotree' },
}, { prefix = '<Leader>' })


---------------
-- lspconfig --
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['pyright'].setup{
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        diagnosticMode = 'openFilesOnly',
        useLibraryCodeForTypes = false,
      },
    },
  },
}

--------------
-- nvim-cmp --
local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn['UltiSnips#Anon'](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


--------------
-- Undotree --
vim.g.undotree_WindowLayout = 2
vim.g.undotree_SplitWidth = 40
vim.g.undotree_DiffpanelHeight = 20
vim.g.undotree_DiffAutoOpen = 1


---------------
-- Gitgutter --
vim.g.gitgutter_max_signs=5000


------------
-- tagbar --
vim.g.tagbar_left = 1


--------------------
-- vim-jsx-pretty --
vim.g.jsx_ext_required = 0
vim.g.vim_jsx_pretty_template_tags = {'html', 'jsx', 'js'}
vim.g.vim_jsx_pretty_colorful_config = 1
vim.g.vim_jsx_pretty_highlight_close_tag = 1


---------
-- Ale --
vim.b.ale_linters = {javascript = {'eslint'}, python = {'flake8'}}
vim.g.ale_fixers = {python = {'isort'}}


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
require('bufferline').setup{}


--------------
-- gitsigns --
require('gitsigns').setup{}


------------------
-- nvim-comment --
require('nvim_comment').setup({
    comment_empty = false,
    comment_empty_trim_whitespace = false,
    line_mapping = '<Leader>cl',
    operator_mapping = '<Leader>cc',
})
