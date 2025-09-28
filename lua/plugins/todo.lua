return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("todo-comments").setup({
			-- Optionen kannst du hier anpassen
			signs = true, -- zeigt Symbole im Signcolumn
			highlight = {
				keyword = "bg", -- hebt Hintergrund hervor
				after = "", -- kein extra Text highlighten
			},
		})
	end,
}
