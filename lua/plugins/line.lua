-- ~/.config/nvim/lua/plugins/lualine.lua

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	opts = function()
		local lualine_mode = function()
			local mode = vim.fn.mode()
			local mode_icon = "" -- Standard-Icon: Ein Symbol, das einen Modus darstellt
			local mode_text = "NORMAL"
			local mode_color = "#8A8A8A" -- Standardfarbe

			-- Du kannst hier die Icons direkt aus dem Nerd Fonts Cheat Sheet kopieren und einfügen
			if mode == "n" then
				mode_icon = "󰈈" -- Neovim-Logo
				mode_text = "NORMAL"
				mode_color = "#00af5d" -- Grün
			elseif mode == "i" then
				mode_icon = "󰏫" -- Stift-Icon
				mode_text = "INSERT"
				mode_color = "#5a78f2" -- Blau
			elseif mode == "v" then
				mode_icon = "" -- Maus-Cursor-Icon
				mode_text = "VISUAL"
				mode_color = "#ffd44c" -- Gelb
			elseif mode == "R" then
				mode_icon = "󰑏" -- Austausch-Icon
				mode_text = "REPLACE"
				mode_color = "#f56342" -- Rot-Orange
			elseif mode == "V" then
				mode_icon = "" -- Maus-Cursor-Icon für Visual Line
				mode_text = "VISUAL LINE"
				mode_color = "#ffd44c" -- Gelb
			elseif mode == "s" then
				mode_icon = "󰑏" -- Selektions-Icon
				mode_text = "SELECT"
				mode_color = "#ffd44c" -- Gelb
			elseif mode == "t" then
				mode_icon = "" -- Terminal-Icon
				mode_text = "TERMINAL"
				mode_color = "#808080" -- Grau
			end

			-- Rückgabe des formatierten Strings
			return " " .. mode_icon .. " " .. mode_text .. " "
		end

		-- Der Rest deiner Konfiguration bleibt gleich, da die Icons
		-- für `lualine_c` (filename), `lualine_b` (diff) etc. von `nvim-web-devicons`
		-- bereitgestellt werden, das bereits mit Nerd Fonts kompatibel ist.
		local function get_diagnostics()
			local icons = require("nvim-web-devicons")
			local lsp_status = require("lsp-status")
			local lsp_name = lsp_status.status()
			local diagnostics_count = vim.diagnostic.get()
			local error_count = 0
			local warn_count = 0
			local info_count = 0
			local hint_count = 0

			for _, diag in ipairs(diagnostics_count) do
				if diag.severity == vim.diagnostic.severity.ERROR then
					error_count = error_count + 1
				elseif diag.severity == vim.diagnostic.severity.WARN then
					warn_count = warn_count + 1
				elseif diag.severity == vim.diagnostic.severity.INFO then
					info_count = info_count + 1
				elseif diag.severity == vim.diagnostic.severity.HINT then
					hint_count = hint_count + 1
				end
			end

			local result = {}
			if lsp_name then
				table.insert(result, " " .. lsp_name) -- Icon für LSP-Status
			end
			if error_count > 0 then
				table.insert(result, " " .. error_count) -- Fehler-Icon
			end
			if warn_count > 0 then
				table.insert(result, " " .. warn_count) -- Warn-Icon
			end
			if info_count > 0 then
				table.insert(result, " " .. info_count) -- Info-Icon
			end
			if hint_count > 0 then
				table.insert(result, " " .. hint_count) -- Hint-Icon
			end

			return table.concat(result, " | ")
		end

		-- Deine gesamte Lualine-Tabelle
		return {
			options = {
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
			},
			sections = {
				lualine_a = { { lualine_mode, color = { fg = "white", gui = "bold" } } },
				lualine_b = { "branch", "diff", get_diagnostics },
				lualine_c = { "filename" },
				lualine_x = { "filetype", "location", "progress" },
				lualine_y = { "o:encoding" },
				lualine_z = { "fileformat" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = { "filename" },
				lualine_c = { "diff" },
				lualine_x = { "filetype", "location" },
				lualine_y = {},
				lualine_z = { "progress" },
			},
			extensions = { "nvim-tree" },
		}
	end,
}
