return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		priority = 1000,
		config = function()
			local colors = {
				bg = "#0f0f0f",          -- bg         hsl(2, 2, 6)
				bg_light = "#1a1a1a",   -- _bg_light  hsl(0, 0, 10)
				bg_cursor = "#262626",  -- _bg_cursor hsl(0, 0, 15)
				fg_bright = "#ffffff",  -- fg_bright
				fg = "#d9d9d9",         -- fg
				fg_dim = "#b3b3b3",     -- fg_dim
				fg_dull = "#8c8c8c",    -- fg_dull

				gray = "#4d4d4d",       -- gray
				gray_light = "#737373", -- gray_light
			}

			local custom_theme = {
				normal = {
					a = { fg = colors.bg, bg = colors.fg_bright, gui = 'none' },
					b = { fg = colors.fg, bg = colors.bg_light },
					c = { fg = colors.fg_dim, bg = colors.bg },
					z = { fg = colors.bg, bg = colors.fg_bright, gui = 'none' },
				},
				insert = {
					a = { fg = colors.bg, bg = colors.fg, gui = 'none' },
					b = { fg = colors.fg, bg = colors.bg_light },
					c = { fg = colors.fg_dim, bg = colors.bg },
					z = { fg = colors.bg, bg = colors.fg, gui = 'none' },
				},
				visual = {
					a = { fg = colors.bg, bg = colors.fg_dim, gui = 'none' },
					b = { fg = colors.fg, bg = colors.bg_light },
					c = { fg = colors.fg_dim, bg = colors.bg },
					z = { fg = colors.bg, bg = colors.fg_dim, gui = 'none' },
				},
				replace = {
					a = { fg = colors.fg_bright, bg = colors.bg_cursor, gui = 'none' },
					b = { fg = colors.fg, bg = colors.bg_light },
					c = { fg = colors.fg_dim, bg = colors.bg },
					z = { fg = colors.fg_bright, bg = colors.bg_cursor, gui = 'none' },
				},
				command = {
					a = { fg = colors.bg, bg = colors.fg_dull, gui = 'none' },
					b = { fg = colors.fg, bg = colors.bg_light },
					c = { fg = colors.fg_dim, bg = colors.bg },
					z = { fg = colors.bg, bg = colors.fg_dull, gui = 'none' },
				},
				inactive = {
					a = { fg = colors.gray_light, bg = colors.bg, gui = 'none' },
					b = { fg = colors.gray_light, bg = colors.bg },
					c = { fg = colors.gray, bg = colors.bg },
					z = { fg = colors.gray_light, bg = colors.bg, gui = 'none' },
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
							color = { fg = colors.bg, bg = colors.bg }
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
							diagnostics_color = {
								error = { fg = colors.fg_bright, bg = colors.bg_cursor }
							},
						},
						{
							'diagnostics',
							source = { 'nvim' },
							sections = { 'warn' },
							diagnostics_color = {
								warn = { fg = colors.fg, bg = colors.bg_cursor }
							},
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
