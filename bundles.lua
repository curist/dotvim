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
  Plug 'cohama/lexima.vim'
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

  -- tree-sitter & programming languages
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
  Plug('curist/tree-sitter-lx', { ft = 'lx', rtp = 'vim', run = ':TSInstall! lx' })
  Plug('moonbit-community/moonbit.nvim', {
    ft = 'moonbit',
    config = function()
      require'moonbit'.setup({
        treesitter = { enabled = true },
      })
    end,
  })


  -- neotest
  Plug 'nvim-lua/plenary.nvim'
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
  Plug('lewis6991/gitsigns.nvim')

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

  -- things
  Plug 'mrjones2014/smart-splits.nvim' -- wezterm integration
  Plug 'williamboman/mason.nvim' -- LSP & stuff installer

  -- cmp
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
  Plug('hrsh7th/nvim-cmp', {
    config = function()
      local cmp = require'cmp'
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<c-u>'] = cmp.mapping.scroll_docs(-4),
          ['<c-d>'] = cmp.mapping.scroll_docs(4),
          ['<c-e>'] = cmp.mapping.abort(),
          ['<cr>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'buffer' },
        })
      })
    end,
  })
end)
