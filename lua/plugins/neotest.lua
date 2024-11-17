return {
  'nvim-neotest/nvim-nio',
  'nvim-lua/plenary.nvim',
  {
    "nvim-neotest/neotest",
    ft = { "moonbit" },
    depedencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'moonbit-community/moonbit.nvim',
    },
    keys = function()
      local neotest = require'neotest'
      return {
        { "<leader>tt", function() neotest.run.run(vim.fn.expand("%")) end, desc = "Run File" },
        { "<leader>tT", function() neotest.run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },
        { "<leader>tr", function() neotest.run.run() end, desc = "Run Nearest" },
        { "<leader>tl", function() neotest.run.run_last() end, desc = "Run Last" },
        { "<leader>ts", function() neotest.summary.toggle() end, desc = "Toggle Summary" },
        { "<leader>to", function() neotest.output.open({ enter = true, last_run = true }) end, desc = "Show last test output" },
        { "<leader>tO", function() neotest.output_panel.toggle() end, desc = "Toggle output panel" },
      }
    end,
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require("neotest-moonbit"))
    end,
  }
}
