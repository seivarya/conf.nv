return {
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night",

				transparent = false,
				terminal_colors = false,

				styles = {
					comments = { italic = false },
					keywords = { italic = false },
					functions = { italic = false },
					variables = { italic = false },
					sidebars = "dark",
					floats = "dark",
				},

				on_highlights = function(hl, c)
					for _, group in pairs(hl) do
						if type(group) == "table" then
							group.italic = false
							group.bold = false
							group.underline = false
						end
					end
				end,

				dim_inactive = false,
				lualine_bold = false,
			})

			vim.cmd.colorscheme("tokyonight")
		end,
	},
}
