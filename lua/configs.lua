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
wk.setup({
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enabled = true,
			suggestions = 20,
		},
	},
	win = {
		border = "rounded",
		position = "bottom",
		margin = { 1, 0, 1, 0 },
		padding = { 2, 2, 2, 2 },
	},
	layout = {
		height = { min = 4, max = 25 },
		width = { min = 20, max = 50 },
		spacing = 3,
		align = "left",
	},
})

-- Register key groups
wk.register({
	["<leader>"] = {
		["<space>"] = { name = "+lsp" },
		b = { name = "+buffer" },
		c = { name = "+code/format" },
		d = { name = "+debug/dap" },
		f = { name = "+find/fzf" },
		g = { name = "+git" },
		n = { name = "+nvim-tree" },
		o = { name = "+ollama" },
		q = { name = "+quit/notify" },
		r = { name = "+replace/spectre" },
		s = { name = "+session/sort" },
		t = { name = "+tabs/tabular" },
		v = { name = "+view/diffview" },
	},
})

--------------
-- Undotree --
vim.g.undotree_WindowLayout = 2
vim.g.undotree_SplitWidth = 40
vim.g.undotree_DiffpanelHeight = 20
vim.g.undotree_DiffAutoOpen = 1

------------
-- tagbar --
vim.g.tagbar_left = 1

--------------
-- Startify (disabled)
-- vim.g.startify_session_persistence = 1

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

---------------
-- Diffview --
local ok_diffview, diffview = pcall(require, "diffview")
if ok_diffview then
	diffview.setup({
		diff_binaries = false,
		enhanced_diff_hl = false,
		git_cmd = { "git" },
		use_icons = true,
		file_panel = {
			listing_style = "tree",
			tree_options = {
				flatten_dirs = true,
				folder_statuses = "only_folded",
			},
			win_config = {
				position = "left",
				width = 35,
			},
		},
		file_history_panel = {
			log_options = {
				git = {
					single_file = {
						diff_merges = "combined",
					},
					multi_file = {
						diff_merges = "first-parent",
					},
				},
			},
			win_config = {
				position = "bottom",
				height = 16,
			},
		},
		key_bindings = {
			disable_defaults = false,
			view = {
				["<tab>"] = false,
				["<s-tab>"] = false,
				["gf"] = false,
				["<C-w><C-f>"] = false,
				["<C-w>gf"] = false,
				["<leader>e"] = false,
				["<leader>b"] = false,
			},
		},
	})
end

--------------
-- Spectre --
local ok_spectre, spectre = pcall(require, "spectre")
if ok_spectre then
	spectre.setup({
		color_devicons = true,
		open_cmd = "vnew",
		live_update = false,
		line_sep_start = "┌─────────────────────────────────────────",
		result_padding = "¦  ",
		line_sep = "└─────────────────────────────────────────",
		highlight = {
			ui = "String",
			search = "DiffChange",
			replace = "DiffDelete",
		},
	})
end

---------------
-- nvim-notify --
local ok_notify, notify = pcall(require, "notify")
if ok_notify then
	notify.setup({
		background_colour = "#000000",
		fps = 30,
		icons = {
			DEBUG = "",
			ERROR = "",
			INFO = "",
			TRACE = "✎",
			WARN = "",
		},
		level = 2,
		minimum_width = 50,
		render = "default",
		stages = "fade_in_slide_out",
		timeout = 3000,
		top_down = true,
	})
	vim.notify = notify
end

------------------
-- comment --
require("nvim_comment").setup({
	line_mapping = "<leader>cc",
	operator_mapping = "<leader>c",
	comment_chunk_text_object = "ic",
})

-- Mason is now setup in lsp.lua to ensure proper initialization order

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
		enable = true,
	},
})

--------------
-- text-case --
require("textcase").setup({})

--------------
-- sort.vim --
require("sort").setup({
	-- Input configuration here.
	-- Refer to the configuration section below for options.
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

-------------
-- copilot --

vim.g.copilot_proxy = "http://localhost:11435"
vim.g.copilot_proxy_strict_ssl = "v:false"
