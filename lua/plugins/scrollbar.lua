return {
	"petertriho/nvim-scrollbar",
	event = "BufReadPost",
	dependencies = {
		"kevinhwang91/nvim-hlslens", -- bessere Suche
		"lewis6991/gitsigns.nvim", -- Git-Integration
		"folke/todo-comments.nvim", -- TODO-Integration
	},
	config = function()
		local scrollbar = require("scrollbar")

		scrollbar.setup({
			show = true,
			set_highlights = true,
			handlers = {
				cursor = true, -- Cursor-Position
				diagnostic = true, -- LSP-Fehler/Warnungen
				gitsigns = true, -- Git-Diffs
				search = true, -- / und * Suchmatches
			},
		})

		-- 🔍 Integration mit hlslens (Such-Highlight)
		local hlslens = require("hlslens")
		local kopts = { noremap = true, silent = true }

		vim.keymap.set(
			"n",
			"n",
			[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
			kopts
		)
		vim.keymap.set(
			"n",
			"N",
			[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
			kopts
		)
		vim.keymap.set("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
		vim.keymap.set("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
		vim.keymap.set("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
		vim.keymap.set("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

		-- 🌈 Catppuccin-Integration
		pcall(function()
			require("catppuccin").setup_integrations({
				scrollbar = true,
			})
		end)
	end,
}
