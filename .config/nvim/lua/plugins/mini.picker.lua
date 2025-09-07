return {
	"nvim-mini/mini.pick",
	opts = {},
	init = function()
		local pick = require('mini.pick')

		vim.api.nvim_create_user_command('ConfigOpen', function()
			pick.builtin.files(nil, {
				source = { cwd = vim.fn.stdpath("config") }
			})
		end, {})

		pick.setup({
			-- disable icons globally
			source = { show = pick.default_show },
			mappings = {
				move_down = '<Tab>',
				toggle_preview = '<C-p>',
			},

			window = {
				config = function()
					local height = math.min(10, vim.o.lines - 10)
					local width = vim.o.columns
					return {
						anchor = 'SW',
						height = height,
						width = width,
						row = vim.o.lines,
						col = 0,
						border = 'none',
					}
				end,
				prompt_caret = '█',
				prompt_prefix = '',
			},
			options = {},
		})
	end,
	keys = {
		{ "<leader>f", function() require('mini.pick').builtin.files() end },
		{ "<leader>/", function() require('mini.pick').builtin.grep_live() end },
		{ "<leader>'", function() require('mini.pick').builtin.resume() end },
		{ "<leader>b", function() require('mini.pick').builtin.buffers() end }
	}
}
