return {
	"windwp/nvim-ts-autotag",
	ft = { "html", "javascript", "typescript", "typescriptreact", "svelte", "vue", "markdown", "javascriptreact" },
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {

				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = true,
			},

			per_filetype = {
				["html"] = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = true,
				},
			},
		})
	end,
}
