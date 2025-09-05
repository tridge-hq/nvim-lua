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
	-- Format keymap moved to keymaps.lua using conform.nvim (<Space>f)
end

-- 3. Setup capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
	-- Use default_capabilities without passing an argument
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

