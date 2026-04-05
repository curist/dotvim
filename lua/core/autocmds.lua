local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local dot_qf = require('dot.qf')

local visual_count_ns = vim.api.nvim_create_namespace('VisualCountVirtualText')

local function get_visual_corners()
  local curpos = vim.fn.getcurpos()
  return {
    { row = curpos[2] - 1, col = curpos[3] - 1 },
    { row = vim.fn.line('v') - 1, col = vim.fn.col('v') - 1 },
  }
end

local function show_visual_count()
  local pos = get_visual_corners()
  local mode = vim.fn.mode()
  local message = ''

  vim.api.nvim_buf_clear_namespace(0, visual_count_ns, 0, -1)

  if mode == 'v' then
    message = string.format(' %d', vim.fn.wordcount().visual_chars)
  elseif mode == 'V' then
    message = string.format(' %d', math.abs(pos[1].row - pos[2].row) + 1)
  elseif mode == '\22' then
    message = string.format(' %d x %d', math.abs(pos[1].row - pos[2].row) + 1, math.abs(pos[1].col - pos[2].col) + 1)
  end

  vim.api.nvim_buf_set_extmark(0, visual_count_ns, pos[1].row, 0, {
    virt_text = { { message, 'Comment' } },
    virt_text_pos = 'eol',
    hl_mode = 'combine',
  })
end

local function install_enter_highlight_maps(bufnr)
  if vim.fn.mapcheck('<cr>', 'n') == '' then
    vim.keymap.set('n', '<CR>', function()
      if not vim.bo[bufnr].modifiable then
        return '<cr>'
      end

      local cword = vim.fn.expand('<cword>')
      if #cword > 0 then
        vim.fn.setreg('/', '\\<' .. cword .. '\\>')
      end
      return '<cmd>silent set hlsearch<cr>'
    end, { buffer = bufnr, silent = true, expr = true })
  end

  if vim.fn.mapcheck('<cr>', 'x') == '' then
    vim.keymap.set('x', '<CR>', [["cy<cmd>let @/=substitute(@c, '\n', '\\n', 'g')<cr><cmd>set hls<cr>]], {
      buffer = bufnr,
      silent = true,
    })
  end
end

autocmd('BufWinEnter', {
  group = augroup('QFixToggle', { clear = true }),
  pattern = 'quickfix',
  callback = function()
    dot_qf.set_list()
  end,
})

autocmd('VimResized', {
  group = augroup('BehaviourAdjustment', { clear = true }),
  pattern = '*',
  command = 'wincmd =',
})

autocmd('BufRead', {
  group = 'BehaviourAdjustment',
  pattern = 'quickfix',
  command = 'setlocal nobuflisted number nornu',
})

autocmd('BufRead', {
  group = 'BehaviourAdjustment',
  pattern = 'location',
  command = 'setlocal nobuflisted number nornu',
})

autocmd('FileType', {
  group = 'BehaviourAdjustment',
  pattern = 'qf',
  command = '10wincmd _',
})

autocmd('TextYankPost', {
  group = augroup('highlight_yank', { clear = true }),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.o.titlestring = vim.fn.getcwd()
autocmd('DirChanged', {
  group = augroup('dirchange', { clear = true }),
  pattern = '*',
  callback = function()
    vim.o.titlestring = vim.fn.fnamemodify(vim.v.event.cwd, ':~')
  end,
})

autocmd('VimEnter', {
  group = augroup('python_venv', { clear = true }),
  pattern = '*',
  callback = function()
    vim.defer_fn(require('dot.pyvenv').activate, 10)
  end,
})

autocmd('DirChanged', {
  group = 'python_venv',
  pattern = '*',
  callback = function()
    require('dot.pyvenv').activate()
  end,
})

autocmd({ 'ModeChanged', 'CursorMoved' }, {
  group = augroup('visual_selection_count', { clear = true }),
  pattern = '*',
  callback = function()
    local mode = vim.fn.mode()
    if mode == 'v' or mode == 'V' or mode == '\22' then
      show_visual_count()
    else
      vim.api.nvim_buf_clear_namespace(0, visual_count_ns, 0, -1)
    end
  end,
})

autocmd('BufEnter', {
  group = augroup('enter_highlight', { clear = true }),
  pattern = '*',
  callback = function(args)
    install_enter_highlight_maps(args.buf)
  end,
})

