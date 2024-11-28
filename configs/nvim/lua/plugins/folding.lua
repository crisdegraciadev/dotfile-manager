vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- local handler = function(virtText, lnum, endLnum, width, truncate)
--   local newVirtText = {}
--   local suffix = (' 󰁂 %d '):format(endLnum - lnum)
--   local sufWidth = vim.fn.strdisplaywidth(suffix)
--   local targetWidth = width - sufWidth
--   local curWidth = 0
--   for _, chunk in ipairs(virtText) do
--     local chunkText = chunk[1]
--     local chunkWidth = vim.fn.strdisplaywidth(chunkText)
--     if targetWidth > curWidth + chunkWidth then
--       table.insert(newVirtText, chunk)
--     else
--       chunkText = truncate(chunkText, targetWidth - curWidth)
--       local hlGroup = chunk[2]
--       table.insert(newVirtText, { chunkText, hlGroup })
--       chunkWidth = vim.fn.strdisplaywidth(chunkText)
--       if curWidth + chunkWidth < targetWidth then
--         suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
--       end
--       break
--     end
--     curWidth = curWidth + chunkWidth
--   end
--   table.insert(newVirtText, { suffix, 'MoreMsg' })
--   return newVirtText
-- end


-- return {
--   "kevinhwang91/nvim-ufo",
--   dependencies = {
--     "kevinhwang91/promise-async",
--   },
-- }

return {
  -- Add the `neovim-ufo` plugin and its dependencies
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- Setup `neovim-ufo` with LSP or Treesitter for folding
      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = (' 󰁂 %d '):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              local hlGroup = chunk[2]
              table.insert(newVirtText, { chunkText, hlGroup })
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              -- str width returned from truncate() may less than 2nd argument, need padding with space
              if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
              end
              break
            end
            curWidth = curWidth + chunkWidth
          end
          table.insert(newVirtText, { suffix, 'MoreMsg' })
          return newVirtText
        end,
      })

      -- Key mappings for managing folds
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
      vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith)

      -- Use the preview function to display folded content
      vim.keymap.set('n', 'K', function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end)
    end
  }
}
