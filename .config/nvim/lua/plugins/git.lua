return {

  "lewis6991/gitsigns.nvim",
  config = function()
    local gitsigns = require("gitsigns")

    vim.keymap.set(
      "n",
      "<leader>gb",
      gitsigns.toggle_current_line_blame,
      { desc = "[G]it [b]lame" }
    )
    vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Git [P]review hunk" })
  end,
}
