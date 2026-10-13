#!/usr/bin/env bash
# Set up this Neovim config on Linux: system tools, then plugins, treesitter parsers, LSP servers,
# the Neovide config and an `n` alias (scripts/setup.lua). Safe to run again after a pull.
#
#   ~/.config/nvim/install.sh
#
# Packages come from apt, dnf or pacman (sudo). Neovim, Neovide and the Nerd Fonts come from their
# official releases when the distro's versions are missing or too old; those go in ~/.local.
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
      fzf ripgrep fd-find nodejs npm xclip wl-clipboard fontconfig
    # Debian/Ubuntu ship fd as `fdfind`
    if ! have fd && have fdfind; then ln -sf "$(command -v fdfind)" "$bin/fd"; fi
  elif have dnf; then
    sudo dnf install -y git gcc gcc-c++ make curl unzip tar gzip xz \
      fzf ripgrep fd-find nodejs npm xclip wl-clipboard fontconfig
  elif have pacman; then
    sudo pacman -S --needed --noconfirm git base-devel curl unzip tar gzip xz \
      fzf ripgrep fd nodejs npm xclip wl-clipboard fontconfig \
      neovim neovide
  else
    log "no apt-get, dnf or pacman: install git, a C compiler, curl, unzip, xz, fzf, ripgrep, fd,"
    log "nodejs/npm and xclip or wl-clipboard yourself, then run this again"
    exit 1
  fi
}

# the config uses vim.lsp.config / vim.lsp.enable, so it needs Neovim 0.11+
nvim_is_recent() {
  have nvim || return 1
  local major minor
  read -r major minor < <(nvim --version | head -n1 | sed -E 's/^NVIM v([0-9]+)\.([0-9]+).*/\1 \2/')
  [ "$major" -gt 0 ] || [ "$minor" -ge 11 ]
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

install_neovide() {
  if have neovide; then log "ok         neovide"; return; fi
  if [ "$(uname -m)" != x86_64 ]; then log "skipping Neovide: no Linux release for $(uname -m)"; return; fi
  log "installing Neovide (official release)"
  curl -fsSL "https://github.com/neovide/neovide/releases/latest/download/neovide-linux-x86_64.tar" | tar -xf - -C "$bin"
}

# $1 = Nerd Fonts release name, e.g. JetBrainsMono; installs the <name>NerdFont-*.ttf variant
install_font() {
  # no grep -q: with pipefail, an early exit would SIGPIPE fc-list and fail the check
  if fc-list | grep "$1NerdFont-" >/dev/null; then log "ok         $1 Nerd Font"; return; fi
  log "installing $1 Nerd Font"
  local dir="$HOME/.local/share/fonts/$1NerdFont"
  mkdir -p "$dir"
  curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$1.tar.xz" |
    tar -xJf - -C "$dir" --wildcards "$1NerdFont-*.ttf"
  fc-cache -f "$dir" >/dev/null
}

install_macos() {
  # TODO(macOS): Homebrew: neovim git fzf ripgrep fd node, and casks neovide,
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
    install_neovide
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
  *) log "note: add $bin to your PATH (e.g. in ~/.profile) so nvim, neovide and fd are found" ;;
esac
exit "$status"
