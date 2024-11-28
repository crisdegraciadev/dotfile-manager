return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				integrations = {
					nvimtree = false,
				},
			})

			vim.cmd.colorscheme("catppuccin")

			-- transparencies for transparent terminal
			vim.cmd("hi NonText ctermbg=none guibg=NONE")
			vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
			vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")
			vim.cmd("hi SignColumn ctermbg=NONE ctermfg=NONE guibg=NONE")
			vim.cmd("hi Pmenu ctermbg=NONE ctermfg=NONE guibg=NONE")
			vim.cmd("hi FloatBorder ctermbg=NONE ctermfg=NONE guibg=NONE")
			vim.cmd("hi NormalFloat ctermbg=NONE ctermfg=NONE guibg=NONE")
			vim.cmd("hi TabLine ctermbg=None ctermfg=None guibg=None")
			vim.cmd("highlight LineNr guibg=NONE")
		end,
	},
}
