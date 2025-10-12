return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	opts = {
		-- inlay_hints = { enabled = true },
		servers = {
			dartls = {
				cmd = { "dart", "language-server", "--protocol=lsp" }
			}
		}
	},
	config = function()
		local lsp = require("lspconfig")
		local keymap = vim.keymap;

		function references(bufnr, winnr)
			local bufnr = bufnr or 0
			local winnr = winnr or 0
			local params = vim.lsp.util.make_position_params(winnr)
			params.context = { includeDeclaration = true }
			local MiniPick = require 'mini.pick'

			vim.lsp.buf_request(bufnr, 'textDocument/references', params, function(err, result)
				if err then
					vim.print 'err\n'
					vim.print(err)
					return
				end
				if result == nil or vim.tbl_isempty(result) then
					vim.print 'empty result'
					return
				end
				local items = {}
				local locations = vim.lsp.util.locations_to_items(result, 'utf-8')
				for _, location in ipairs(locations) do
					table.insert(items,
						string.format('%s:%d:%d:%s', location.filename, location.lnum, location.col, location.text))
				end
				MiniPick.start({ source = { items = items, name = 'LSP References' } })
			end)
		end

		local on_attach = function(_, buf)
			local opts = { noremap = true, silent = true, buffer = buf }
			keymap.set("n", "gd", vim.lsp.buf.definition, opts);
			keymap.set("n", "gr", references, opts);
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts);
			keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts);
			keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts);
			keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts);
			keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts);
			keymap.set('n', '<C-p>', vim.lsp.buf.signature_help, opts);

			keymap.set("n", "]g", vim.diagnostic.goto_next)
			keymap.set("n", "[g", vim.diagnostic.goto_prev)

			-- vim.lsp.inlay_hint.enable(true)
			-- vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#9DA9A0" })
			-- Setup autoformatting on buffer write
			-- vim.cmd [[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format() ]]
		end

		local caps = require("cmp_nvim_lsp").default_capabilities();

		lsp["wgsl_analyzer"].setup({
			capabilities = caps,
			on_attach = on_attach,
		})

		lsp["rust_analyzer"].setup({
			capabilities = caps,
			on_attach = on_attach,
		})

		lsp["ts_ls"].setup({
			capabilities = caps,
			on_attach = on_attach,
		})

		lsp["dartls"].setup({
			capabilities = caps,
			on_attach = on_attach,
		})
	end
}
