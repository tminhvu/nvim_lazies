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

- **Tools:** Neovim 0.12+, git, the tree-sitter CLI (0.26.1+) and a C compiler to build the treesitter parsers (zig on Windows, gcc on Linux), fzf, ripgrep, fd, Node.js for the npm-based LSP servers, a clipboard tool on Linux, Neovide, Alacritty with tmux (psmux on Windows), and the JetBrainsMono and Iosevka Nerd Fonts in their Mono variants, whose icons are one cell wide like the text. Windows uses winget. Linux uses the distro's packages, falling back to the official Neovim, tree-sitter, Neovide and Nerd Font releases in `~/.local` when those are missing or too old.
- **Neovim side (`scripts/setup.lua`):** plugins at the `lazy-lock.json` versions, the treesitter parsers, the LSP servers through mason, the Neovide, Alacritty, tmux and Windows Terminal configs, an `n` alias for Neovide, and on Windows bash-style Tab completion in PowerShell. Tab completes as far as the matches agree, and a second Tab lists them all (`Set-PSReadLineKeyHandler -Key Tab -Function Complete` in your PowerShell profile).

Use a normal terminal, not one inside an app installed from the Microsoft Store (MSIX). Such an app can get a private, redirected copy of AppData, so the Neovide config would never reach the real `%APPDATA%`. `install.ps1` checks for this and stops.

## Neovide

- `neovide/config.toml` is copied to `%APPDATA%\neovide\config.toml` on Windows and `~/.config/neovide/config.toml` on Linux. If the installed copy differs, it's backed up as `config.toml.bak` first.
- `n` and `n file` open Neovide. The alias goes in your PowerShell profile, or in `.bashrc`, `.zshrc` or fish's `config.fish`.
- `Ctrl+=` / `Ctrl+-` zoom in and out, and `Ctrl+0` resets (`lua/config/neovide.lua`). Zoom isn't saved; to keep a size, change `size` in `neovide/config.toml`.

## Minimap

A VS Code-style minimap on the right ([mini.map](https://github.com/nvim-mini/mini.map), `lua/config/lazy/plugins/minimap.lua`). It shows the file shrunk into block characters, marks the visible part and the cursor line, and colors search hits, diagnostics and git changes. It opens with the editor.

- `<leader>mm` toggles it.
- `<leader>mf` focuses it: move in it, then `<CR>` jumps there.

## Windows Terminal

`windows-terminal/settings.json` is installed over Windows Terminal's own `settings.json` (in its package folder; a differing copy is backed up as `.bak` first). It's skipped if Windows Terminal isn't installed. The settings:
- Iosevka Nerd Font Mono 11 SemiBold with ClearType, and the Tango Light colors
- Windows PowerShell, starting in `%USERPROFILE%\Repos`
- the same tab keys as Alacritty + tmux: `Ctrl+Shift+T` new tab, `Ctrl+Shift+Q` close tab, `Alt+1` … `Alt+9` go to tab 1 … 9

Changes made in Windows Terminal's settings screen are overwritten on the next install; to keep one, copy it into this file.

## Alacritty + tmux

A lightweight terminal to run nvim in, in nvim's own colors (catppuccin latte), with tabs from tmux. On Windows that's [psmux](https://github.com/psmux/psmux), a native tmux for Windows; it installs a `tmux` command and reads the same config.

| Keys | |
|---|---|
| `Ctrl+Shift+T` | new tab, in the current folder |
| `Ctrl+Shift+Q` | close the current tab (the last one closes the window) |
| `Alt+1` … `Alt+9` | go to tab 1 … 9 |

The tabs show in a bar along the bottom. It sits there because psmux puts mouse clicks a row too low when the bar is on top. Closing the window closes its tabs, and nothing keeps running in the background.

- **Files:**
  - `alacritty/alacritty.toml`: font (Iosevka Nerd Font Mono 11 SemiBold), colors, the window, and the keys above. It's installed to `%APPDATA%\alacritty\alacritty.toml` on Windows and `~/.config/alacritty/alacritty.toml` on Linux. New windows start in `~/Repos` when it exists.
  - `tmux/tmux.conf`: the tabs and their bar. It's installed as `~/.tmux.conf`, with `tmux/windows.conf` (PowerShell, `Ctrl+V` for nvim) or `tmux/linux.conf` (true color and undercurl) appended.
  - A differing installed copy of either is backed up as `.bak` first.
- **Linux:** Alacritty needs 0.14+ for this config. It comes from the distro if that's new enough; otherwise it's built with `cargo` into `~/.local/bin`.
- **Copy and paste** are `Ctrl+Shift+C` / `Ctrl+Shift+V`. `Ctrl+C` always interrupts, and `Ctrl+V` reaches nvim (visual block). `Alt+t` and `Alt+q` also open and close tabs.
- **Windows text** uses grayscale smoothing rather than ClearType. Neovim can't ask the terminal for its background color there, so it opens in light mode (`lua/config/lazy/plugins/colorschemes.lua`), and `:ThemeToggle` switches.
