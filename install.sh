#!/usr/bin/env bash
# Set up this Neovim config on Linux: system tools, then plugins, treesitter parsers, LSP servers,
# the Neovide config and an `n` alias (scripts/setup.lua). Safe to run again after a pull.
#
#   ~/.config/nvim/install.sh
#
# Packages come from apt, dnf or pacman (sudo). Neovim, the tree-sitter CLI, Neovide and the Nerd
# Fonts come from their official releases when the distro's versions are missing or too old; those
# go in ~/.local.
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bin="$HOME/.local/bin"
opt="$HOME/.local/opt"
original_path="$PATH"
export PATH="$bin:$PATH"

log() { printf '%s\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

install_packages() {
  if have apt-get; then
    sudo apt-get update
    sudo apt-get install -y git build-essential curl unzip tar gzip xz-utils \
      fzf ripgrep fd-find nodejs npm xclip wl-clipboard fontconfig tmux
    # Debian/Ubuntu ship fd as `fdfind`
    if ! have fd && have fdfind; then ln -sf "$(command -v fdfind)" "$bin/fd"; fi
  elif have dnf; then
    sudo dnf install -y git gcc gcc-c++ make curl unzip tar gzip xz \
      fzf ripgrep fd-find nodejs npm xclip wl-clipboard fontconfig tmux
  elif have pacman; then
    sudo pacman -S --needed --noconfirm git base-devel curl unzip tar gzip xz \
      fzf ripgrep fd nodejs npm xclip wl-clipboard fontconfig tmux \
      neovim neovide
  else
    log "no apt-get, dnf or pacman: install git, a C compiler, curl, unzip, xz, fzf, ripgrep, fd,"
    log "nodejs/npm, tmux and xclip or wl-clipboard yourself, then run this again"
    exit 1
  fi
}

# nvim-treesitter's `main` branch needs Neovim 0.12+
nvim_is_recent() {
  have nvim || return 1
  local major minor
  read -r major minor < <(nvim --version | head -n1 | sed -E 's/^NVIM v([0-9]+)\.([0-9]+).*/\1 \2/')
  [ "$major" -gt 0 ] || [ "$minor" -ge 12 ]
}

install_neovim() {
  if nvim_is_recent; then log "ok         $(nvim --version | head -n1)"; return; fi
  local arch
  case "$(uname -m)" in
    x86_64) arch=x86_64 ;;
    aarch64 | arm64) arch=arm64 ;;
    *) log "no Neovim release for $(uname -m)"; exit 1 ;;
  esac
  log "installing Neovim (official nvim-linux-$arch release)"
  rm -rf "$opt/nvim-linux-$arch"
  curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$arch.tar.gz" | tar -xzf - -C "$opt"
  ln -sf "$opt/nvim-linux-$arch/bin/nvim" "$bin/nvim"
}

# builds the treesitter parsers; nvim-treesitter needs 0.26.1+, newer than most distros ship
tree_sitter_is_recent() {
  have tree-sitter || return 1
  local major minor patch
  read -r major minor patch < <(tree-sitter --version | sed -E 's/^tree-sitter ([0-9]+)\.([0-9]+)\.([0-9]+).*/\1 \2 \3/')
  [ "$major" -gt 0 ] || [ "$minor" -gt 26 ] || { [ "$minor" -eq 26 ] && [ "$patch" -ge 1 ]; }
}

install_tree_sitter() {
  if tree_sitter_is_recent; then log "ok         $(tree-sitter --version)"; return; fi
  local arch
  case "$(uname -m)" in
    x86_64) arch=x64 ;;
    aarch64 | arm64) arch=arm64 ;;
    *) log "no tree-sitter release for $(uname -m)"; exit 1 ;;
  esac
  log "installing tree-sitter CLI (official release)"
  curl -fsSL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-$arch.gz" |
    gunzip >"$bin/tree-sitter"
  chmod +x "$bin/tree-sitter"
}

install_neovide() {
  if have neovide; then log "ok         neovide"; return; fi
  if [ "$(uname -m)" != x86_64 ]; then log "skipping Neovide: no Linux release for $(uname -m)"; return; fi
  log "installing Neovide (official release)"
  curl -fsSL "https://github.com/neovide/neovide/releases/latest/download/neovide-linux-x86_64.tar" | tar -xf - -C "$bin"
}

# lightweight terminal (alacritty/alacritty.toml, which needs 0.14+), running tmux for tabs
alacritty_is_recent() {
  have alacritty || return 1
  local major minor
  read -r major minor < <(alacritty --version | sed -E 's/^alacritty ([0-9]+)\.([0-9]+).*/\1 \2/')
  [ "$major" -gt 0 ] || [ "$minor" -ge 14 ]
}

# from the distro when it packages a new enough one; otherwise built from source with cargo
# (Alacritty has no official Linux builds) into ~/.local/bin, with an app launcher entry
install_alacritty() {
  if alacritty_is_recent; then log "ok         $(alacritty --version)"; return; fi
  if have apt-get; then sudo apt-get install -y alacritty || true
  elif have dnf; then sudo dnf install -y alacritty || true
  elif have pacman; then sudo pacman -S --needed --noconfirm alacritty || true
  fi
  if alacritty_is_recent; then log "ok         $(alacritty --version)"; return; fi
  log "building Alacritty from source (the distro's is missing or older than 0.14; takes a few minutes)"
  if have apt-get; then
    sudo apt-get install -y cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev \
      libxcb-xfixes0-dev libxkbcommon-dev python3
  elif have dnf; then
    sudo dnf install -y cmake g++ freetype-devel fontconfig-devel libxcb-devel libxkbcommon-devel
  fi
  if ! have cargo && [ ! -x "$HOME/.cargo/bin/cargo" ]; then
    curl --proto '=https' --tlsv1.2 -fsSL https://sh.rustup.rs | sh -s -- -y --profile minimal --no-modify-path
  fi
  "$(command -v cargo || echo "$HOME/.cargo/bin/cargo")" install --locked alacritty --root "$HOME/.local"
  # same id as the distro's entry, so the launcher opens this one
  mkdir -p "$HOME/.local/share/applications"
  cat >"$HOME/.local/share/applications/Alacritty.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Alacritty
Comment=Terminal (tmux tabs)
Exec=$bin/alacritty
Icon=utilities-terminal
Terminal=false
Categories=System;TerminalEmulator;
EOF
  log "installed $("$bin/alacritty" --version)"
}

# $1 = Nerd Fonts release name, e.g. JetBrainsMono; installs the <name>NerdFontMono-*.ttf variant,
# whose icons are one cell wide, like the text, instead of spilling into the next cell
install_font() {
  # no grep -q: with pipefail, an early exit would SIGPIPE fc-list and fail the check
  if fc-list | grep "$1NerdFontMono-" >/dev/null; then log "ok         $1 Nerd Font Mono"; return; fi
  log "installing $1 Nerd Font Mono"
  local dir="$HOME/.local/share/fonts/$1NerdFontMono"
  mkdir -p "$dir"
  curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$1.tar.xz" |
    tar -xJf - -C "$dir" --wildcards "$1NerdFontMono-*.ttf"
  fc-cache -f "$dir" >/dev/null
}

install_macos() {
  # TODO(macOS): Homebrew: neovim git tree-sitter-cli fzf ripgrep fd node, and casks neovide, alacritty,
  # font-jetbrains-mono-nerd-font, font-iosevka-nerd-font. clang comes with the Xcode command line
  # tools. Then the same scripts/setup.lua run as below.
  log "macOS setup isn't written yet"
  exit 1
}

case "$(uname -s)" in
  Linux)
    mkdir -p "$bin" "$opt"
    install_packages
    install_neovim
    install_tree_sitter
    install_neovide
    install_alacritty
    install_font JetBrainsMono
    install_font Iosevka
    ;;
  Darwin) install_macos ;;
  *) log "unsupported OS: $(uname -s)"; exit 1 ;;
esac

if ! have node || [ "$(node -p 'process.versions.node.split(".")[0]')" -lt 18 ]; then
  log "warning: some LSP servers need Node.js 18+; you have $(node --version 2>/dev/null || echo none)"
fi

# lazy.nvim rewrites lazy-lock.json with whatever ended up installed; keep the committed pins
pinned="$(mktemp)"
cp "$repo/lazy-lock.json" "$pinned"
status=0
nvim --headless "+lua dofile([[$repo/scripts/setup.lua]])" || status=$?
if ! cmp -s "$pinned" "$repo/lazy-lock.json"; then
  cp "$pinned" "$repo/lazy-lock.json"
  log "restored lazy-lock.json (lazy.nvim had changed it)"
fi
rm -f "$pinned"

case ":$original_path:" in
  *":$bin:"*) ;;
  *) log "note: add $bin to your PATH (e.g. in ~/.profile) so nvim, tree-sitter, neovide and fd are found" ;;
esac
exit "$status"
