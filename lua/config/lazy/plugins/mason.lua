return {
  "mason-org/mason-lspconfig.nvim",
  event = "UIEnter",
  --lazy = true,
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
  },

  config = function()
    ----------------------------------------------------------------------
    -- 1. Mason – install the servers (but don’t let it auto-enable them)
    ----------------------------------------------------------------------
    require("mason-lspconfig").setup({
      ensure_installed = {
        "clangd", "bashls", "cssls", "ts_ls", "eslint", "html",
        "tailwindcss", "jsonls", "marksman", "lua_ls",
      },
      automatic_enable = false, -- we enable manually later
    })

    ----------------------------------------------------------------------
    -- 2. Shared on_attach + capabilities (blink.cmp)
    ----------------------------------------------------------------------
    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = 'single' }) end, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, opts)

      vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set("n", "<leader>wl",
        function() print(vim.inspect(vim.lsp.buf.list_workspace_folder())) end, opts)

      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<space>f",
        function() vim.lsp.buf.format { async = true } end, opts)
    end

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ----------------------------------------------------------------------
    -- 3. Global defaults (applied to *every* server)
    ----------------------------------------------------------------------
    vim.lsp.config("*", {
      autostart = false,
      on_attach = on_attach,
      capabilities = capabilities,
      single_file_support = true,
      flags = { debounce_text_changes = 150 },
    })

    ----------------------------------------------------------------------
    -- 4. Server-specific overrides (only the fields that differ)
    ----------------------------------------------------------------------
    --local util = require("lspconfig.util")

    -- clangd – custom root detection
    --vim.lsp.config("clangd", {
      --root_dir = function(fname)
      --  return util.root_pattern(
      --    "src", ".clangd", "README.md", ".clang-tidy",
      --    "compile_commands.json", "compile_flags.txt", "configure.ac"
      --  )(fname) or vim.fn.getcwd()
      --end,
    --})

    --vim.lsp.config("bashls", {
    --  filetypes = { "sh", "bash", "zsh" }, -- THIS WAS MISSING
    --  single_file_support = true,
    --})

    -- tailwindcss & eslint – autostart = false
    --vim.lsp.config("tailwindcss", { autostart = false })
    --vim.lsp.config("eslint", { autostart = false })

    -- marksman – custom root + single file support
    --vim.lsp.config("marksman", {
    --  --root_dir = function(fname)
    --  --  return util.root_pattern("index.md", "README.md")(fname) or vim.fn.getcwd()
    --  --end,
    --})

    -- lua_ls – full settings block
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          --workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          telemetry = { enable = false },
        },
      },
      --root_dir = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h'),
      --root_dir = function(fname)
      --  return util.root_pattern(
      --    "README.md", ".luarc.json", ".gitignore", ".git", "main.lua", "src"
      --  )(fname) or vim.fn.getcwd()
      --end,
    })

    ----------------------------------------------------------------------
    -- 5. Enable *all* servers that Mason installed (plus any extra ones)
    ----------------------------------------------------------------------
   local servers_to_enable = {
     "clangd", "bashls", "cssls", "ts_ls", "eslint", "html",
     "tailwindcss", "jsonls", "marksman", "lua_ls",
     -- add any extra servers you want to start manually here
   }
   
   vim.lsp.enable(servers_to_enable)
  end,
}
