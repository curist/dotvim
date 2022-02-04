local fzf = require 'fzf-lua'
local json = require 'lib.json'
local exec = require 'lib.exec'
local split = require 'lib.coro-split'
local dot = require 'dot.utils'

local function nn(...) vim.keymap.set('n', ...) end
local function vn(...) vim.keymap.set('v', ...) end

fzf.register_ui_select()

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
    preview = vim.fn.shellescape('cd ~/workspace/{} && git st && echo && git log -1'),
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
  local curl = dot.pipe({
    dot.bind(exec, 'curl'),
    json.decode,
  })

  local selected = fzf.fzf({
    prompt = 'Hackernews> ',
    fzf_opts = {
      ['--with-nth'] = '2..',
    },
  }, function(cb)
    local top_story_ids = curl 'https://hacker-news.firebaseio.com/v0/topstories.json'
    local top_20_ids = dot.head(top_story_ids, 20)

    local tasks = dot.mapf(top_20_ids, function(id)
      local info = curl('https://hacker-news.firebaseio.com/v0/item/' .. id .. '.json')
      return ('%d. %d\t%s (cmts: %d)'):format(info.id, info.score, info.title, info.descendants or 0)
    end)
    local results = split(tasks)
    for _, result in ipairs(results) do
      cb(result)
    end
    cb(nil)

  end)
  if not selected then return end
  require('dot.utils').each(selected, function(item)
    local id = tonumber(item:match('%d+'))
    local url = 'https://news.ycombinator.com/item?id=' .. id
    vim.fn.execute(('!open "%s"'):format(url))
  end)
end))

