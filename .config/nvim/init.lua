vim.g.mapleader = " "
vim.cmd.colorscheme("retrobox")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.ignorecase=true
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.undofile = true

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank({timeout=400}) end,
})

vim.pack.add({
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-mini/mini.pick",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
})

require("oil").setup()
require("mini.pick").setup()
require("mason").setup()
require("blink.cmp").setup({
    keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    completion = {
        menu = {
            draw = {
                columns = { { "label", "label_description", gap = 1 } },
            },
        },
    },

})

vim.lsp.config("rust_analyzer", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("dartls", {})
vim.lsp.enable({"rust_analyzer", "ts_ls", "dartls"})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, timeout_ms = 3000 })
            end,
        })
    end,
})

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "open parent directory" })
vim.keymap.set("n", "<leader>f", "<cmd>Pick files<cr>", {})
vim.keymap.set("n", "<leader>b", "<cmd>pick buffers<cr>", {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts);
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts);
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts);
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts);
vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts);
vim.keymap.set('n', '<leader>p', vim.lsp.buf.signature_help, opts);
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)

vim.keymap.set("n", "<leader>d", ":t.<CR>", {});
vim.keymap.set("v", "<leader>d", ":t'><CR>", {});
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]])


