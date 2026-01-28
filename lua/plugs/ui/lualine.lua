return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		priority = 1000,
		config = function()
			local colors = {
				fg_dark = "#1e1e2e",  -- base
				blue = "#23b4fa",
				green = "#b6f9a1",
				mauve = "#cba6f7",
				red = "#f38ba8",
				yellow = "#f9e2af",
				fg = "#cdd6f4",
				gray = "#313244",      -- surface0
				inactive_fg = "#6c7086", -- overlay0
			}

			local custom_theme = {
				normal = {
					a = { fg = colors.fg_dark, bg = colors.blue, gui = 'none' },
					b = { fg = colors.fg, bg = colors.gray },
					c = { fg = colors.fg, bg = colors.fg_dark },
					z = { fg = colors.fg_dark, bg = colors.blue },
				},
				insert = {
					a = { fg = colors.fg_dark, bg = colors.green, gui = 'none' },
					b = { fg = colors.fg, bg = colors.gray },
					c = { fg = colors.fg, bg = colors.fg_dark },
				},
				visual = {
					a = { fg = colors.fg_dark, bg = colors.mauve, gui = 'none' },
					b = { fg = colors.fg, bg = colors.gray },
					c = { fg = colors.fg, bg = colors.fg_dark },
				},
				replace = {
					a = { fg = colors.fg_dark, bg = colors.red, gui = 'none' },
					b = { fg = colors.fg, bg = colors.gray },
					c = { fg = colors.fg, bg = colors.fg_dark },
				},
				command = {
					a = { fg = colors.fg_dark, bg = colors.yellow, gui = 'none' },
					b = { fg = colors.fg, bg = colors.gray },
					c = { fg = colors.fg, bg = colors.fg_dark },
				},
				inactive = {
					a = { fg = colors.inactive_fg, bg = colors.fg_dark, gui = 'none' },
					b = { fg = colors.inactive_fg, bg = colors.fg_dark },
					c = { fg = colors.inactive_fg, bg = colors.fg_dark },
				},
			}

			local empty = require('lualine.component'):extend()
			function empty:draw(default_highlight)
				self.status = ''
				self.applied_separator = ''
				self:apply_highlights(default_highlight)
				self:apply_section_separators()
				return self.status
			end

			local function process_sections(sections)
				for name, section in pairs(sections) do
					local left = name:sub(9, 10) < 'x'
					for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
						table.insert(section, pos * 2, {
							empty,
							color = { fg = colors.fg_dark, bg = colors.fg_dark }
						})
					end

					for idx, comp in ipairs(section) do
						if type(comp) ~= 'table' then
							comp = { comp }
							section[idx] = comp
						end
						comp.separator = left and { right = '' } or { left = '' }
					end
				end
				return sections
			end

			local function search_result()
				if vim.v.hlsearch == 0 then return '' end
				local last = vim.fn.getreg('/')
				if not last or last == '' then return '' end
				local count = vim.fn.searchcount { maxcount = 9999 }
				return last .. '(' .. count.current .. '/' .. count.total .. ')'
			end

			local function modified()
				if vim.bo.modified then return '+' end
				if vim.bo.modifiable == false or vim.bo.readonly == true then return '-' end
				return ''
			end

			require('lualine').setup {
				options = {
					theme = custom_theme,
					component_separators = '',
					section_separators = { left = '', right = '' },
					globalstatus = true,
					icons_enabled = true,
				},

				sections = process_sections {
					lualine_a = {
						{ 'mode', color = { gui = 'none' } },
					},

					lualine_b = {
						{ 'branch', icon = 'branch:', color = { gui = 'none' } },
						{ 'diff', symbols = { added = '+', modified = '~', removed = '-' } },

						{
							'diagnostics',
							source = { 'nvim' },
							sections = { 'error' },
							diagnostics_color = { error = { bg = colors.red, fg = colors.fg_dark } },
						},
						{
							'diagnostics',
							source = { 'nvim' },
							sections = { 'warn' },
							diagnostics_color = { warn = { bg = colors.mauve, fg = colors.fg_dark } },
						},

						{ 'filename', path = 1 },
						{ modified },
					},

					lualine_c = {},

					lualine_x = {
						search_result,
						{ function() return os.date('%H:%M:%S') end },
						{ "require'lsp-status'.status()" },
						{ 'encoding' },
					},

					lualine_y = { 'progress' },

					lualine_z = { '%l:%c', '%p%%/%L' },
				},

				inactive_sections = {
					lualine_c = { '%f %y %m' },
					lualine_x = {},
				},

				extensions = { 'nvim-tree', 'quickfix', 'fugitive' },
			}
		end,
	},
}
