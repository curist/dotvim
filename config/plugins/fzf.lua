local fzf = require 'fzf-lua'
local function nn(...) vim.keymap.set('n', ...) end
local function vn(...) vim.keymap.set('v', ...) end

fzf.register_ui_select()

fzf.setup {
  winopts = {
    height = 0.45,
    width = 0.75,
    row = 0.99,
    border = 'single',
    preview = {
      hidden = 'hidden',
      vertical = 'up:45%'
    },
  },
  files = {
    file_icons = false,
  },
  fzf_opts = {
    ['--layout'] = 'default',
  },
}

--- simple wrap function, aka bind
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


nn('<leader>f', fzf.files)
nn('<leader>F', w(fzf.files, {cmd='rg --files --hidden --no-ignore-vcs'}))
nn('<leader>b', fzf.buffers)
nn('<leader>m', w(require('dot.scripts').cwd_oldfiles, { prompt = 'LHist> ' }))
nn('<leader>M', w(fzf.oldfiles, { prompt = 'Hist> ' }))
nn('<leader>c', fzf.commands)
nn('<leader>/', fzf.search_history)
nn('<leader>:', fzf.command_history)
nn('<leader>Q', fzf.quickfix)
nn('<leader>gl', fzf.git_bcommits)
nn('<leader>gL', fzf.git_commits)
nn('<leader>L', fzf.builtin)

local rg_grep_all = 'rg --column --line-number --no-heading --color=always --smart-case --hidden --no-ignore-vcs'
nn('<leader>s', fzf.grep_cword)
vn('<leader>s', fzf.grep_visual)
nn('<leader>S', fzf.grep_project)
nn('<leader>z', w(fzf.grep_cword, { cmd = rg_grep_all }))
vn('<leader>z', w(fzf.grep_visual, { cmd = rg_grep_all }))
nn('<leader>Z', w(fzf.grep_project, { cmd = rg_grep_all }))
nn('<leader>x', function() fzf.blines({ search = "'"..vim.fn.expand("<cword>").." " }) end)
nn('<leader>X', fzf.blines)

nn('<leader>p', cw(function ()
  local dir = '~/workspace'
  local selected = fzf.fzf({
    prompt = dir .. ' ',
    fzf_opts = {
      ['--no-multi'] = '',
    },
  }, ('ls %s'):format(dir))
  if not selected then return end
  local path = dir .. '/' .. selected[1]
  vim.api.nvim_set_current_dir(path)
  vim.fn.execute('Vaffle')
end))

nn('<leader>H', cw(function()
  -- hacker news top stories
  local cmd = vim.fn.join({
    [[curl -s "https://hacker-news.firebaseio.com/v0/topstories.json"]],
    [[jq '.[]']],
    [[head -20]],
    [[xargs -P 8 -I{} sh -c "curl -s https://hacker-news.firebaseio.com/v0/item/{}.json | jq -r '\"\(.id). \(.score)\t\(.title) (cmts: \(.descendants))\"'"]]
  }, ' | ')

  local selected = fzf.fzf({
    prompt = 'Hackernews> ',
    fzf_opts = {
      ['--with-nth'] = '2..',
    },
  }, cmd)
  if not selected then return end
  require('dot.utils').each(selected, function(item)
    local id = tonumber(item:match('%d+'))
    local url = 'https://news.ycombinator.com/item?id=' .. id
    vim.api.nvim_exec('!open "' .. url .. '"', {})
  end)
end))

