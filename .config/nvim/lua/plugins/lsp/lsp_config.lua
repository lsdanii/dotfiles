return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	opts = {
		servers = {
			dartls = {
				cmd = { "dart", "language-server", "--protocol=lsp" }
			}
		}
	},
	config = function()
		local keymap = vim.keymap;
		local on_attach = function(_, buf)
			local opts = { noremap = true, silent = true, buffer = buf }
			keymap.set("n", "gd", vim.lsp.buf.definition, opts);
			keymap.set("n", "gr", "<cmd> FzfLua lsp_references <cr>", opts);
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts);
			keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts);
			keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts);
			keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts);
			keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts);
			keymap.set('n', '<leader>p', vim.lsp.buf.signature_help, opts);

			keymap.set("n", "]g", vim.diagnostic.goto_next)
			keymap.set("n", "[g", vim.diagnostic.goto_prev)
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = on_attach,
		})
		-- local caps = require("cmp_nvim_lsp").default_capabilities();
		vim.lsp.config("tl_ls", {})
		vim.lsp.config("rust_analyzer", {})
		vim.lsp.config("dartls", {})

		vim.lsp.enable({ "ts_ls", "rust_analyzer", "dartls" })
	end
}
