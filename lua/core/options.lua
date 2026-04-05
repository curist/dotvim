vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.g.omni_sql_no_default_maps = 1

vim.cmd('hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white')

local opt = vim.opt

opt.fileencoding = 'utf-8'
opt.tabstop = 4
opt.shiftwidth = 2
opt.expandtab = true
opt.showmode = false
opt.ruler = false
opt.cmdheight = 0
opt.laststatus = 3
opt.shada = "'900"
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000

opt.mouse = 'vn'
opt.wrap = false
opt.foldmethod = 'indent'
opt.foldlevelstart = 9
opt.foldnestmax = 9
opt.hidden = true

opt.title = true
opt.clipboard:prepend({ 'unnamed', 'unnamedplus' })

opt.wildmode = { 'list:longest', 'full' }
opt.completeopt = { 'menuone', 'noselect' }

opt.list = true
opt.listchars = {
  tab = '▸ ',
  trail = '·',
  precedes = '←',
  extends = '→',
  nbsp = '×',
}
opt.fillchars = { eob = ' ' }
opt.showbreak = '↪ '

opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'nosplit'

opt.backup = false
opt.swapfile = false

opt.shortmess:append({ I = true, c = true })
opt.synmaxcol = 150

opt.updatetime = 350
opt.timeoutlen = 400

opt.splitright = true
