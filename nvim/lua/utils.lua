local M = {}

function M.empty(s)
    return s == '' or s == nil
end

function M.toggle_list(prefix)
    if prefix == 'c' then
        QFL = (next(vim.fn.getqflist()) == nil) and false or not QFL
    else
        LL = (next(vim.fn.getloclist(0)) == nil) and false or not LL
    end

    local cmd = (prefix == 'c' and QFL or LL) and 'ope' or 'cl'

    vim.cmd(prefix .. cmd)
end

function M.map(mapping)
    vim.keymap.set(mapping[1], mapping[2], mapping[3], { noremap = true, silent = true })
end

function M.bmap(mapping)
    vim.keymap.set(mapping[1], mapping[2], mapping[3], { noremap = true, silent = true, buffer = vim.fn.bufnr '%' })
end

function M.mapstr(req, meth)
    return M.empty(meth) and string.format('<cmd>%s<cr>', req)
        or string.format("<cmd>lua require '%s'.%s<cr>", req, meth)
end

return M
