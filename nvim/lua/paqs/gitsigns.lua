require('gitsigns').setup {
    signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '—' },
        changedelete = { text = '~' },
    },
    update_debounce = 0,
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d>',
    current_line_blame_opts = {
        delay = 0,
    },
    preview_config = {
        border = 'single',
    },
    on_attach = function(_)
        local utils = require 'utils'
        local bmap, mapstr = utils.bmap, utils.mapstr

        bmap { 'n', '<leader>gb', mapstr 'Gitsigns blame_line' }
        bmap { 'n', '<leader>gp', mapstr 'Gitsigns preview_hunk' }
        bmap { 'n', '[g', mapstr 'Gitsigns prev_hunk' }
        bmap { 'n', ']g', mapstr 'Gitsigns next_hunk' }

        require 'paqs.fugitive'
        require 'paqs.worktree'
    end,
}
