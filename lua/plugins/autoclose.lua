return {
	"m4xshen/autoclose.nvim",
	event = "BufReadPre",
	config = function()
		require("autoclose").setup({})
	end,
}
