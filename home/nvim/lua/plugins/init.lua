return {
    -- Theming
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                flavour = "mocha"
            })

            vim.cmd("colorscheme catppuccin")
        end

    },
    {
        "mg979/vim-visual-multi"
    },
    {
        "pearofducks/ansible-vim"
    },
    {
        'stevearc/oil.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup {
                columns = { "icon" },
                keymaps = {
                  ["<M-h>"] = "actions.select_split",
                },
                view_options = {
                  show_hidden = true,
                },
            }

            -- Open parent directory in current window
            vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
        end,
    },
    {
        'windwp/nvim-ts-autotag',
        config = function()
            require('nvim-ts-autotag').setup {
                opts = {
                    -- Defaults
                    enable_close = true, -- Auto close tags
                    enable_rename = true, -- Auto rename pairs of tags
                    enable_close_on_slash = false -- Auto close on trailing </
                },
                -- Also override individual filetype configs, these take priority.
                -- Empty by default, useful if one of the "opts" global settings
                -- doesn't work well in a specific filetype
                per_filetype = {
                    ["html"] = {
                        enable_close = true
                    }
                }
            }
        end,
    }
}
