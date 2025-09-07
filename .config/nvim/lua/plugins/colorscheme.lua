return {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
        -- vim.g.gruvbox_material_enable_italic = true
        vim.g.gruvbox_material_better_performance = 1
        vim.cmd.colorscheme('gruvbox-material')
    end
}
