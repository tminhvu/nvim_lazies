# This is my personal Neovim configuration

## Dig in and find inspirations for your own config, don't just `git clone` this onto your machine

## Neovide

Neovide reads its config from outside this repo, so after pulling changes to `neovide/config.toml`, copy it into place:

```sh
nvim -l neovide/install.lua
```

This writes to `%APPDATA%\neovide\config.toml` on Windows and `~/.config/neovide/config.toml` elsewhere, backing up the old file as `config.toml.bak` if it differs from the repo's. On Windows it also adds `Set-Alias -Name n -Value neovide` to your PowerShell profile (once), so `n` or `n file` opens Neovide.

Run it from a normal terminal. Apps installed from the Microsoft Store (MSIX) can get a private, redirected copy of AppData, so a file written from inside one may never reach the real `%APPDATA%`.

In Neovide, `Ctrl+=` / `Ctrl+-` zoom in and out and `Ctrl+0` resets (`lua/config/neovide.lua`). Zoom isn't saved; to keep a size, change `size` in `neovide/config.toml`.
