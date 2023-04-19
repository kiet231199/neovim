<h1 align="center">
  <img src="https://raw.githubusercontent.com/neovim/neovim.github.io/master/logos/neovim-logo-300x87.png" alt="Neovim">
</h1>

# Features
- Plugin manager: [packer.nvim](https://github.com/wbthomason/packer.nvim)
- Colorscheme: [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- File explorer: [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
- Startup: [alpha-nvim](https://github.com/goolord/alpha-nvim)
- LSP: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- LSP highlighter: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- LSP completion: [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- LSP UI: [LspSaga](https://github.com/glepnir/lspsaga.nvim)
- Fuzzy finder: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- Float terminal: [vim-floaterm](https://github.com/voldikss/vim-floaterm)
- Notice: [nvim-notify](https://github.com/rcarriga/nvim-notify)
- Tabline: [tabline.nvim](https://github.com/kdheepak/tabline.nvim)
- Statusline: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- Git: [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim), [git-messenger.nvim](https://github.com/rhysd/git-messenger.vim)
- Clipboard: [nvim-neoclip](https://github.com/AckslD/nvim-neoclip.lua), [register.nvim](https://github.com/tversteeg/registers.nvim)
- And many other features ...

# Requirements
- [x] Neovim 0.9.0: [Binary prebuild](https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz)
- [x] Clangd+llvm 14.0.0: [Binary prebuild](https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz)
- [x] Ripgrep 13.0.0: [Binary prebuild](https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz)
- [x] Lazygit 0.35: [Binary prebuild](https://github.com/jesseduffield/lazygit/releases/download/v0.35/lazygit_0.35_Linux_x86_64.tar.gz)
- [x] Finder 8.4.0: [Binary prebuild](https://github.com/sharkdp/fd/releases/download/v8.4.0/fd-v8.4.0-x86_64-unknown-linux-gnu.tar.gz)
- [x] Fzf 0.34.0: [Binary prebuild](https://github.com/junegunn/fzf/releases/download/0.34.0/fzf-0.34.0-linux_arm64.tar.gz)
- [x] Zsh 5.8: [Binary prebuild](https://github.com/romkatv/zsh-bin/releases/download/v6.1.1/zsh-5.8-linux-x86_64.tar.gz)
- [x] Tmux-3.3a
- [x] Universal Ctags 5.8
- [x] Python 3.10.7 (with pip, pynvim and nvr)
- [x] Nodejs 16.17.1 (with npm, neovim provider)

# Add neovim --remote to your .bashrc and .zshrc (depend on your favorite shell)
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    alias nvim=nvr -cc split --remote-wait +'set bufhidden=wipe'
fi

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
    export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
    export VISUAL="nvim"
    export EDITOR="nvim"
fi
```
