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
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['pyright'].setup {
  capabilities = capabilities,
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

require('lspconfig')['lua_ls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
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
  require('lspconfig')[value].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
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
  }
})
