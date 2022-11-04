vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.wrap = false
vim.o.numberwidth = 1
vim.o.number = false
vim.o.signcolumn = 'yes'
vim.g.mapleader = ' '

vim.cmd[[colorscheme catppuccin]]

local on_attach = function(client, bufnr)
    local builtin = require('telescope.builtin')
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, bufopts)
    vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, bufopts)
    vim.keymap.set('n', '<leader>b', require'telescope'.extensions.file_browser.file_browser, bufopts)
    vim.keymap.set('n', '<leader>ic', builtin.lsp_incoming_calls, bufopts)
    vim.keymap.set('n', '<leader>oc', builtin.lsp_outgoing_calls, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Rust
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
            }
        }
    },
}

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- Elixir
require'elixir'.setup {
    repo = "elixir-lsp/elixir-ls",
    branch = "master", -- defaults to nil, just checkouts out the default branch, mutually exclusive with the `tag` option
    on_attach = on_attach
}

-- Lspconfig
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end


-- Telescope
require("telescope").load_extension "file_browser"
