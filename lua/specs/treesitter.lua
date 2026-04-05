return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'BufRead',
  },
  {
    'mizlan/iswap.nvim',
    event = 'VeryLazy',
    opts = {
      flash_style = false,
      move_cursor = true,
    },
    keys = {
      {
        'gh',
        ':ISwapWithLeft<cr>',
        desc = 'Swap current node with previous node',
      },
      {
        'gl',
        ':ISwapWithRight<cr>',
        desc = 'Swap current node with next node',
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'curist/tree-sitter-lx',
    },
    build = ':TSUpdate',
    event = { 'BufRead' },
    cmd = { 'TSInstall' },
    opts = {
      ensure_installed = {
        'c',
        'css',
        'go',
        'javascript',
        'typescript',
        'clojure',
        'fennel',
        'hcl',
        'html',
        'lua',
        'jsdoc',
        'json',
        'python',
        'lx',
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'clojure' },
      },
      indent = {
        enable = true,
        disable = { 'fennel' },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '+',
          node_incremental = '+',
          node_decremental = '-',
          scope_incremental = false,
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = false,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
          },
          selection_modes = {
            ['@function.outer'] = 'V',
          },
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.parsers').get_parser_configs()['lx'] = {
        filetype = 'lx',
        install_info = {
          url = 'https://github.com/curist/tree-sitter-lx',
          files = { 'src/parser.c' },
          branch = 'main',
        },
      }

      require('nvim-treesitter.parsers').get_parser_configs()['twinkle'] = {
        install_info = {
          url = '/Users/curist/playground/rust/twinkle/tree-sitter-twinkle',
          files = { 'src/parser.c' },
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = 'twinkle',
      }

      require('nvim-treesitter.configs').setup(opts)
    end,
    keys = {
      {
        'gs',
        function()
          require('dot.ts').print_node_at_cursor()
        end,
        desc = 'Print treesitter node under cursor',
      },
      {
        'gt',
        function()
          require('dot.ts').goto_top_node_at_cursor()
        end,
        desc = 'Goto top node',
      },
      {
        '<c-j>',
        function()
          require('dot.ts').goto_next_top_node()
        end,
        desc = 'Goto next top node',
      },
      {
        '<c-k>',
        function()
          require('dot.ts').goto_prev_top_node()
        end,
        desc = 'Goto previous top node',
      },
      {
        '-',
        function()
          require('dot.ts').goto_parent_node()
        end,
        desc = 'Goto parent node',
      },
    },
  },
}
