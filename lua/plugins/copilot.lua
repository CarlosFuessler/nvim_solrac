return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "InsertEnter",
	opts = {
		suggestion = {
			enabled = not vim.g.ai_cmp,
			auto_trigger = true,
			keymap = {
				-- Diese Zeilen kannst du hinzufügen oder anpassen
				accept = "<leader>ca", -- Copilot-Vorschlag mit <leader>ca akzeptieren
				next = "<leader>cn", -- Nächsten Vorschlag mit <leader>cn anzeigen
				prev = "<leader>cp", -- Vorherigen Vorschlag mit <leader>cp anzeigen
			},
		},
		panel = { enabled = false },
		filetypes = {
			markdown = true,
			help = true,
			golang = false,
		},
	},
}
