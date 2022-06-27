# Nvim Plug

Neovim Configuration using [Vim-Plug](https://github.com/junegunn/vim-plug) as Plugin Manager written in Lua.

[Vim-Plug](https://github.com/junegunn/vim-plug) is deliberately chosen because of it's compatibility to use Neovim directly and as embedded server editor like [VSCode-Neovim](https://github.com/vscode-neovim/vscode-neovim) or [Firenvim](https://github.com/glacambre/firenvim).

# Requirements

1. [CMake](https://cmake.org/). Usually available from your package manager on linux. On Windows, you may need to download the executable and install.

# Installation

Clone this repo to neovim config location. 

```sh
# Linux Example
git clone ssh://git@gitlab.tigor.web.id:2222/tigor/nvim-plug.git ~/.config/nvim

# Windows Example
git clone ssh://git@gitlab.tigor.web.id:2222/tigor/nvim-plug.git ~/AppData/Local/nvim
```

Execute plugin installation:

```vim
:PlugInstall
```

Plugin will be installed. Some error will appear, but that's to be expected since it will be first run and some commands expected to have the plugin already installed.

Restart Neovim and it's ready for use.
