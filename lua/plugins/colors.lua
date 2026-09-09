-- helper to tweak highlights
local function configure_cursorline()
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3a3a3a" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff", bg = "#3a3a3a" })
end

return {
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			vim.opt.termguicolors = true

			require("onedark").setup({
				style = "darker", -- dark, darker, cool, deep, warm, warmer, light
				transparent = true,
			})

			require("onedark").load()
			configure_cursorline()
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			theme = "onedark",
		},
	},
}
