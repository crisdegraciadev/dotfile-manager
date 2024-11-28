return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        auto_install = true,
        ensure_installed = {
          "lua_ls",
          "tsserver",
          "eslint",
          "html",
          "cssls",
          "emmet_ls",
          "pyright",
          "gopls",
          "elixirls",
          "svelte"
        },
      })
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      local function organize_ts_imports()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = "",
        }
        vim.lsp.buf.execute_command(params)
      end

      lspconfig.tsserver.setup({
        capabilities = capabilities,
        commands = {
          OrganizeImports = {
            organize_ts_imports,
            description = "Organize Imports",
          },
        },
      })

      lspconfig.eslint.setup({
        capabilities = capabilities,
        nodePath = "/Users/kairosds/.nvm/versions/node/v14.21.3/bin/node"
      })


      lspconfig.gopls.setup({
        capabilities = capabilities,
      })

      lspconfig.elixirls.setup({
        capabilities = capabilities,
        cmd = { "/Users/kairosds/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
      })

      lspconfig.svelte.setup({
        capabilities = capabilities,
      })

      lspconfig.html.setup({
        capabilities = capabilities,
      })

      lspconfig.cssls.setup({
        capabilities = capabilities,
        settings = {
          scss = {
            validate = true,
            lint = {
              unknownAtRules = "ignore"
            }
          },
        }
      })

      lspconfig.prismals.setup({
        capabilities = capabilities,
      })

      lspconfig.pyright.setup({
        capabilities = capabilities,
      })

      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        filetypes = { "html", "css", "sass", "javascript" },
      })

      lspconfig.angularls.setup({
        capabilities = capabilities,
        root_dir = util.root_pattern("angular.json", "project.json"),
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>ru", "<cmd>OrganizeImports<CR>", {})
    end,
  },
}
