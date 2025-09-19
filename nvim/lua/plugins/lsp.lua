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
        'github/copilot.vim',
        config = function()
            vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
              expr = true,
              replace_keycodes = false
            })
            vim.g.copilot_no_tab_map = true
        end
    },
    {
        "mason-org/mason.nvim",
        opts = {
        }
    },
    {
        'neovim/nvim-lspconfig',
        config = function ()
            vim.lsp.enable("ts_ls")
            vim.lsp.enable("ansiblels")


            local bufopts = { noremap=true, silent=true, buffer=bufnr }
            vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, bufopts)

            vim.lsp.config('ansiblels', {
                filetypes = { "yaml", "yml" },
                settings = {
                  ansible = {
                    ansible = {
                      path = "ansible"
                    },
                    executionEnvironment = {
                      enabled = false
                    },
                    python = {
                      interpreterPath = "python3.13"
                    },
                    validation = {
                      enabled = true,
                      lint = {
                        enabled = true,
                        path = "ansible-lint"
                      }
                    }
                  }
                }
            })

            vim.api.nvim_create_autocmd("LspAttach", {
              group = vim.api.nvim_create_augroup("lsp", { clear = true }),
              callback = function(args)
                vim.api.nvim_create_autocmd("BufWritePre", {
                  buffer = args.buf,
                  callback = function()
                    for _, c in ipairs(vim.lsp.get_active_clients({ bufnr = args.buf })) do
                        if c.supports_method("textDocument/formatting") then
                            vim.lsp.buf.format {async = false, id = args.data.client_id }
                        end
                    end
                  end,
                })
              end
            })


            vim.keymap.set("n", "<Leader>f", function()
                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })
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
    }
}
