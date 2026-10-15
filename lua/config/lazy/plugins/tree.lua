-- Treesitter parsers and their queries for the languages below, from nvim-treesitter's `main`
-- branch. The old `master` branch is archived and breaks on Neovim 0.12 (every LSP hover with a
-- code block threw errors). Highlighting stays Neovim's default; this only provides the parsers.
-- Building them needs the tree-sitter CLI and a C compiler: install.ps1 / install.sh set those up.
local M = {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false, -- doesn't support lazy-loading
  -- after a plugin update the parsers must be rebuilt to match its queries
  build = function()
    -- the update may have just replaced a loaded `master`: use the new modules
    for name in pairs(package.loaded) do
      if name:match('^nvim%-treesitter') then package.loaded[name] = nil end
    end
    require('nvim-treesitter').update():pwait(10 * 60 * 1000)
  end,
  opts = {
    ensure_installed = { "c", "java", "bash", "css", "lua", "html", "javascript", "typescript", "tsx", "json",
      "markdown", "markdown_inline", "dart", "astro", "vimdoc", "go" },
  },
  init = function()
    -- GitHub won't serve tree-sitter-html's source archive for the commit nvim-treesitter pins
    -- (404; the same commit downloads fine by branch name). Tag v0.23.2 has the identical grammar
    -- (only CI files changed since), so fetch that. Only for that exact pin: once nvim-treesitter
    -- moves html to another commit, this does nothing.
    vim.api.nvim_create_autocmd('User', {
      pattern = 'TSUpdate',
      callback = function()
        local html = require('nvim-treesitter.parsers').html
        if html and html.install_info and html.install_info.revision == '73a3947324f6efddf9e17c0ea58d454843590cc0' then
          html.install_info.revision = 'v0.23.2'
        end
      end,
    })

    -- Windows: `tree-sitter build` compiles with Rust's cc crate, which only looks for MSVC. Without
    -- Visual Studio, point it at zig (install.ps1 installs it) and turn off the cc crate's default
    -- flags: zig can't parse their --target=x86_64-pc-windows-msvc. Only the cc crate reads these
    -- names, so cmake, flutter and other builds started from Neovim keep their usual compiler.
    local vswhere = (vim.env['ProgramFiles(x86)'] or '') .. '/Microsoft Visual Studio/Installer/vswhere.exe'
    if vim.fn.has('win32') == 1 and vim.fn.executable('zig') == 1 and not vim.uv.fs_stat(vswhere) then
      for _, target in ipairs({ 'x86_64_pc_windows_msvc', 'aarch64_pc_windows_msvc' }) do
        vim.env['CC_' .. target] = vim.env['CC_' .. target] or 'zig cc'
        vim.env['CFLAGS_' .. target] = vim.env['CFLAGS_' .. target] or '-O2'
      end
      vim.env.CRATE_CC_NO_DEFAULTS = vim.env.CRATE_CC_NO_DEFAULTS or '1'
    end
  end,
  config = function(_, opts)
    -- install any missing parser in the background, after startup (a no-op once all are there;
    -- scripts/setup.lua installs them up front)
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      once = true,
      callback = function()
        local ts = require('nvim-treesitter')
        if not ts.install then -- still the old `master` checkout: the installer hasn't run since the pull
          vim.notify('nvim-treesitter is still on its old branch: run install.ps1 / install.sh', vim.log.levels.WARN)
          return
        end
        ts.install(opts.ensure_installed)
      end,
    })
  end,
}

return M
