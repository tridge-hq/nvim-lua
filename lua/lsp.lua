-- Minimal LSP configuration to bypass mason-lspconfig issues

-- 1. Setup mason 
local mason_ok = pcall(require, "mason")
if mason_ok then
  require("mason").setup()
end

-- 2. Define on_attach
local on_attach = function(client, bufnr)
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gK", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end

-- 3. Setup capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
  capabilities = cmp_nvim_lsp.default_capabilities()
end

-- 4. Skip mason-lspconfig entirely and setup servers directly
local lspconfig = require("lspconfig")

-- Pyright
local pyright_ok = pcall(function()
  lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          diagnosticMode = "openFilesOnly",
          typeCheckingMode = "off",
        },
      },
    },
  })
end)

-- Lua LS
local lua_ls_ok = pcall(function()
  lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })
end)

-- Other servers
local servers = { "gopls", "taplo", "yamlls", "ruff", "eslint", "ts_ls" }
for _, server in ipairs(servers) do
  pcall(function()
    lspconfig[server].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end)
end

-- 5. Global mappings (moved to keymaps.lua to avoid duplication)

-- 6. Setup nvim-cmp
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip" },
    { name = "vim-dadbod-completion" },
  }, {
    { name = "buffer", keyword_length = 3 },
    { name = "path" },
  }),
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

-- LSP configuration loaded (mason-lspconfig bypassed)
-- Use :Mason to manually install LSP servers