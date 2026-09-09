-- ~/.config/nvim/lua/plugins/nvim-tree.lua
return {
	"nvim-tree/nvim-tree.lua",                     -- plugin repo
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional
	config = function()
		require("nvim-tree").setup({
			view = {
				width = 30,
				side = "left",
				adaptive_size = true,
			},
			renderer = {
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
				},
			},
			filters = {
				dotfiles = false,
			},
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
		})
	end,
}
