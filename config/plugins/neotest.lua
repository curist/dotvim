local keymaps = {
  { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
  { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },
  { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
  { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
  { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
}

for _, keymap in ipairs(keymaps) do
  vim.keymap.set("n", unpack(keymap))
end
