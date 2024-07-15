return {
  { "tpope/vim-fugitive" },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
    config = function()
      local gitsigns = require("gitsigns")
      gitsigns.setup()

      vim.keymap.set(
        "n",
        "<leader>gb",
        gitsigns.toggle_current_line_blame,
        { desc = "[G]it [b]lame" }
      )
      vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Git [P]review hunk" })
    end,
  },
}
