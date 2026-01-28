return {
	'nvim-mini/mini.starter',
	version = false,
	config = function()
		require('mini.starter').setup({
			mappings = {
				{ key = 'j', action = "goto_next" },
				{ key = 'k', action = "goto_prev" },
				{ key = 'h', action = "goto_first" },
				{ key = 'l', action = "goto_last" },

				{ key = '<CR>', action = "open" },
				{ key = 'q', action = "quit" },
			}
		})
	end,
}
