local on_attach = function(client, bufnr)
    local builtin = require('telescope.builtin')
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, bufopts)
    vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, bufopts)
    vim.keymap.set('n', '<leader>ic', builtin.lsp_incoming_calls, bufopts)
    vim.keymap.set('n', '<leader>oc', builtin.lsp_outgoing_calls, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

return {
    {
        'github/copilot.vim'
    },
    {
        'neovim/nvim-lspconfig',
        config = function ()
            require'lspconfig'.tsserver.setup{}
        end
    },
    -- Rust
    {
        'simrat39/rust-tools.nvim',
        config = function()
            require'rust-tools'.setup {
                tools = {
                    runnables = {
                        use_telescope = true,
                    },
                    inlay_hints = {
                        auto = true,
                        show_parameter_hints = true,
                    },
                },

                server = {
                    on_attach = on_attach,
                    settings = {
                        ["rust-analyzer"] = {
                            checkOnSave = {
                                command = "clippy"
                            },
                            procMacro = {
                                enable = true
                            },
                        },
                    },
                },
            }
        end
    },

    -- Elixir
    {
        "elixir-tools/elixir-tools.nvim",
        version = "*",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local elixir = require("elixir")
            local elixirls = require("elixir.elixirls")

            elixir.setup {
                nextls = {
                    enable = false,
                    on_attach = on_attach
                },
                credo = { enable = true },
                elixirls = {
                    -- default settings, use the `settings` function to override settings
                    settings = elixirls.settings {
                        dialyzerEnabled = true,
                        fetchDeps = true,
                        enableTestLenses = true,
                        suggestSpecs = false,
                    },
                    on_attach = on_attach
                }
            }
        end
    },

    -- Debugging
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            "nvim-lua/plenary.nvim",
        }
    },

    -- Typescript Stuff
    {
        'MunifTanjim/prettier.nvim',
        config = function()
            local prettier = require("prettier")

            prettier.setup({
                bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
                filetypes = {
                    "css",
                    "graphql",
                    "html",
                    "javascript",
                    "javascriptreact",
                    "json",
                    "less",
                    "markdown",
                    "scss",
                    "typescript",
                    "typescriptreact",
                    "yaml",
                },
            })
        end
    },

    -- Null LS
    {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
            local event = "BufWritePre" -- or "BufWritePost"
            local async = event == "BufWritePost"

            require'null-ls'.setup({
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.keymap.set("n", "<Leader>f", function()
                            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
                        end, { buffer = bufnr, desc = "[lsp] format" })

                        -- format on save
                        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
                        vim.api.nvim_create_autocmd(event, {
                            buffer = bufnr,
                            group = group,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr, async = async })
                            end,
                            desc = "[lsp] format on save",
                        })
                    end

                    if client.supports_method("textDocument/rangeFormatting") then
                        vim.keymap.set("x", "<Leader>f", function()
                            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
                        end, { buffer = bufnr, desc = "[lsp] format" })
                    end
                end,
            })
        end
    }
}
