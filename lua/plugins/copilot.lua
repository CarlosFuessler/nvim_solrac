return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "InsertEnter",
	opts = {
		suggestion = {
			enabled = not vim.g.ai_cmp,
			auto_trigger = true,
			keymap = {},
		},
		panel = { enabled = false },
		filetypes = {
			markdown = true,
			help = true,
			golang = false,
		},
	},
	setup = function()
		vim.keymap.set("i", "<Tab>", function()
			local copilot = require("copilot.suggestion")
			if copilot.is_visible() then
				vim.cmd("undojoin") -- Optional, ensures the action is part of the same undo group
				copilot.accept()
			else
				-- Insert a normal tab
				return "\t"
			end
		end, { noremap = true, silent = true, expr = true })
	end,
}
