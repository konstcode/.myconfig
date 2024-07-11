-- NOTE: tried to use vimux and custom strategy but still bugs
--
-- Define the custom vim-test strategy
-- local function new_vimux_strategy(cmd)
--   -- Escape single quotes in the command for proper shell execution
--   local command = vim.fn.escape(cmd, "'")
--
--   -- Construct the tmux command to open a new split and run the test command
--   local cmd_to_run =
--     string.format("silent !tmux split-window -h 'tmux send-keys \"%s\" Enter'", cmd)
--
--   -- Execute the constructed tmux command
--   vim.cmd(cmd_to_run)
-- end

-- Register the custom strategy with vim-test
--vim.g["test#custom_strategies"] = { new_vimux = new_vimux_strategy }
vim.g["test#strategy"] = "neovim_sticky"

return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux",
  },
  vim.keymap.set("n", "<leader>t", "<CMD>:TestNearest<CR>"),
  vim.keymap.set("n", "<leader>T", "<CMD>:TestFile<CR>"),
  vim.keymap.set("n", "<leader>ts", "<CMD>:TestSuite<CR>"),
  --vim.keymap.set("n", "<leader>l", "<CMD>:TestLast<CR>"),
  -- vim.keymap.set("n", "<leader>g", "<CMD>:TestVisit<CR>"),
}
