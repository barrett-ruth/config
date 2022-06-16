local treesitter_configs = require 'nvim-treesitter.configs'

require('nvim-treesitter.configs').setup {
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ab = '@block.outer',
                ib = '@block.inner',
                af = '@function.outer',
                ['if'] = '@function.inner',
                ac = '@call.outer',
                ic = '@call.inner',
                aC = '@class.outer',
                iC = '@class.inner',
                ai = '@conditional.outer',
                ii = '@conditional.inner',
                aL = '@loop.outer',
                iL = '@loop.inner',
                aa = '@parameter.outer',
                ia = '@parameter.inner',
            },
        },
    },
}

treesitter_configs.setup {
    ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'dockerfile',
        'go',
        'html',
        'http',
        'java',
        'javascript',
        'json',
        'lua',
        'make',
        'python',
        'tsx',
        'typescript',
        'vim',
        'yaml',
    },
    sync_install = false,
    indent = {
        enable = false,
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
}

local utils = require 'utils'
local map = utils.map

map {
    'n',
    '<leader>T',
    function()
        package.loaded['paqs.treesitter'] = nil
        package.loaded['nvim-treesitter'] = nil
        require 'paqs.treesitter'
        require 'nvim-treesitter'
        vim.cmd 'e'
    end,
}
