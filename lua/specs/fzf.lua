local scripts = require('dot.scripts')
local w = require('dot.utils').bind

local function nn(...)
  vim.keymap.set('n', ...)
end
local function vn(...)
  vim.keymap.set('v', ...)
end

return {
  'ibhagwan/fzf-lua',
  config = function()
    local fzf = require('fzf-lua')
    local config = require('fzf-lua.config')
    config.defaults.keymap.fzf['ctrl-u'] = 'half-page-up'
    config.defaults.keymap.fzf['ctrl-d'] = 'half-page-down'
    config.defaults.keymap.fzf['ctrl-x'] = 'jump'

    fzf.register_ui_select()

    fzf.setup({
      winopts = function()
        return {
          height = 0.60,
          width = vim.o.columns > 150 and 0.6 or 0.75,
          row = 0.99,
          border = 'single',
          preview = {
            hidden = 'hidden',
            vertical = 'up:0%',
          },
        }
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
      colorschemes = {
        winopts = {
          height = 20,
          width = 32,
          row = 0,
          col = 0.99,
        },
      },
    })

    nn('<leader> ', fzf.files, { desc = 'Find file' })
    nn('<leader>F', w(fzf.files, { cmd = 'rg --files --hidden --no-ignore-vcs' }), { desc = 'Find file' })
    nn('<leader>,', w(fzf.buffers, { no_term_buffers = true }), { desc = 'Buffer list' })
    nn(
      '<leader>m',
      w(scripts.cwd_oldfiles, { prompt = 'LHist> ', fzf_opts = { ['--no-sort'] = '' } }),
      { desc = 'Most recent files (cwd)' }
    )
    nn(
      '<leader>M',
      w(fzf.oldfiles, { prompt = 'Hist> ', fzf_opts = { ['--no-sort'] = '' } }),
      { desc = 'Most recent files (global)' }
    )
    nn('<leader>c', function()
      require('fzf-lua').commands({
        include_builtin = false,
        actions = {
          ['default'] = function(selected)
            ---@diagnostic disable-next-line
            if not pcall(vim.cmd, selected[1]) then
              vim.api.nvim_input(':' .. selected[1] .. ' ')
            end
          end,
        },
      })
    end, { desc = 'Commands' })
    nn('<leader>/', fzf.search_history, { desc = 'Search history' })
    nn('<leader>:', fzf.command_history, { desc = 'Command history' })
    nn('<leader>Q', w(fzf.quickfix, {}), { desc = 'Quickfix picker' })
    nn('<leader>gl', fzf.git_bcommits, { desc = 'Buffer git commits' })
    nn('<leader>gL', fzf.git_commits, { desc = 'Git commits' })
    nn('<leader>L', fzf.builtin, { desc = 'Fzf pickers' })
    nn('<leader>R', fzf.resume, { desc = 'Resume fzf picker' })

    local rg_grep_all = 'rg --column --line-number --no-heading --color=always --smart-case --hidden --no-ignore-vcs'
    nn('<leader>s', fzf.grep_cword, { desc = 'Search word under cursor' })
    vn('<leader>s', fzf.grep_visual, { desc = 'Search selected word' })
    nn('<leader>S', fzf.live_grep, { desc = 'Live grep search' })
    nn('<leader>z', w(fzf.grep_cword, { cmd = rg_grep_all }), { desc = 'Search word under cursor (all files)' })
    vn('<leader>z', w(fzf.grep_visual, { cmd = rg_grep_all }), { desc = 'Search selected word (all files)' })
    nn('<leader>Z', w(fzf.live_grep, { cmd = rg_grep_all }), { desc = 'Live grep search (all files)' })
    nn('<leader>x', function()
      fzf.grep_curbuf({ search = vim.fn.expand('<cword>') })
    end, { desc = 'Search word in buffer' })
    vn('<leader>x', function()
      local utils = require('fzf-lua.utils')
      fzf.grep_curbuf({ search = utils.get_visual_selection() })
    end, { desc = 'Search selected word in buffer' })
    nn('<leader>X', fzf.grep_curbuf, { desc = 'Live grep buffer' })
    nn('<leader>H', fzf.help_tags, { desc = 'Help pages' })

    nn('<leader>p', scripts.recent_projects, { desc = 'Projects' })
  end,
}
