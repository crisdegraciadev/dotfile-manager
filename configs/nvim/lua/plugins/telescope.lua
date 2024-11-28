return {
  "nvim-telescope/telescope.nvim",
  tag = '0.1.8',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require('telescope.builtin')

    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})


    local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
    vim.keymap.set("n", "<leader>fw", live_grep_args_shortcuts.grep_word_under_cursor)
    vim.keymap.set("v", "<leader>fv", live_grep_args_shortcuts.grep_visual_selection)

    require("telescope").setup {
      defaults = {
        mappings = {
          n = {
            ['<c-d>'] = require('telescope.actions').delete_buffer
          },
          i = {
            ['<c-d>'] = require('telescope.actions').delete_buffer
          }
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--fixed-strings",
          "--glob", "!**/test/*", "--glob", "!**/.git/*", "--glob", "!**/dist/*", "--glob", "!**/node_modules/*" }
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--glob", "!**/test/*", "--glob", "!**/.git/*", "--glob", "!**/dist/*", "--glob", "!**/node_modules/*" }
        }
      },
      extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown {} },
      }
    }


    telescope.load_extension("ui-select")
    telescope.load_extension("live_grep_args")
  end
}
