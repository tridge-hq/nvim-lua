-- Ultra-optimized plugin configuration with aggressive lazy loading
return {
	-- Essential (load immediately)
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight-moon]])
		end,
	},

	-- Core utilities (load early but lazy)
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- UI Components (load after startup)
	{
		"nvim-lualine/lualine.nvim",
		event = "vimEnter",
		config = function()
			require("lualine").setup({
				options = { theme = "tokyonight" },
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		event = "BufAdd",
		config = function()
			require("bufferline").setup()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		config = function()
			require("ibl").setup({
				enabled = true, -- Enable by default
				scope = {
					enabled = true,
					show_start = true,
					show_end = false,
				},
			})
		end,
	},

	-- File Navigation (on demand)
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				actions = {
					open_file = { quit_on_open = true },
				},
				view = { width = 40 },
			})
		end,
	},
	{
		"junegunn/fzf",
		build = "./install --bin",
		cmd = "FZF",
	},
	{
		"junegunn/fzf.vim",
		cmd = { "Files", "Buffers", "Ag", "Lines", "BLines", "GFiles", "Commits", "BCommits" },
		dependencies = { "junegunn/fzf" },
	},

	-- Editor Enhancement (on specific triggers)
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup({
				plugins = {
					marks = true,
					registers = true,
					spelling = { enabled = true, suggestions = 20 },
				},
				window = {
					border = "rounded",
					position = "bottom",
				},
			})
		end,
	},
	{
		"terrortylor/nvim-comment",
		keys = { "<leader>c", "<leader>cc" },
		config = function()
			require("nvim_comment").setup({
				line_mapping = "<leader>cc",
				operator_mapping = "<leader>c",
			})
		end,
	},
	{
		"tpope/vim-surround",
		keys = { "cs", "ds", "ys" },
	},
	{
		"godlygeek/tabular",
		cmd = "Tabularize",
	},
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
	},

	-- Git (on git files)
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({})
		end,
	},
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gdiff", "Gblame", "Glog", "Gread", "Gwrite" },
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		config = function()
			require("diffview").setup({
				use_icons = true,
				file_panel = {
					listing_style = "tree",
					win_config = { position = "left", width = 35 },
				},
			})
		end,
	},

	-- LSP & Completion (on code files)
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			{ "hrsh7th/cmp-nvim-lsp", lazy = false }, -- Ensure this loads immediately
		},
		config = function()
			require("lsp")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "python", "javascript", "go" },
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		cmd = { "ConformInfo", "Format" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "ruff_format", "ruff_fix" },
					javascript = { "prettier", "eslint_d" },
					typescript = { "prettier", "eslint_d" },
					javascriptreact = { "prettier", "eslint_d" },
					typescriptreact = { "prettier", "eslint_d" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					scss = { "prettier" },
					go = { "gofmt", "goimports" },
					rust = { "rustfmt" },
					sql = { "sqlfmt" },
				},
				-- Disabled auto-format on save (use :Format or <Leader>cf manually)
				format_on_save = {
					timeout_ms = 1000,
					lsp_fallback = true,
				},
			})

			-- Create Format command
			vim.api.nvim_create_user_command("Format", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				require("conform").format({ async = true, lsp_fallback = true, range = range })
			end, { range = true })
		end,
	},

	-- Completion (on insert)
	{
		"hrsh7th/nvim-cmp",
		lazy = false, -- Load immediately to ensure it's available for LSP
		priority = 1000, -- Load with high priority
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp", lazy = false },
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
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
				}, {
					{ name = "buffer", keyword_length = 3 },
					{ name = "path" },
				}),
			})

			-- Setup for / and ? search
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Setup for : command mode
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		dependencies = { "honza/vim-snippets" },
	},

	-- Search & Replace (on demand)
	{
		"nvim-pack/nvim-spectre",
		cmd = "Spectre",
		keys = { "<leader>ro", "<leader>rw", "<leader>rf" },
		config = function()
			require("spectre").setup()
		end,
	},

	-- AI/Completion (on demand)
	{
		"github/copilot.vim",
		event = "InsertEnter",
		config = function()
			vim.g.copilot_proxy = "http://localhost:11435"
			vim.g.copilot_proxy_strict_ssl = "v:false"
		end,
	},
	{
		"nomnivore/ollama.nvim",
		cmd = { "Ollama", "OllamaModel" },
		keys = { "<leader>oo", "<leader>og" },
		config = function()
			require("ollama").setup({
				model = "llama2",
				url = "http://127.0.0.1:11434",
			})
		end,
	},

	-- Utilities (very lazy)
	{
		"tiagovla/scope.nvim",
		event = "VeryLazy",
		config = function()
			require("scope").setup()
		end,
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			local notify = require("notify")
			notify.setup({
				background_colour = "#000000",
				timeout = 3000,
			})
			vim.notify = notify
		end,
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	-- Rarely used
	{ "tpope/vim-repeat", keys = { "." } },
	{ "tpope/vim-sensible", lazy = false },
	{ "Raimondi/delimitMate", event = "InsertEnter" },
	{ "michaeljsmith/vim-indent-object", keys = { "vii", "vai" } },
	{ "nathanaelkane/vim-indent-guides", event = "BufReadPost" },
	{ "justinmk/vim-sneak", keys = { "s", "S" } },
	{ "majutsushi/tagbar", cmd = "TagbarToggle" },
	{ "johmsalas/text-case.nvim", event = "VeryLazy" },
	{ "sQVe/sort.nvim", cmd = "Sort" },
	{ "mg979/vim-visual-multi", keys = { "<C-n>" } },
	{ "honza/vim-snippets", event = "InsertEnter" },
	{ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
	{ "alexghergh/nvim-tmux-navigation", keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" } },
	{ "rstacruz/sparkup", ft = { "html", "xml" } },
	{ "tpope/vim-dadbod", cmd = { "DB", "DBUI", "DBUIToggle" } },
	{
		"kristijanhusak/vim-dadbod-ui",
		cmd = "DBUIToggle",
		dependencies = { "tpope/vim-dadbod" },
	},
	{
		"kristijanhusak/vim-dadbod-completion",
		ft = { "sql", "mysql", "plsql" },
		dependencies = { "tpope/vim-dadbod", "hrsh7th/nvim-cmp" },
		config = function()
			-- Set up dadbod completion only for SQL files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					local cmp = require("cmp")
					cmp.setup.buffer({
						sources = cmp.config.sources({
							{ name = "vim_dadbod_completion" },
							{ name = "buffer" },
						}),
					})
				end,
			})
		end,
	},
	{ "mitsuhiko/vim-jinja", ft = { "jinja", "jinja2" } },
	{
		"greggh/claude-code.nvim",
		cmd = "ClaudeCode",
		keys = { "<C-,>", "<leader>ac", "<leader>cC" },
		config = function()
			require("claude-code").setup({
				window = {
					split_ratio = 0.85,
					position = "botright",
					enter_insert = true,
					hide_numbers = true,
					hide_signcolumn = true,
					float = {
						width = "80%",
						height = "80%",
						row = "center",
						col = "center",
						relative = "editor",
						border = "rounded",
					},
				},
				refresh = {
					enable = true,
					updatetime = 100,
					timer_interval = 1000,
					show_notifications = true,
				},
				git = {
					use_git_root = true,
				},
				shell = {
					separator = "&&",
					pushd_cmd = "pushd",
					popd_cmd = "popd",
				},
				command = "claude",
				command_variants = {
					continue = "--continue",
					resume = "--resume",
					verbose = "--verbose",
				},
				keymaps = {
					toggle = {
						normal = "<C-,>",
						terminal = "<C-,>",
						variants = {
							continue = "<leader>cC",
							verbose = "<leader>ac",
						},
					},
					window_navigation = true,
					scrolling = true,
				},
			})
		end,
	},
}
