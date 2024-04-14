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
        -- when opening files, do not use windows containing these filetypes or buftypes
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
        default_component_configs = {
            container = {
                enable_character_fade = true
            },
            indent = {
                indent_size = 2,
                padding = 1, -- extra padding on left hand side
                -- indent guides
                with_markers = true,
                indent_marker = "│",
                last_indent_marker = "└",
                highlight = "NeoTreeIndentMarker",
                -- expander config, needed for nesting files
                with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
            modified = {
                symbol = "[+]",
                highlight = "NeoTreeModified",
            },
            name = {
                trailing_slash = false,
                use_git_status_colors = true,
                highlight = "NeoTreeFileName",
            },
            git_status = {
                symbols = {
                    -- Change type
                    added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                    modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                    deleted   = "✖",-- this can only be used in the git_status source
                    renamed   = "󰁕",-- this can only be used in the git_status source
                    -- Status type
                    untracked = "",
                    ignored   = "",
                    unstaged  = "󰄱",
                    staged    = "",
                    conflict  = "",
                }
            },
        },
    },
    config = function(_, opts)
        vim.fn.sign_define("DiagnosticSignError",
        {text = " ", texthl = "DiagnosticSignError"})
        vim.fn.sign_define("DiagnosticSignWarn",
        {text = " ", texthl = "DiagnosticSignWarn"})
        vim.fn.sign_define("DiagnosticSignInfo",
        {text = " ", texthl = "DiagnosticSignInfo"})
        vim.fn.sign_define("DiagnosticSignHint",
        {text = "󰌵", texthl = "DiagnosticSignHint"})
        vim.keymap.set("n", "<Leader>E", ":Neotree toggle<CR>", {desc = "NeoTree"})
        require("neo-tree").setup(opts)
    end
}
