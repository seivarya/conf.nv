return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",

				background = {
					light = "latte",
					dark = "mocha",
				},

				transparent_background = false,
				show_end_of_buffer = false,
				term_colors = false,

				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},

				-- Force-disable ALL styles everywhere
				no_italic = true,
				no_bold = true,
				no_underline = true,

				styles = {
					comments     = {},
					conditionals = {},
					loops        = {},
					functions    = {},
					keywords     = {},
					strings      = {},
					variables    = {},
					numbers      = {},
					booleans     = {},
					properties   = {},
					types        = {},
					operators    = {},
				},

				lsp_styles = {
					virtual_text = {
						errors       = {},
						hints        = {},
						warnings     = {},
						information  = {},
						ok           = {},
					},
					underlines = {
						errors       = {},
						hints        = {},
						warnings     = {},
						information  = {},
						ok           = {},
					},
					inlay_hints = {
						background = false,
					},
				},

				color_overrides = {},
				custom_highlights = {},

				default_integrations = true,
				auto_integrations = false,

				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					notify = false,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
				},
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
