return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("dashboard").setup({
			theme = "doom",
			config = {
				header = {
					"",
					"",
					"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ",
					"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ",
					"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ",
					"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ",
					"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ",
					"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
					"",
					"",
				},
				center = {
					{
						icon = "  ",
						icon_hl = "DashboardIcon",
						desc = "New File",
						desc_hl = "DashboardDesc",
						key = "n",
						key_hl = "DashboardKey",
						action = "enew",
					},
					{
						icon = "  ",
						icon_hl = "DashboardIcon",
						desc = "Find File",
						desc_hl = "DashboardDesc",
						key = "f",
						key_hl = "DashboardKey",
						action = function()
							require("telescope.builtin").find_files({ cwd = vim.fn.getcwd(), hidden = true })
						end,
					},
					{
						icon = "  ",
						icon_hl = "DashboardIcon",
						desc = "Recent Files",
						desc_hl = "DashboardDesc",
						key = "r",
						key_hl = "DashboardKey",
						action = "Telescope oldfiles",
					},
					{
						icon = "  ",
						icon_hl = "DashboardIcon",
						desc = "Live Grep",
						desc_hl = "DashboardDesc",
						key = "g",
						key_hl = "DashboardKey",
						action = function()
							require("telescope.builtin").live_grep({ cwd = vim.fn.getcwd() })
						end,
					},
					{
						icon = "  ",
						icon_hl = "DashboardIcon",
						desc = "Config",
						desc_hl = "DashboardDesc",
						key = "c",
						key_hl = "DashboardKey",
						action = "edit " .. vim.fn.stdpath("config") .. "/init.lua",
					},
					{
						icon = "  ",
						icon_hl = "DashboardIcon",
						desc = "Quit",
						desc_hl = "DashboardDesc",
						key = "q",
						key_hl = "DashboardKey",
						action = "qa",
					},
				},
				footer = function()
					local stats = require("lazy").stats()
					return {
						"",
						"  " .. stats.count .. " plugins loaded in " .. math.floor(stats.startuptime) .. "ms",
					}
				end,
			},
		})

		-- Match transparent background
		vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#61afef" })
		vim.api.nvim_set_hl(0, "DashboardIcon", { fg = "#e5c07b" })
		vim.api.nvim_set_hl(0, "DashboardDesc", { fg = "#abb2bf" })
		vim.api.nvim_set_hl(0, "DashboardKey", { fg = "#98c379", bold = true })
		vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#5c6370", italic = true })
	end,
}
