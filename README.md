# Neovim Dotfiles

Personal Neovim configuration written in Lua. This repository currently contains the Neovim setup used for Python and Fortran development, with completion, language-server support, Git integration, file search, and GitHub Copilot enabled.

## Features

- Sensible editor defaults, including:
  - Relative and absolute line numbers
  - 2-space indentation by default
  - System clipboard integration
  - Termguicolors and the `retrobox` colorscheme
  - Split windows opening below and to the right
- Plugin management with [lazy.nvim](https://github.com/folke/lazy.nvim)
- LSP support through `nvim-lspconfig`
- Completion through `nvim-cmp`
- Syntax parsing with `nvim-treesitter`
- Git hunk previews, blame, and diffs with `gitsigns.nvim`
- File, buffer, and live-grep search with Telescope
- Status line with Lualine
- Which-key keybinding hints
- GitHub Copilot integration
- Language-specific settings for Python and Fortran
- Restoration of the last cursor position when reopening files

## Repository Layout

```text
.
└── nvim
    └── init.lua    # Main Neovim configuration
```

## Installation

> This configuration is personal and may require small changes for your system, especially the paths to `lazy.nvim`, Pyright, and Fortls.

1. Install Neovim and the external tools you plan to use.
2. Clone this repository:

   ```bash
   git clone https://github.com/Custom-Url/dotfiles.git
   cd dotfiles
   ```

3. Back up your existing Neovim configuration, if present:

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

4. Link the configuration into Neovim's configuration directory:

   ```bash
   ln -s "$PWD/nvim" ~/.config/nvim
   ```

5. Open Neovim and install the configured plugins with lazy.nvim.

## Required Tools

The configuration expects the following components:

- Neovim with Lua configuration support
- `lazy.nvim`
- A Python environment containing `pyright`
- `fortls` for Fortran language-server support
- A working Git installation for Git-related plugins
- GitHub Copilot authentication if Copilot is enabled

The current configuration contains machine-specific paths for `lazy.nvim`, Pyright, and Fortls. Update those paths in `nvim/init.lua` before using the configuration on another machine.

## Selected Keybindings

The leader key is `Space`.

| Keybinding | Action |
| --- | --- |
| `<leader>w` | Save the current file |
| `<leader>q` | Quit the current window |
| `<leader>ff` | Find files with Telescope |
| `<leader>fg` | Search live text with Telescope |
| `<leader>fb` | List open buffers |
| `<leader>t` | Open a terminal split |
| `<leader>gp` | Preview the current Git hunk |
| `<leader>gb` | Blame the current line |
| `<leader>gd` | Show the current Git diff |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `K` | Show hover documentation |
| `<leader>rn` | Rename the symbol under the cursor |
| `<leader>ca` | Show available code actions |
| `<leader>e` | Open the diagnostic details window |
| `[d` / `]d` | Navigate to the previous / next diagnostic |
| `<C-J>` | Accept a Copilot suggestion |
| `<C-K>` / `<C-L>` | Cycle through Copilot suggestions |

## Language Support

### Python

- Pyright is configured as the language server.
- Python files use four-space indentation.

### Fortran

- Fortls is configured as the language server.
- Fortran files use two-space indentation.
- Long lines are not wrapped by default.

## Customization

Edit [`nvim/init.lua`](nvim/init.lua) to:

- Add or remove plugins
- Change editor options and keybindings
- Configure additional language servers
- Update machine-specific executable paths
- Adjust language-specific settings

## License

No license has been specified for this repository. Unless otherwise stated, the contents should be treated as personal configuration rather than software released for unrestricted reuse.
