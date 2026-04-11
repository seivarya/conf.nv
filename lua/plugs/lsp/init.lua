return {
	"nvim-treesitter/nvim-treesitter",

	event = "BufReadPost",

	build = ":TSUpdate",

	opts = {
		ensure_installed = { "c", "cpp", "lua", "python", "javascript" },

		sync_install = false,     -- not block startup
		auto_install = false,     

		highlight = {
			enable = true,

			disable = function(_, buf)
				return vim.api.nvim_buf_line_count(buf) > 3000
			end			
		},

		indent = { enable = false },
		incremental_selection = { enable = false },
	},

	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
