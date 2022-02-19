local fzf = require 'fzf-lua'
local json = require 'lib.json'
local exec = require 'lib.exec'
local split = require 'lib.coro-split'
local dot = require 'dot.utils'
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

--- simple wrap function, aka bind
local w = dot.bind

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

local rg_grep_all = 'rg --column --line-number --no-heading --color=always --smart-case --hidden --no-ignore-vcs'
nn('<leader>s', fzf.grep_cword)
vn('<leader>s', fzf.grep_visual)
nn('<leader>S', fzf.grep_project)
nn('<leader>z', w(fzf.grep_cword, { cmd = rg_grep_all }))
vn('<leader>z', w(fzf.grep_visual, { cmd = rg_grep_all }))
nn('<leader>Z', w(fzf.grep_project, { cmd = rg_grep_all }))
nn('<leader>x', function() scripts.grep_curbuf({ search = vim.fn.expand("<cword>") }) end)
nn('<leader>X', scripts.grep_curbuf)

nn('<leader>p', w(function ()
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

nn('<leader>H', w(function()
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
  dot.each(selected, function(item)
    local id = tonumber(item:match('%d+'))
    local url = 'https://news.ycombinator.com/item?id=' .. id
    vim.fn.execute(('!open "%s"'):format(url))
  end)
end))

vim.ui.select = function(items, opts, on_choice)
  opts = opts or {}
  opts.prompt = opts.prompt or 'Select one of:'
  if opts.format_item then
    local format_item = opts.format_item
    opts.format_item = function(item)
      return tostring(format_item(item))
    end
  else
    opts.format_item = tostring
  end

  local labels = {}
  for i, item in ipairs(items) do
    table.insert(labels, string.format('%d: %s', i, opts.format_item(item)))
  end

  local fzf_opts = {
    fzf_opts = {
      ['--no-multi'] = '',
      ['--preview-window'] = 'hidden:right:0',
      ['--header'] = vim.fn.shellescape(opts.prompt),
    },
  }
  fzf.fzf_wrap(fzf_opts, labels, function(selected)
    if not selected then
      on_choice(nil, nil)
    else
      local label = selected[1]
      local colon = string.find(label, ':')
      local lnum = tonumber(string.sub(label, 1, colon - 1))
      local item = items[lnum]
      on_choice(item, lnum)
    end
  end)()
end

