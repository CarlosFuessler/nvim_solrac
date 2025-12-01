return {
	"zaldih/themery.nvim",
	event = "VeryLazy",
	dependencies = {
		"rebelot/kanagawa.nvim",
		"navarasu/onedark.nvim",
		"catppuccin/nvim",
		"folke/tokyonight.nvim",
		"ellisonleao/gruvbox.nvim",
		"EdenEast/nightfox.nvim",
		"rose-pine/neovim",
		"sainnhe/everforest",
		"bluz71/vim-moonfly-colors",
		"projekt0n/github-nvim-theme",
		"shaunsingh/nord.nvim",
		"savq/melange-nvim",
		"ayu-theme/ayu-vim",
		"fenetikm/falcon",
		"olimorris/onedarkpro.nvim",
		"dracula/vim",
	},
	config = function()
		require("themery").setup({
			themes = {
				{ name = "Kanagawa", colorscheme = "kanagawa" },
				{ name = "One Dark", colorscheme = "onedark" },
				{ name = "Catppuccin", colorscheme = "catppuccin" },
				{ name = "Tokyo Night", colorscheme = "tokyonight" },
				{ name = "Gruvbox", colorscheme = "gruvbox" },
				{ name = "Nightfox", colorscheme = "nightfox" },
				{ name = "Rosé Pine", colorscheme = "rose-pine" },
				{ name = "Everforest", colorscheme = "everforest" },
				{ name = "Moonfly", colorscheme = "moonfly" },
				{ name = "GitHub", colorscheme = "github_dark" },
				{ name = "Nord", colorscheme = "nord" },
				{ name = "Melange", colorscheme = "melange" },
				{ name = "Ayu", colorscheme = "ayu" },
				{ name = "Falcon", colorscheme = "falcon" },
				{ name = "One Dark Pro", colorscheme = "onedarkpro" },
				{ name = "Dracula", colorscheme = "dracula" },
			},
			livePreview = true,
			autoSave = true,
			defaultTheme = "Catppuccin",
		})

		vim.keymap.set("n", "<leader>tc", ":Themery<CR>", { desc = "Theme Chooser" })
	end,
}
