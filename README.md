# This is my personal Neovim configuration

## Dig in and find inspirations for your own config, don't just `git clone` this onto your machine

## Setup

Clone into Neovim's config folder, then run the installer from a normal terminal. Run it again after every pull; anything already in place is left alone.

**Windows** (PowerShell, e.g. in Windows Terminal):

```powershell
git clone https://github.com/tminhvu/nvim_lazies "$env:LOCALAPPDATA\nvim"
powershell -ExecutionPolicy Bypass -File "$env:LOCALAPPDATA\nvim\install.ps1"
```

**Linux** (apt, dnf or pacman; asks for sudo):

```sh
git clone https://github.com/tminhvu/nvim_lazies ~/.config/nvim
~/.config/nvim/install.sh
```

**macOS**: not written yet (`install_macos` in `install.sh`).

The installer sets up:

- **Tools:** Neovim 0.12+, git, the tree-sitter CLI (0.26.1+) and a C compiler to build the treesitter parsers (zig on Windows, gcc on Linux), fzf, ripgrep, fd, Node.js for the npm-based LSP servers, a clipboard tool on Linux, Neovide, Alacritty, and the JetBrainsMono and Iosevka Nerd Fonts. Windows uses winget. Linux uses the distro's packages, falling back to the official Neovim, tree-sitter, Neovide and Nerd Font releases in `~/.local` when those are missing or too old.
- **Neovim side (`scripts/setup.lua`):** plugins at the `lazy-lock.json` versions, the treesitter parsers, the LSP servers through mason, the Neovide and Alacritty configs, and an `n` alias for Neovide.

Use a normal terminal, not one inside an app installed from the Microsoft Store (MSIX). Such an app can get a private, redirected copy of AppData, so the Neovide config would never reach the real `%APPDATA%`. `install.ps1` checks for this and stops.

## Neovide

- `neovide/config.toml` is copied to `%APPDATA%\neovide\config.toml` on Windows and `~/.config/neovide/config.toml` on Linux. If the installed copy differs, it's backed up as `config.toml.bak` first.
- `n` and `n file` open Neovide. The alias goes in your PowerShell profile, or in `.bashrc`, `.zshrc` or fish's `config.fish`.
- `Ctrl+=` / `Ctrl+-` zoom in and out, and `Ctrl+0` resets (`lua/config/neovide.lua`). Zoom isn't saved; to keep a size, change `size` in `neovide/config.toml`.

## Alacritty

A lightweight terminal to run nvim in, in nvim's own colors (catppuccin latte). Its settings:
- Iosevka Nerd Font 11 SemiBold
- 120×30 window, 5000 lines of scrollback
- on Windows: Windows PowerShell, starting in `~\Repos` (`alacritty/windows.toml`)

`alacritty/alacritty.toml` is installed to `%APPDATA%\alacritty\alacritty.toml` on Windows (with `windows.toml` appended) and `~/.config/alacritty/alacritty.toml` on Linux. A differing installed copy is backed up as `.bak` first. On Linux, Alacritty comes from the distro's packages, which need to be 0.13+ for this config.

- Copy and paste are `Ctrl+Shift+C` / `Ctrl+Shift+V`. `Ctrl+C` always interrupts, and `Ctrl+V` reaches nvim (visual block).
- There are no tabs or panes: use nvim's splits and `:terminal`, or more windows.
- On Windows, text uses grayscale smoothing rather than ClearType. Neovim can't ask Alacritty for its background color there, so it opens in light mode (`lua/config/lazy/plugins/colorschemes.lua`); `:ThemeToggle` switches.
