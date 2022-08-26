local utils = require 'utils'
local map, mapstr = utils.map, utils.mapstr

-- Buffers [:
map { 'n', ']b', mapstr 'bnext' }
map { 'n', '[b', mapstr 'bprev' }
map { 'n', '<leader>bw', mapstr 'BufDel!' }
map { 'n', '<leader>bd', mapstr 'BufDel' }
map { 'n', '<c-b>', mapstr 'FzfLua buffers' }
-- :]

-- Builtins [:
map({ 'n', ':', ';' }, { silent = false })
map({ 'n', ';', ':' }, { silent = false })
map({ 'x', ':', ';' }, { silent = false })
map({ 'x', ';', ':' }, { silent = false })
map { 'n', ']p', '}' }
map { 'n', '[p', '{' }
-- :]

-- Folds [:
map { 'n', ']z', 'zj' }
map { 'n', '[z', 'zk' }
-- :]

-- Windows [:
map { 'n', '<tab>', '<c-w>' }
-- :]

-- Miscellaneous [:
map { 'n', '<leader><cr>', mapstr 'so %' }
map { 'n', '<leader>-', 'S<esc>' }
map { 'n', 'x', '"_x' }
map { 'n', 'ga', '<Plug>(EasyAlign)' }
map { 'x', 'ga', '<Plug>(EasyAlign)' }
map({ 'x', 'R', '<esc>gv"ry:%s/<c-r>r//g<left><left>' }, { silent = false })
map { 'n', 'J', 'mzJ`z' }
map { 'n', 'Q', 'q:k' }
map { 'n', '<bs>', '<c-^>' }
vim.cmd 'cno <c-n> <down>'
-- :]

-- Location List [:
map { 'n', ']l', mapstr 'lnext' }
map { 'n', '[l', mapstr 'lprev' }
map { 'n', '<leader>l', mapstr 'FzfLua loclist' }
map { 'n', '<leader>L', mapstr 'cal setloclist(0, []) | lcl' }
-- :]

-- Quickfix List [:
map { 'n', ']q', mapstr 'cnext' }
map { 'n', '[q', mapstr 'cprev' }
map { 'n', '<leader>c', mapstr 'FzfLua quickfix' }
map { 'n', '<leader>C', mapstr 'cal setqflist([]) | ccl' }
-- :]

-- Newlines [:
map { 'n', ']o', '@="m`o\\eg``"<cr>' }
map { 'n', '[o', '@="m`O\\eg``"<cr>' }
-- :]

-- Deleting/yanking/pasting [:
map { '', '<leader>d', '"_d' }
map { '', '<leader>y', '"+y' }
-- :]

-- Saving/Exiting [:
map {
    'n',
    '<leader>q',
    function()
        local scratch_bufnr = vim.fn.bufnr 'scratch'
        if scratch_bufnr ~= -1 then vim.cmd('bd ' .. scratch_bufnr) end

        vim.cmd 'q'
    end,
}
map { 'n', '<leader>Q', mapstr 'qa!' }
map {
    'n',
    '<leader>w',
    function()
        require('utils').format()
        if vim.bo.ft == 'dirbuf' then
            vim.cmd 'w!'
        else
            vim.cmd 'w'
        end
    end,
    { silent = false },
}
map { 'n', '<leader>z', 'ZZ' }
map { 'n', '<leader>Z', mapstr 'wqall' }
-- :]

-- Swapping lines [:
map { 'n', ']e', '<cmd>m+<cr>' }
map { 'n', '[e', '<cmd>m-2<cr>' }
-- :]

-- Toggling [:
map { 'n', '<leader>ic', mapstr 'let &ch = (&ch + 1) % 2' }
map {
    'n',
    '<leader>is',
    function()
        SPELLSITTER_ENABLED = (SPELLSITTER_ENABLED == nil) and false
            or not SPELLSITTER_ENABLED

        if SPELLSITTER_ENABLED then
            require('spellsitter').setup { enable = { 'none' } }
        else
            require('spellsitter').setup { enable = true }
        end
    end,
}
map { 'n', '<leader>iw', mapstr 'setl invwrap' }
-- :]
