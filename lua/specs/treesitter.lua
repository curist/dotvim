return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'BufRead',
  },
  {
    'nvim-treesitter/nvim-treesitter',
    depedencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'moonbit-community/moonbit.nvim',
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
        'html',
        'lua',
        'jsdoc',
        'json',
        'lx',
        'koka',
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'fennel' },
      },
      indent = { enable = true },
      matchup = {
        enable = true,
        disable_virtual_text = true,
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

      require('nvim-treesitter.parsers').get_parser_configs()['koka'] = {
        filetype = 'koka',
        install_info = {
          url = 'https://github.com/mtoohey31/tree-sitter-koka',
          files = { 'src/parser.c', 'src/scanner.c' },
          branch = 'main',
        },
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
        'gh',
        function()
          require('dot.ts').swap_nodes_at_cursor('prev')
        end,
        desc = 'Swap current node with previous node',
      },
      {
        'gl',
        function()
          require('dot.ts').swap_nodes_at_cursor('next')
        end,
        desc = 'Swap current node with next node',
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
