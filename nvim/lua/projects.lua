local projects = {
    theCourseForum2 = {
        null_ls = {
            enabled = { 'autopep8' },
        },
        on_attach = function()
            vim.o.foldmethod = 'expr'
            vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
        end,
    },
}

local project = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')

if projects[project] and projects[project].on_attach then
    projects[project].on_attach()
end

return projects
