vim.opt.spell = false

local utils = require 'utils'

utils.bmap { 'n', 'q', utils.mapstr 'BufDel' }
