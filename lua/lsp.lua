-- lsp
require('mason-lspconfig').setup {
  ensure_installed = {
    'gopls',
    'lua_ls',
    'pyright',
    'taplo',
    'tsserver',
    'yamlls',
  },
  automatic_installation = true,
}
---------------
-- lspconfig --
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

require('lspconfig')['pyright'].setup {
  settings = {
    python = {
      analysis = {
        diagnosticMode = 'openFilesOnly',
        useLibraryCodeForTypes = false,
      },
    },
  },
}

require('lspconfig')['lua_ls'].setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          'vim',
        },
      },
    },
  }
}

-- Ref: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
for _, value in ipairs({
  'gopls',
  'taplo',
  'tsserver',
  'yamlls',
}) do
  require('lspconfig')[value].setup {}
end


--------------
-- nvim-cmp --
local cmp = require 'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'vim-dadbod-completion' },
  }, {
    { name = 'buffer' },
  })
})

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

require('lspsaga').setup({
  lightbulb = {
    enable = false,
  },
  symbol_in_winbar = {
    enable = false,
  }
})
