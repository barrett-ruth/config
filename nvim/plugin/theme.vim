colo gruvbox-material

sign define DiagnosticSignError text=> texthl=RedSign
sign define DiagnosticSignWarn text=- texthl=YellowSign
sign define DiagnosticSignHint text=* texthl=AquaSign
sign define DiagnosticSignInfo text=: texthl=BlueSign

let nostr = 'ctermbg=NONE guibg=NONE gui=NONE'

hi! link Conceal Operator
hi! FloatBorder guibg=NONE
hi! TelescopeSelection guibg=#45403d
hi! MatchWord cterm=NONE gui=NONE
hi! MatchWordCur cterm=NONE gui=NONE

for e in [ 'SignColumn', 'FoldColumn' ]
    exe 'hi!' e nostr
endfo

for e in [ 'Normal', 'Error', 'Warning', 'Hint', 'Info' ]
    exe 'hi' e .. 'Float' nostr
endfo

for e in [ 'Green', 'Red', 'Yellow', 'Blue', 'Aqua', 'Orange' ]
    exe 'hi!' e .. 'Sign' nostr
endfo
