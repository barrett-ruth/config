local files = {
    'paq',
    'bufdel',
    'comment',
    'luasnippets',
    'fzf',
    'gitsigns',
    'harpoon',
    'lualine',
    'navic',
    'treesitter',
}

for _, v in ipairs(files) do
    require('paqs.' .. v)
end
