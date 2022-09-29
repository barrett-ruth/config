vim.g.markdown_fenced_languages = {
    'c',
    'css',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'lua',
    'python',
    'sql',
    'typescript',
    'typescriptreact',
    'vim',
    'yaml',
}

require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'comment',
        'cpp',
        'css',
        'dockerfile',
        'gitignore',
        'graphql',
        'html',
        'http',
        'java',
        'javascript',
        'json',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'sql',
        'tsx',
        'typescript',
        'vim',
        'yaml',
    },
    indent = {
        enable = false,
    },
    highlight = {
        enable = true,
    },
    textobjects = {
        move = {
            enable = true,
            set_jumps = true,
            goto_previous_start = {
                ['[a'] = '@parameter.inner',
                ['[c'] = '@call.outer',
                ['[C'] = '@class.outer',
                ['[f'] = '@function.outer',
                ['[i'] = '@conditional.outer',
            },
            goto_next_start = {
                [']a'] = '@parameter.inner',
                [']c'] = '@call.outer',
                [']C'] = '@class.outer',
                [']f'] = '@function.outer',
                [']i'] = '@conditional.outer',
            },
        },
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

local utils = require 'utils'

utils.map {
    'n',
    '<leader>th',
    utils.mapstr 'TSHighlightCapturesUnderCursor',
}
