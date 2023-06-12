return {
    {
        'barrett-ruth/import-cost.nvim',
        build = 'sh install.sh yarn',
        config = true,
        ft = { 'javascript', 'javascripreact', 'typescript', 'typescriptreact' },
    },
    {
        'stevearc/oil.nvim',
        keys = {
            { '-', '<cmd>e .<cr>' },
            { '_', '<cmd>Oil<cr>' },
        },
        opts = {
            skip_confirm_for_simple_edits = true,
            prompt_save_on_select_new_entry = false,
            float = {
                border = 'single',
            },
        },
    },
    {
        'laytan/cloak.nvim',
        config = true,
        keys = {
            { '<leader>c', '<cmd>CloakToggle<cr>' },
        },
        ft = { 'sh' },
    },
    {
        'monaqa/dial.nvim',
        keys = {
            {
                '<c-a>',
                '<cmd>lua require("dial.map").manipulate("increment", "normal")<cr>',
            },
            {
                '<c-x>',
                '<cmd>lua require("dial.map").manipulate("decrement", "normal")<cr>',
            },
            {
                'g<c-a>',
                '<cmd>lua require("dial.map").manipulate("increment", "gnormal")<cr>',
            },
            {
                'g<c-x>',
                '<cmd>lua require("dial.map").manipulate("decrement", "gnormal")<cr>',
            },
            {
                '<c-a>',
                '<cmd>lua require("dial.map").manipulate("increment", "visual")<cr>',
                mode = 'x',
            },
            {
                '<c-x>',
                '<cmd>lua require("dial.map").manipulate("decrement", "visual")<cr>',
                mode = 'x',
            },
            {
                'g<c-a>',
                '<cmd>lua require("dial.map").manipulate("increment", "gvisual")<cr>',
                mode = 'x',
            },
            {
                'g<c-x>',
                '<cmd>lua require("dial.map").manipulate("decrement", "gvisual")<cr>',
                mode = 'x',
            },
        },
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                pre_hook = require(
                    'ts_context_commentstring.integrations.comment_nvim'
                ).create_pre_hook(),
            })
        end,
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        event = 'VeryLazy',
    },
    {
        'NvChad/nvim-colorizer.lua',
        ft = vim.g.markdown_fenced_languages,
        opts = {
            filetypes = vim.g.markdown_fenced_languages,
            user_default_options = {
                RRGGBBAA = true,
                AARRGGBB = true,
                css = true,
                rgb_fun = true,
                hsl_fn = true,
                tailwind = true,
                mode = 'foreground',
            },
        },
    },
    'p00f/alabaster.nvim',
    {
        'phaazon/hop.nvim',
        config = true,
        keys = { { '<leader>h', '<cmd>HopChar2<cr>' } },
    },
    { 'windwp/nvim-autopairs', config = true, event = 'InsertEnter' },
}
