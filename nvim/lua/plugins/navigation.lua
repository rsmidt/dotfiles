return {
    -- Code Navigation
    {
        'nvim-telescope/telescope.nvim',
        priority = 1000,
        dependencies = {
            'nvim-lua/plenary.nvim',
            "nvim-telescope/telescope-file-browser.nvim"
        },
        config = function()
            require('telescope').setup {
                defaults = {
                    file_ignore_patterns = { "node_modules", "vendor" }
                }
            }

            require("telescope").load_extension "file_browser"

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>lg', builtin.live_grep, bufopts)
            vim.keymap.set({'n', 'v'}, '<leader>sg', builtin.grep_string, bufopts)
            vim.keymap.set('n', '<leader>b', require'telescope'.extensions.file_browser.file_browser, bufopts)

        end
    },

    -- Autopair
    {
        "windwp/nvim-autopairs",
        config = function ()
            local npairs = require("nvim-autopairs")

            npairs.setup({
                check_ts = true,
            })
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    }
}
