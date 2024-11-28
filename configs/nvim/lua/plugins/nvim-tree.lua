return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-web-devicons").setup({
      -- Global settings for the icons can go here
      default = true, -- Show default icons for unknown filetypes
      -- Optionally customize icons for specific file types
      override = {
        makefile = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "Makefile"
        }
      }
    })

    require("nvim-tree").setup({ view = { side = "right" } })

    vim.keymap.set("n", "<leader>e", ":NvimTreeFindFile<CR>")
  end,
}
