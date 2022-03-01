vim.fn.sign_define('DiagnosticSignError', { texthl = 'DiagnosticSignError', text = '>' })
vim.fn.sign_define('DiagnosticSignWarn', { texthl = 'DiagnosticSignWarn', text = '-' })
vim.fn.sign_define('DiagnosticSignHint', { texthl = 'DiagnosticSignHint', text = '*' })
vim.fn.sign_define('DiagnosticSignInfo', { texthl = 'DiagnosticSignInfo', text = ':' })

local sources = {
    Pyright = 'pyright',
    vimlsp = 'vim',
}
sources['dockerfile-utils'] = 'dockerfile'
sources['Lua Diagnostics.'] = 'lua'
sources['Lua Syntax Check.'] = 'lua'

vim.diagnostic.config {
    update_in_insert = true,
    virtual_text = false,
    signs = false,
    severity_sort = true,
    float = {
        header = '',
        prefix = '',
        format = function(diagnostic)
            local code = diagnostic.user_data.lsp.code
            local message = diagnostic.message
            local source = sources[diagnostic.source] or diagnostic.source
            source = source or 'efm'

            if require('utils').empty(code) then
                return string.format('%s [%s]', message, source)
            else
                return string.format('%s [%s: %s]', message, source, code)
            end
        end,
    },
}

local ns = vim.api.nvim_create_namespace 'lsp_signs'
local dshow = vim.diagnostic.show

local function set_signs(bufnr)
    local diags = vim.diagnostic.get(bufnr)
    local line_severity = {}

    for _, d in pairs(diags) do
        local m = line_severity[d.lnum]
        if not m or d.severity < m.severity then
            line_severity[d.lnum] = d
        end
    end

    local fixed = vim.tbl_values(line_severity)
    dshow(ns, bufnr, fixed, {
        focus = false,
        priority = 0,
        signs = true,
    })
end

function vim.diagnostic.show(nsc, bufnr, ...)
    dshow(nsc, bufnr, ...)
    set_signs(bufnr)
end
