return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "macchiato",

			styles = {
				comments = {},
				conditionals = {},
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},

			integrations = {
				treesitter = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = {},
						hints = {},
						warnings = {},
						information = {},
					},
				},
			},

			custom_highlights = function()
				return {
					-- kill ALL styling explicitly
					Normal = { bold = false, italic = false },
					Comment = { bold = false, italic = false },
					Keyword = { bold = false, italic = false },
					Function = { bold = false, italic = false },
					Identifier = { bold = false, italic = false },
					Statement = { bold = false, italic = false },
					Type = { bold = false, italic = false },
					PreProc = { bold = false, italic = false },
					Special = { bold = false, italic = false },
					Constant = { bold = false, italic = false },
				}
			end,
		},

		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
