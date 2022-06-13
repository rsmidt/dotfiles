return require('packer').startup(function()
    use 'lewis6991/impatient.nvim' -- caches a pre-compiled lua modules
    use 'wbthomason/packer.nvim' -- auto maintenance of package manager
    use 'nathom/filetype.nvim' -- filetype.vim replacement that lazy loads when buffer open

    -- Language Support
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
            'hrsh7th/cmp-git'
        }
    }
    use 'simrat39/rust-tools.nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }


    -- Code Navigation
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Debugging
    use 'nvim-lua/plenary.nvim'
    use 'mfussenegger/nvim-dap'

    -- For luasnip users.
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- Theming
    use {
        "catppuccin/nvim",
        as = "catppuccin"
    }
end)
