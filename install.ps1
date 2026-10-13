# Set up this Neovim config on Windows: tools via winget, then plugins, treesitter parsers,
# LSP servers, the Neovide config and an `n` alias (scripts/setup.lua). Safe to run again after a pull.
#
# Run it from a normal PowerShell window (e.g. Windows Terminal):
#   powershell -ExecutionPolicy Bypass -File "$env:LOCALAPPDATA\nvim\install.ps1"

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

# Store (MSIX) apps such as the Claude desktop app can silently redirect new AppData folders into a
# private copy, so the Neovide config would never reach the real %APPDATA%. Check before writing anything.
$probe = "nvim-setup-probe-$PID"
New-Item -ItemType Directory "$env:APPDATA\$probe" | Out-Null
$redirected = Get-Item "$env:LOCALAPPDATA\Packages\*\LocalCache\Roaming\$probe" -ErrorAction SilentlyContinue
Remove-Item "$env:APPDATA\$probe"
if ($redirected) {
  $pkg = Split-Path (Split-Path (Split-Path (Split-Path $redirected.FullName))) -Leaf
  throw "AppData writes from this shell are redirected into the app package '$pkg'. Run install.ps1 from a normal terminal instead."
}

$packages = @(
  'Neovim.Neovim',
  'Git.Git',                       # lazy.nvim, gitsigns
  'zig.zig',                       # C compiler for treesitter parsers
  'junegunn.fzf',                  # fzf-lua
  'BurntSushi.ripgrep.MSVC',       # live grep, todo search
  'sharkdp.fd',                    # file finder for fzf-lua
  'OpenJS.NodeJS.LTS',             # npm-based LSP servers
  'DEVCOM.JetBrainsMonoNerdFont',
  'Neovide.Neovide'
)
foreach ($id in $packages) {
  $null = winget list --id $id --exact --accept-source-agreements --disable-interactivity
  if ($LASTEXITCODE -eq 0) { Write-Host "ok         $id"; continue }
  Write-Host "installing $id"
  winget install --id $id --exact --silent --accept-package-agreements --accept-source-agreements --disable-interactivity
  if ($LASTEXITCODE -ne 0) { Write-Warning "winget install $id exited with $LASTEXITCODE" }
}

# Nerd Fonts that winget doesn't carry: per-user install from the official release
function Install-NerdFont([string]$Name) {
  $fontDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
  $pattern = "${Name}NerdFont-*.ttf"
  if (Get-ChildItem $fontDir -Filter $pattern -ErrorAction SilentlyContinue) { Write-Host "ok         $Name Nerd Font"; return }
  Write-Host "installing $Name Nerd Font"
  $tmp = Join-Path $env:TEMP "nerd-font-$Name-$PID"
  New-Item -ItemType Directory -Force $tmp, $fontDir | Out-Null
  curl.exe -fsSL -o "$tmp\$Name.tar.xz" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$Name.tar.xz"
  if ($LASTEXITCODE -ne 0) { throw "downloading $Name Nerd Font failed" }
  tar -xf "$tmp\$Name.tar.xz" -C $tmp $pattern
  $reg = 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts'
  foreach ($f in Get-ChildItem $tmp -Filter $pattern) {
    Copy-Item $f.FullName $fontDir -Force
    New-ItemProperty -Path $reg -Name "$($f.BaseName) (TrueType)" -Value "$fontDir\$($f.Name)" -PropertyType String -Force | Out-Null
  }
  Remove-Item $tmp -Recurse -Force
}
Install-NerdFont 'Iosevka'

# pick up anything winget just put on PATH
$env:Path = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' + [Environment]::GetEnvironmentVariable('Path', 'User')
$missing = 'nvim', 'git', 'zig', 'fzf', 'rg', 'fd', 'node', 'npm', 'neovide' | Where-Object { -not (Get-Command $_ -ErrorAction SilentlyContinue) }
if ($missing) { throw "still missing after winget: $($missing -join ', ')" }

# lazy.nvim rewrites lazy-lock.json with whatever ended up installed; keep the committed pins
$lock = "$PSScriptRoot\lazy-lock.json"
$pinned = [IO.File]::ReadAllBytes($lock)
nvim --headless "+lua dofile([[$PSScriptRoot\scripts\setup.lua]])"
$code = $LASTEXITCODE
if ([Convert]::ToBase64String([IO.File]::ReadAllBytes($lock)) -ne [Convert]::ToBase64String($pinned)) {
  [IO.File]::WriteAllBytes($lock, $pinned)
  Write-Host "restored lazy-lock.json (lazy.nvim had changed it)"
}
if ($code -ne 0) { throw "Neovim setup reported problems (see above)" }
