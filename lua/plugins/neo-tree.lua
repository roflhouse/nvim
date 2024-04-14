return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },

    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    init = function()
        if vim.fn.argc(-1) == 1 then
            local stat = vim.uv.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then
                require("neo-tree")
            end
        end
    end,
    opts = {
        close_if_last_window = true,
        enable_git_status = true,
    },
    config = function(_, opts)
        vim.keymap.set("n", "<Leader>E", ":Neotree toggle<CR>", {desc = "NeoTree"})
        require("neo-tree").setup(opts)
    end
}
