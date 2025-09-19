-- Enable module caching for faster loading (Neovim 0.9+)
if vim.loader then
	vim.loader.enable()
end

require("core")

-- Auto-create backup/swap/undo directories
local function ensure_dirs()
	local dirs = {
		vim.fn.expand("~/.tmp/vim/backup"),
		vim.fn.expand("~/.tmp/vim/swap"),
		vim.fn.expand("~/.tmp/vim/undo"),
	}
	for _, dir in ipairs(dirs) do
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end
end
ensure_dirs()
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("plugins", { concurrency = 50 })
-- Configs are now loaded by individual plugins in plugins_optimized_v2
-- require("configs")  -- Commented out - loaded lazily per plugin
-- require("lsp")      -- Loaded by nvim-lspconfig event
require("keymaps") -- Keep keymaps active
