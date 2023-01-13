local paq = require 'paq'
paq.setup {
    url_format = 'git@github.com:%s.git',
}

paq {
    'andymass/vim-matchup',

    'barrett-ruth/paq-nvim',

    { 'barrett-ruth/emmet.nvim', run = 'sh install.sh yarn' },
    { 'barrett-ruth/import-cost.nvim', run = 'sh install.sh yarn' },
    { 'barrett-ruth/live-server.nvim', run = 'yarn global add live-server' },

    'b0o/SchemaStore.nvim',
    'folke/neodev.nvim',
    'kristijanhusak/vim-dadbod-ui',
    'nanotee/sqls.nvim',
    'neovim/nvim-lspconfig',

    'davidsierradz/cmp-conventionalcommits',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'kristijanhusak/vim-dadbod-completion',
    'petertriho/cmp-git',

    'echasnovski/mini.ai',
    'echasnovski/mini.align',
    'echasnovski/mini.bufremove',

    { 'iamcco/markdown-preview.nvim', run = 'yarn --cwd app install' },

    'jose-elias-alvarez/null-ls.nvim',
    'jose-elias-alvarez/typescript.nvim',

    'JoosepAlviste/nvim-ts-context-commentstring',

    'Julian/vim-textobj-variable-segment',
    'kana/vim-textobj-indent',
    'kana/vim-textobj-user',
    'vimtaku/vim-textobj-keyvalue',
    'whatyouhide/vim-textobj-xmlattr',

    'lewis6991/impatient.nvim',
    'lewis6991/gitsigns.nvim',

    'L3MON4D3/LuaSnip',

    'monaqa/dial.nvim',

    'numToStr/Comment.nvim',

    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-fzy-native.nvim',
    'barrett-ruth/telescope-http.nvim',

    'nvim-lua/plenary.nvim',
    {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            vim.cmd.TSUpdateSync()
        end,
    },
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/playground',

    'nvim-tree/nvim-tree.lua',

    'NvChad/nvim-colorizer.lua',

    'tommcdo/vim-exchange',

    'tpope/vim-abolish',
    'tpope/vim-apathy',
    'tpope/vim-characterize',
    'tpope/vim-dadbod',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-surround',

    'ThePrimeagen/harpoon',
    'ThePrimeagen/git-worktree.nvim',

    'windwp/nvim-autopairs',

    'Wansmer/treesj',
}
