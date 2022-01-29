local fzf = require 'fzf-lua'
local nn = require('mapx').nnoremap
local vn = require('mapx').vnoremap

fzf.setup {
  winopts = {
    height = 0.45,
    width = 0.8,
    row = 0.99,
    preview = {
      hidden = 'hidden',
    },
  },
  fzf_opts = {
    ['--ansi'] = '',
  },
}

--- simple wrap function to avoid mapx giving extra opts to fzf functions
local function w(fn, opts)
  opts = opts or {}
  return function()
    return fn(opts)
  end
end

-- coroutine wrap fn, to get 1 less indent level
local function cw(fn, opts)
  opts = opts or {}
  return function()
    coroutine.wrap(fn)(opts)
  end
end


nn('<leader>f', w(fzf.files))
nn('<leader>F', w(fzf.files, {cmd='rg --files --hidden --no-ignore-vcs'}))
nn('<leader>b', w(fzf.buffers))
nn('<leader>m', w(require('dot.scripts').cwd_oldfiles, { prompt = 'LHist> ' }))
nn('<leader>M', w(fzf.oldfiles, { prompt = 'Hist> ' }))
nn('<leader>c', w(fzf.commands))
nn('<leader>/', w(fzf.search_history))
nn('<leader>:', w(fzf.command_history))
nn('<leader>Q', w(fzf.quickfix))
nn('<leader>gl', w(fzf.git_bcommits))
nn('<leader>gL', w(fzf.git_commits))

local rg_grep_all = 'rg --column --line-number --no-heading --color=always --smart-case --hidden --no-ignore-vcs'
nn('<leader>s', w(fzf.grep_cword))
vn('<leader>s', w(fzf.grep_visual))
nn('<leader>S', w(fzf.live_grep))
nn('<leader>z', w(fzf.grep_cword, { cmd = rg_grep_all }))
vn('<leader>z', w(fzf.grep_visual, { cmd = rg_grep_all }))
nn('<leader>Z', w(fzf.live_grep, { cmd = rg_grep_all }))
nn('<leader>x', w(fzf.blines))

nn('<leader>p', cw(function ()
  local base = '~/workspace'
  local projects = require('dot.scripts').dirs(base)
  local selected = fzf.fzf({
    prompt = base .. ' ',
  }, projects)
  if not selected then return end
  local path = base .. '/' .. selected[1]
  vim.api.nvim_set_current_dir(path)
  vim.fn.execute('Vaffle')
end))

