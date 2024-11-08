(function(setup_plugins)
  vim.call('plug#begin', '~/.config/nvim/plugged')
  setup_plugins(function (name, args)
    args = args or { x = 1 }
    -- workaround lua `do` & `for` keyword
    args['do'] = args.run
    args['for'] = args.ft
    vim.call('plug#', name, args)
    if args.config and type(args.config) == 'function' then
      vim.schedule(args.config)
    end
  end)
  vim.call('plug#end')
end)(function(Plug)
  -- text manipulating helpers
  Plug 'tpope/vim-surround'
  Plug('tomtom/tcomment_vim', { on = 'TComment' })
  Plug 'cohama/lexima.vim'
  Plug 'curist/highlight.vim'
  Plug 'tpope/vim-repeat'

  -- moving around:
  --   file/buffer switching
  --   in file quick jumps
  Plug('stevearc/oil.nvim', { config = function() require'oil'.setup() end })
  Plug 'ibhagwan/fzf-lua'
  Plug 'phaazon/hop.nvim'
  Plug('andymass/vim-matchup', {
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
    end,
  })

  -- tree-sitter
  Plug('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  Plug('curist/tree-sitter-lx', { rtp = 'vim', run = ':TSInstall! lx' })

  -- neotest
  Plug 'nvim-lua/plenary.nvim'
  Plug 'antoinemadec/FixCursorHold.nvim'
  Plug 'nvim-neotest/nvim-nio'
  Plug('nvim-neotest/neotest', {
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-moonbit"),
        },
      })
    end
  })

  -- git
  Plug 'tpope/vim-fugitive'

  -- mason
  Plug 'williamboman/mason.nvim'
  Plug('moonbit-community/moonbit.nvim', {
    config = function()
      require'moonbit'.setup({
        treesitter = { enabled = true },
      })
    end
  })

  -- get fancy
  Plug 'itchyny/lightline.vim'
  Plug 'curist/bogster'
  -- Plug("catppuccin/vim", { as= 'catppuccin' })

  Plug 'nvim-tree/nvim-web-devicons'

  -- wezterm
  Plug 'mrjones2014/smart-splits.nvim'
end)
