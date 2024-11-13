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
  Plug('nvim-treesitter/nvim-treesitter', {
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "+",
            node_incremental = "+",
            node_decremental = "-",
            scope_incremental = false,
          },
        },
      })
    end,
  })
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
  Plug('lewis6991/gitsigns.nvim', {
    config = function()
      require('gitsigns').setup({})
    end,
  })

  -- get fancy
  Plug 'itchyny/lightline.vim'
  Plug('catppuccin/nvim', {
    as = 'catppuccin',
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha',
        no_italic = true,
        no_bold = true,
        custom_highlights = function(colors)
          return {
            WinSeparator = { fg = colors.overlay0 },
          }
        end
      })
      vim.cmd.colorscheme 'catppuccin'
    end
  })
  Plug 'nvim-tree/nvim-web-devicons'

  -- wezterm
  Plug 'mrjones2014/smart-splits.nvim'

  -- things
  Plug 'williamboman/mason.nvim'
  Plug('moonbit-community/moonbit.nvim', {
    config = function()
      require'moonbit'.setup({
        treesitter = { enabled = true },
      })
    end,
  })

end)
