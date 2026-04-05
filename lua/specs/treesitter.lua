local dot_cfg = require('dot.config')

local parsers_to_install = {
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
}

local function register_custom_parsers()
  local parsers = require('nvim-treesitter.parsers')

  parsers.lx = {
    filetype = 'lx',
    install_info = {
      url = 'https://github.com/curist/tree-sitter-lx',
      files = { 'src/parser.c' },
      branch = 'main',
    },
  }

  parsers.twinkle = {
    filetype = 'twinkle',
    install_info = {
      path = dot_cfg.paths.twinkle_parser,
    },
  }
end

return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = 'BufRead',
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = {
          lookahead = false,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
          },
          selection_modes = {
            ['@function.outer'] = 'V',
          },
        },
      })
    end,
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
    branch = 'main',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'curist/tree-sitter-lx',
    },
    lazy = false,
    build = ':TSUpdate',
    cmd = { 'TSInstall' },
    init = function()
      register_custom_parsers()

      vim.api.nvim_create_autocmd('User', {
        pattern = 'TSUpdate',
        callback = register_custom_parsers,
      })
    end,
    config = function()
      local ts = require('nvim-treesitter')

      ts.setup({})

      local filetypes = {}
      for _, parser in ipairs(parsers_to_install) do
        for _, ft in ipairs(vim.treesitter.language.get_filetypes(parser)) do
          filetypes[ft] = true
        end
      end
      filetypes.lx = true
      filetypes.twinkle = true

      vim.api.nvim_create_autocmd('FileType', {
        pattern = vim.tbl_keys(filetypes),
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          if ft ~= 'markdown' then
            pcall(vim.treesitter.start, args.buf)
          end
          if ft ~= 'fennel' and ft ~= 'markdown' then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
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
