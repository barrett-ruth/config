local fn = vim.fn

fn.sign_define('DiagnosticError', { text = '>', texthl = 'DiagnosticError' })
fn.sign_define('DiagnosticWarn', { text = '—', texthl = 'DiagnosticWarn' })
fn.sign_define('DiagnosticHint', { text = '*', texthl = 'DiagnosticHint' })
fn.sign_define('DiagnosticInfo', { text = ':', texthl = 'DiagnosticInfo' })

local lsp = vim.lsp
local handlers = lsp.handlers

handlers['textDocument/hover'] = lsp.with(handlers.hover, {
    border = 'single',
})

handlers['textDocument/signatureHelp'] = lsp.with(handlers.signature_help, {
    border = 'single',
    focusable = false,
})

local sources = {
    Pyright = 'pyright',
    ['Lua Diagnostics.'] = 'luals',
    ['Lua Syntax Check.'] = 'luals',
}

vim.diagnostic.config {
    signs = false,
    severity_sort = true,
    update_in_insert = false,
    virtual_text = false,
    float = {
        header = '',
        border = 'single',
        format = function(diagnostic)
            local code = diagnostic.code
                or (diagnostic.user_data and diagnostic.user_data.code or '')
            local message = diagnostic.message
            local source = sources[diagnostic.source] or diagnostic.source

            if require('utils').empty(code) then
                return ('%s (%s)'):format(message, source)
            else
                if source == 'pyright' then
                    code = code:gsub('report', ''):gsub('^%u', string.lower, 1)
                end

                return ('%s [%s] (%s)'):format(message, code, source)
            end
        end,
    },
}
