local on_attach = require('lsp.utils').on_attach
local projects = require('projects').projects

local null_ls = require('null-ls')
local builtins = null_ls.builtins
local diagnostics, formatting =
    builtins.diagnostics, builtins.formatting

local function project_contains_source(name, opts)
    local project = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')

    if projects[project] and projects[project].lsp_sources then
        return vim.tbl_contains(projects[project].lsp_sources, name)
    end

    return (opts and opts.default) or false
end

null_ls.setup({
    sources = {
        diagnostics.curlylint.with({ extra_filetypes = { 'html' } }),
        diagnostics.gitlint.with({
            diagnostic_config = { update_in_insert = true },
            extra_args = { '--ignore', 'body-is-missing' },
        }),
        diagnostics.hadolint,
        diagnostics.markdownlint.with({
            diagnostic_config = { update_in_insert = true },
            diagnostics_format = '#{m}',
        }),
        diagnostics.mypy.with({
            extra_args = { '--check-untyped-defs' },
            runtime_condition = function(params)
                return require('null-ls.utils').path.exists(params.bufname)
            end,
        }),
        diagnostics.selene,
        diagnostics.shellcheck.with({
            extra_args = { '--enable', 'avoid-nullary-conditions' },
            runtime_condition = function(_)
                return not vim.fn.bufname():match('.env.*')
            end,
        }),
        diagnostics.sqlfluff.with({
            extra_args = {
                '--dialect',
                'postgres',
                '--exclude-rules',
                'LT02,LT05',
            },
        }),
        diagnostics.tsc,
        diagnostics.yamllint,

        formatting.black.with({
            condition = function(_)
                return project_contains_source('black', { default = true })
            end,
            extra_args = { '-S', '--fast', '--line-length=79' },
        }),
        formatting.cbfmt.with({
            condition = function(utils)
                return utils.root_has_file({ '.cbfmt.toml' })
            end,
        }),
        formatting.isort.with({
            condition = function(_)
                return project_contains_source('isort', { default = true })
            end,
        }),
        formatting.djhtml.with({
            extra_args = { '--tabwidth', '2' },
        }),
        formatting.gofumpt,
        formatting.goimports_reviser,
        formatting.golines,
        formatting.latexindent,
        formatting.markdownlint,
        formatting.prettierd.with({
            env = {
                XDG_RUNTIME_DIR = vim.env.XDG_RUNTIME_DIR
                    or (vim.env.XDG_DATA_HOME .. '/prettierd'),
            },
            filetypes = {
                'css',
                'graphql',
                'html',
                'javascript',
                'javascriptreact',
                'json',
                'markdown',
                'typescript',
                'typescriptreact',
                'yaml',
            },
        }),
        formatting.shfmt.with({
            extra_args = { '-i', '2' },
        }),
        formatting.sql_formatter,
        formatting.stylua,
    },
    on_attach = on_attach,
    debounce = 0,
})
