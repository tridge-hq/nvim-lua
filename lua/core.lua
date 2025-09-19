-- vim core

vim.g.mapleader = ","

-- vim sql_omni_key
-- https://neovim.io/doc/user/ft_sql.html
vim.g.ftplugin_sql_omni_key = "<C-;>"
-- vim.o.syntax = 'enable'
vim.o.autoindent = true
vim.o.backspace = "indent,eol,start"
vim.o.backupdir = os.getenv("HOME") .. "/.tmp/vim/backup/"
vim.o.directory = os.getenv("HOME") .. "/.tmp/vim/swap/"
vim.o.undodir = os.getenv("HOME") .. "/.tmp/vim/undo/"
vim.o.colorcolumn = "89"
vim.o.copyindent = true
vim.o.encoding = "utf8"
vim.o.expandtab = true
vim.o.formatoptions = "cqnr1"
vim.o.gdefault = true
vim.o.hidden = true
vim.o.history = 1000
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.laststatus = 2
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.shiftwidth = 2
vim.o.showcmd = true
vim.o.showmatch = true
vim.o.smartcase = true
vim.o.smarttab = true
vim.o.softtabstop = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabstop = 2
vim.o.textwidth = 88
vim.o.title = true
vim.o.undofile = true
vim.o.undolevels = 1000
vim.o.visualbell = true
vim.o.wildignore = "*.o,*.out,*.obj,*.so,*.pyc,*.swp,*.zip,*~,._*,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz"
vim.o.wildmenu = true
vim.o.wildmode = "list:longest"
vim.o.wrap = true
vim.o.mouse = "a"
vim.o.updatetime = 100
vim.o.timeoutlen = 400
vim.o.termguicolors = true
vim.g.indent_guides_enable_on_vim_startup = 1
vim.g.loaded_python3_provider = 0


local function set_local_per_filetype()
  local filetype = vim.bo.filetype
  if filetype == "python" then
    vim.cmd([[set ts=4 sw=4 sts=4 expandtab]])
  else
    vim.cmd([[set ts=2 sw=2 sts=2 expandtab]])
  end
end

vim.api.nvim_create_autocmd("BufEnter", {
  callback = set_local_per_filetype,
})

---------------
-- dadbob-ui --
vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_database_icon = 1
