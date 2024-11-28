return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    -- to setup format on save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.diagnostics.credo,
        null_ls.builtins.formatting.mix,
        null_ls.builtins.diagnostics.pylint.with({
          diagnostics_postprocess = function(diagnostic)
            diagnostic.code = diagnostic.message_id
          end,
        }),
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.sqlfluff.with({ extra_args = { "--dialect", "mysql" } }),
        null_ls.builtins.formatting.sqlfluff.with({ extra_args = { "--dialect", "mysql" } }),
        require("none-ls.formatting.beautysh"),
      },

      -- configure format on save
      -- on_attach = function(current_client, bufnr)
      --   if current_client.supports_method("textDocument/formatting") then
      --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      --     vim.api.nvim_create_autocmd("BufWritePre", {
      --       group = augroup,
      --       buffer = bufnr,
      --       callback = function()
      --         vim.lsp.buf.format({
      --           filter = function(client)
      --             --  only use null-ls for formatting instead of lsp server
      --             return client.name == "null-ls"
      --           end,
      --           bufnr = bufnr,
      --         })
      --       end,
      --     })
      --   end
      -- end,
    })

    vim.keymap.set("n", "<leader>df", vim.lsp.buf.format, {})
  end,
}
