return {
  -- Mason: Installer
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },

  -- Mason LSP Brücke
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "rust_analyzer",
          "pyright",
          "clangd",
          "marksman",
          "jsonls",
          "bashls",
        },
        automatic_installation = true,
      })
    end,
  },

  -- Native LSP mit neuer API
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Diagnostics Config
      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Popup bei CursorHold
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          vim.diagnostic.open_float(nil, {
            focusable = false,
            border = "rounded",
            source = "always",
            prefix = " ",
          })
        end,
      })

      -- Keymaps wenn LSP attached
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end

      -- Hilfsfunktion zum Starten eines Servers
      local function start_server(name, cmd, filetypes, settings)
        local root_dir = function(fname)
          return vim.fs.dirname(
            vim.fs.find({ ".git", "package.json", ".luarc.json", "pyproject.toml" }, {
              upward = true,
              path = fname,
            })[1]
          ) or vim.loop.cwd()
        end

        local config = {
          name = name,
          cmd = cmd,
          filetypes = filetypes,
          root_dir = root_dir(vim.api.nvim_buf_get_name(0)),
          capabilities = capabilities,
          on_attach = on_attach,
          settings = settings or {},
        }

        vim.lsp.start(config)
      end

      -- Server starten
      start_server("lua_ls", { "lua-language-server" }, { "lua" }, {
        Lua = { diagnostics = { globals = { "vim" } } },
      })

      start_server("ts_ls", { "typescript-language-server", "--stdio" }, {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
      })

      start_server("rust_analyzer", { "rust-analyzer" }, { "rust" })
      start_server("pyright", { "pyright-langserver", "--stdio" }, { "python" })
      start_server("clangd", { "clangd" }, { "c", "cpp", "objc", "objcpp" })
      start_server("marksman", { "marksman", "server" }, { "markdown" })
      start_server("jsonls", { "vscode-json-language-server", "--stdio" }, { "json" })
      start_server("bashls", { "bash-language-server", "start" }, { "sh", "bash" })
    end,
  },

  -- Autocompletion mit Snippets
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
