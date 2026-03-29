return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = true,
  cmd = { "FzfLua" },
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({
      'default',
      --fzf_opts = { ['--layout'] = 'reverse-list' },
      fzf_colors = true,
      previewers = {
        builtin = {
          treesitter = { enabled = false }
        }
      },
      keymap = {
        -- Below are the default binds, setting any value in these tables will override
        -- the defaults, to inherit from the defaults change [1] from `false` to `true`
        builtin = {
          false,                   -- do not inherit from defaults
          -- neovim `:tmap` mappings for the fzf win
          ["<M-Esc>"]    = "hide", -- hide fzf-lua, `:FzfLua resume` to continue
          ["<F1>"]       = "toggle-help",
          ["<F2>"]       = "toggle-fullscreen",
          -- Only valid with the 'builtin' previewer
          ["<F3>"]       = "toggle-preview-wrap",
          ["<F4>"]       = "toggle-preview",
          -- Rotate preview clockwise/counter-clockwise
          ["<F5>"]       = "toggle-preview-ccw",
          ["<F6>"]       = "toggle-preview-cw",
          --["<S-j>"]      = "preview-page-down",
          --["<S-k>"]      = "preview-page-up",
          ["<M-S-j>"]    = "preview-down",
          ["<M-S-k>"]    = "preview-up",
          ["<M-S-down>"] = "preview-down",
          ["<M-S-up>"]   = "preview-up",
        },
      },
      files = {
        --path_shorten = true,
        formatter = "path.filename_first"
      },
      winopts = {
        width = 1, -- 90% of screen width
        height = 1, -- 90% of screen height
        row = 0.5,    -- centered vertically
        col = 0.5,    -- centered horizontally
        preview = {
          layout = 'vertical',
          vertical = 'down:60%',
        }
      }
      --globals.winopts.preview.layout =horizontal
    })
    fzf.register_ui_select()
  end
}
