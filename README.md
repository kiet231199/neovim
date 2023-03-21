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

# Installation (install.sh now is obsolete, and need to update)
- Download above applications which has "Binary prebuild" tag and put it into tools directory.
- Create a neovim directory like below.

```shell
/path/to/your/
└── dotfiles ($dotfiles)
    ├── install.sh
    ├── config/ ($config)
    │   ├── mason/                  # Storing lSP
    │   │   ├── bin/
    │   │   │   └── pack.tar.bz2             
    │   │   └── packages/
    │   │       ├── pack_1.tar.bz2 
    │   │       ├── pack_2.tar.bz2   
    │   │       └── pack_3.tar.bz2  
    │   ├── nvim/                   # Storing neovim configuration
    │   │   ├── init.lua
    │   │   └── lua/user/*.lua
    │   ├── pack/pack.tar.bz2       # Storing neovim plugins
    │   ├── tmux/pack.tar.bz2       # Storing tmux plugins and configuration
    │   └── zsh/pack.tar.bz2        # Storing zsh plugins and configuration
    └── tools ($tool)
        └── <package>.tar.bz2
```
- Run install.sh and wait.
```bash
cd /path/to/your/dotfiles
./install.sh
```

- If you need to install manually, follow these below instruction.
- Extract all below compressed files.

```bash
# Assume that your neovim path like this: /home/kietpham/dotfiles/
dotfiles=/home/kietpham/dotfiles/
config=$neovim/config
tool=$neovim/tools

# Setup tools
cd $tool
tar -xf <package>.tar.bz2
rm -rf <package>.tar.bz2

# Language Server
cd $config/mason/bin
tar -xf pack.tar.bz2
cd $config/mason/packages
tar -xf pack_1.tar.bz2
tar -xf pack_2.tar.bz2

# After that, you can remove compressed files.
```

- Export binary file to **$PATH**, add these lines to your ~/.bashrc.
 
```bash
# Some SW have src/bin dir, some doesn't have, some even doesn't have a src dir.
export PATH=$TOOLS:$PATH
export PATH=$TOOLS/<softwares>:$PATH
export PATH=$TOOLS/<softwares>/bin:$PATH

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

- At home direcory, do some stuffs.

```bash
# Assume that your neovim path like this: /home/kietpham/dotfiles/
# Link your config file to home
cd $home
ln -s /home/kietpham/dotfiles/config/nvim .

# Add pynvim and nvr provider to local lib
mv /home/kietpham/dotfiles/tools/pynvim_package/* $home/.local

# Move tmux packages to home
cd $config
mv tmux/* $home

# Move zsh packages to home
cd $config
mv zsh/* $home
```

- Modify path in some lua config file.

```lua
-- Assume that your neovim path like this: /home/kietpham/dotfiles/
-- File $home/.config/nvim/init.lua
let g:python3_host_prog = '/home/kietpham/dotfiles/tools/python-3.10.7/bin/python3'
let g:node_host_prog = '/home/kietpham/dotfiles/tools/node-v16.17.1/lib/node_modules/neovim/bin/cli.js'

-- File $home.config/nvim/lua/user/packer.lua
g.nvim_profile_path = "/home/kietpham/dotfiles/config/nvim"

-- File $home.config/nvim/lua/user/mason.lua
install_root_dir = "/home/kietpham/dotfiles/config/mason"

-- File $home/.config/mason/packages/lua-language-server
exec "/home/kietpham/dotfiles/config/mason/packages/..."
```
- After installation, run nvim will have some errors.
```lua
-- Open a blank workspace
nvim
-- Type below commands
:PackerLoad noice.nvim
:UpdateRemotePlugins
:PackerCompile
```
