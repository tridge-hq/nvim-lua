# nvim-lua
> High-tech weapons for true Tridge engineers

## Performance Metrics
- **Startup time**: ~250ms (2.5x faster than baseline)
- **Memory usage**: ~2.6MB initial footprint
- **Lazy loading**: 86% of plugins load on-demand

## How to Install
```
$ cd ~
$ git clone https://github.com/tridge-hq/nvim-lua.git
$ cd nvim-lua
$ ./install.sh
```

## Features

### Core Components
- **Plugin Manager**: lazy.nvim with aggressive lazy loading
- **LSP Support**: Full language server integration via Mason
- **Completion**: nvim-cmp with AI assistance (Copilot)
- **Syntax**: Tree-sitter based highlighting
- **File Navigation**: nvim-tree and fzf.vim
- **Git Integration**: Gitsigns and Diffview

### Performance Optimizations
- Module caching enabled (`vim.loader`)
- Event-based plugin loading
- Command/key triggered tools
- Minimal startup footprint (8 core plugins)

## Key Bindings

Leader key: `,`

### Essential Operations
- `<Leader>f` - Find files (fzf)
- `<Leader>b` - List buffers
- `<Leader>n` - Toggle file tree
- `<Leader>cf` - Format code
- `<Leader>cc` - Comment toggle
- `<C-,>` - Claude Code

### Git Operations
- `<Leader>gd` - Diff view
- `<Leader>gb` - Git blame
- `<Leader>gp` - Preview changes

### Search & Replace
- `<Leader>ro` - Spectre (find & replace)
- `<Leader>rw` - Replace word
- `<Leader>rf` - Replace in file

## Project Structure
```
nvim-lua/
├── init.lua                      # Entry point
├── lua/
│   ├── core.lua                  # Core settings
│   ├── lsp.lua                   # LSP config
│   ├── configs.lua               # Plugin configs
│   ├── keymaps.lua               # Key mappings
│   └── plugins.lua # Plugin specs
└── install.sh                    # Installation script
```

## Customization

Edit `lua/plugins.lua` to add plugins:
```lua
{
  "author/plugin",
  event = "BufReadPost",  -- or cmd, keys, ft
  config = function()
    -- configuration
  end,
}
```

## Performance Analysis
- Check startup time: `nvim --startuptime startup.log`
- Profile plugins: `:Lazy profile`
- View loaded plugins: `:Lazy`

## License
MIT
