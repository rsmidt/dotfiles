-- nvim-treesitter `main` branch (full rewrite; incompatible with the old `master`
-- API). Requires Neovim >= 0.12, tree-sitter-cli >= 0.26.1, and a C compiler.
-- Highlighting/indent are NOT enabled automatically here -- we wire them up via a
-- FileType autocmd below, only for buffers whose parser is actually installed.

-- Parsers to install. Add more at runtime with `:TSInstall <lang>`.
local ensure_installed = {
    "typescript", "tsx", "javascript",
    "elixir", "eex", "heex",
    "yaml", "json",
    "html", "css", "scss",
    "markdown", "markdown_inline",
    "lua", "bash", "vim", "vimdoc", "query",
    "gitcommit", "diff",
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false, -- the `main` branch does not support lazy-loading
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install(ensure_installed)

            -- Enable treesitter highlighting + (experimental) indentation per
            -- buffer, but only when the parser for that filetype is available.
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("treesitter_setup", { clear = true }),
                callback = function(args)
                    local ft = vim.bo[args.buf].filetype
                    if ft == "" then
                        return
                    end

                    local lang = vim.treesitter.language.get_lang(ft)
                    if not lang then
                        return
                    end

                    local ok, added = pcall(vim.treesitter.language.add, lang)
                    if not (ok and added) then
                        return
                    end

                    vim.treesitter.start(args.buf, lang)
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        lazy = false,
        config = function()
            require("nvim-treesitter-textobjects").setup {
                select = {
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    selection_modes = {
                        ["@parameter.outer"] = "v", -- charwise
                        ["@function.outer"] = "V", -- linewise
                        ["@class.outer"] = "<c-v>", -- blockwise
                    },
                },
            }

            local select = require("nvim-treesitter-textobjects.select")
            local function sel(query)
                return function()
                    select.select_textobject(query, "textobjects")
                end
            end

            vim.keymap.set({ "x", "o" }, "af", sel("@function.outer"), { desc = "Select outer function" })
            vim.keymap.set({ "x", "o" }, "if", sel("@function.inner"), { desc = "Select inner function" })
            vim.keymap.set({ "x", "o" }, "ac", sel("@class.outer"), { desc = "Select outer class" })
            vim.keymap.set({ "x", "o" }, "ic", sel("@class.inner"), { desc = "Select inner class" })
        end,
    },
}
