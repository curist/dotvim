local fzf = require 'fzf-lua'
local scripts = require 'dot.scripts'

local function nn(...) vim.keymap.set('n', ...) end
local function vn(...) vim.keymap.set('v', ...) end

fzf.setup {
  winopts = {
    height = 0.45,
    row = 0.99,
    border = 'single',
    preview = {
      hidden = 'hidden',
      vertical = 'up:45%'
    },
  },
  winopts_fn = function()
    return { width = vim.o.columns > 150 and 0.6 or 0.75 }
  end,
  files = {
    multiprocess = false,
    file_icons = false,
  },
  grep = {
    multiprocess = false,
    file_icons = false,
    git_icons = false,
  },
}

fzf.register_ui_select()

-- coroutine wrap fn, to get 1 less indent level
local function w(fn, opts)
  opts = opts or {}
  return function()
    coroutine.wrap(fn)(opts)
  end
end

nn('<leader>f', fzf.files)
nn('<leader>F', w(fzf.files, {cmd='rg --files --hidden --no-ignore-vcs'}))
nn('<leader>b', fzf.buffers)
nn('<leader>m', w(scripts.cwd_oldfiles, { prompt = 'LHist> ', fzf_opts = {['--no-sort']=''} }))
nn('<leader>M', w(fzf.oldfiles, { prompt = 'Hist> ', fzf_opts = {['--no-sort']=''} }))
nn('<leader>c', fzf.commands)
nn('<leader>/', fzf.search_history)
nn('<leader>:', fzf.command_history)
nn('<leader>Q', w(fzf.quickfix, {}))
nn('<leader>gl', fzf.git_bcommits)
nn('<leader>gL', fzf.git_commits)
nn('<leader>L', fzf.builtin)
nn('<leader>R', fzf.resume)

local rg_grep_all = 'rg --column --line-number --no-heading --color=always --smart-case --hidden --no-ignore-vcs'
nn('<leader>s', fzf.grep_cword)
vn('<leader>s', fzf.grep_visual)
nn('<leader>S', fzf.live_grep)
nn('<leader>z', w(fzf.grep_cword, { cmd = rg_grep_all }))
vn('<leader>z', w(fzf.grep_visual, { cmd = rg_grep_all }))
nn('<leader>Z', w(fzf.live_grep, { cmd = rg_grep_all }))
nn('<leader>x', function() scripts.grep_curbuf({ search = vim.fn.expand("<cword>") }) end)
nn('<leader>X', scripts.grep_curbuf)
nn('<leader>H', fzf.help_tags)

nn('<leader>p', w(function ()
  local dir = '~/playground'
  local selected = fzf.fzf('ls -d */*/', {
    prompt = dir .. ' ',
    cwd = dir,
    fzf_opts = {
      ['--no-multi'] = '',
    },
  })
  if not selected then return end
  local path = dir .. '/' .. selected[1]
  vim.api.nvim_set_current_dir(path)
  vim.fn.execute('Vaffle')
end))

