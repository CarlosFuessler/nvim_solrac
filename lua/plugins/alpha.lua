return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {

			"   ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
			"   ████╗  ██║██║   ██║██║████╗ ████║",
			"   ██╔██╗ ██║██║   ██║██║██╔████╔██║",
			"   ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
			"   ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║██╗",
			"   ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝",
			"",
			"  Neovim • 󰊤  Code •   Terminal •   Config",
		}

		dashboard.section.buttons.val = {
			dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "󰍉  Find File", ":Telescope find_files<CR>"),
			dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
			dashboard.button("g", "󰱼  Live Grep", ":Telescope live_grep<CR>"),
			dashboard.button("c", "  Config", ":e ~/.config/nvim/init.lua<CR>"),
			dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
		}

		dashboard.section.footer.val = "Simple programming powerd by @CarlosFuessler"

		alpha.setup(dashboard.opts)
	end,
}
