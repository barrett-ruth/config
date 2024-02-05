local colors = require('colors')
colors.setup('light', 'light')

local hi, link, tshi, cs =
    colors.hi, colors.link, colors.tshi, colors[vim.g.colors_name]

hi('Normal', { fg = cs.black, bg = cs.bg }, { 'Identifier', 'Special' })
hi('LineNr', { fg = cs.grey }, { 'SignColumn' })
hi('CursorLineNr', { fg = cs.black }, { 'FoldColumn' })

tshi('Boolean', { fg = cs.blue })
tshi('Constant', { fg = cs.blue })
tshi(
    'Comment',
    { fg = cs.dark_grey },
    { '@keyword.directive', '@string.documentation' }
)
hi('Directory', { fg = cs.blue })
hi('Error', { fg = cs.red })
hi('ErrorMsg', { fg = cs.red, bold = true, underline = true })
hi('MatchParen', { reverse = true })
hi('NormalFloat', { bg = cs.bg }, {
    'LspInfoBorder',
    'FloatBorder',
    'FloatShadow',
    'FloatShadowThrough',
})
hi('Pmenu', { fg = cs.black, bg = cs.white })
hi('PmenuSel', { fg = cs.black, bg = cs.light_grey }, { 'PmenuSbar' })
hi('PmenuThumb', { bg = cs.grey })
hi('Statement', { fg = cs.red })

tshi('Function', { fg = cs.purple }, { '@function.macro' })
tshi('Include', { fg = cs.red }, { '@keyword.directive.define' })
tshi('Keyword', { fg = cs.red })
tshi('Number', { fg = cs.blue })
tshi('Operator', { fg = cs.blue })
tshi('PreProc', { none = true })
tshi('String', { fg = cs.dark_blue }, { '@string.escape' })
tshi('Variable', { fg = cs.black })
hi('@punctuation.delimiter', { fg = cs.black })

tshi('Type', { fg = cs.black }, { '@type.builtin' })
hi('@type.qualifier', { fg = cs.red })

hi('@text.danger', { fg = cs.red, bold = true, italic = true, reverse = true })
hi(
    '@text.todo',
    { fg = cs.blue, bold = true, italic = true, reverse = true },
    { 'Todo' }
)

hi('jsonKeyword', { fg = cs.green })

hi('LspSignatureActiveParameter', { underline = true, italic = true })
hi(
    'DiagnosticError',
    { fg = cs.red },
    { 'DiagnosticFloatingError', 'DiagnosticSignError' }
)
hi(
    'DiagnosticWarn',
    { fg = cs.orange },
    { 'DiagnosticFloatingWarn', 'DiagnosticSignWarn' }
)
hi(
    'DiagnosticHint',
    { fg = cs.purple },
    { 'DiagnosticFloatingHint', 'DiagnosticSignHint' }
)
hi(
    'DiagnosticOk',
    { fg = cs.green },
    { 'DiagnosticFloatingOk', 'DiagnosticSignOk' }
)
hi(
    'DiagnosticInfo',
    { fg = cs.cyan },
    { 'DiagnosticFloatingInfo', 'DiagnosticSignInfo' }
)
hi('DiagnosticUnderlineError', {
    undercurl = true,
    special = cs.red,
})
hi('DiagnosticUnderlineWarn', {
    undercurl = true,
    special = cs.orange,
})
hi('DiagnosticUnderlineHint', {
    undercurl = true,
    special = cs.purple,
})
hi('DiagnosticUnderlineOk', {
    undercurl = true,
    special = cs.green,
})
hi('DiagnosticUnderlineInfo', {
    undercurl = true,
    special = cs.cyan,
})

-- null-ls
link('NormalFloat', 'NullLsInfoBorder')

-- oil.nvim
link('Directory', 'OilDir')
