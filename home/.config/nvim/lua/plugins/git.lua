return {
  { "lewis6991/gitsigns.nvim", opts = {} },
  {
    "georgeguimaraes/review.nvim",
    dependencies = {
      "esmuellert/codediff.nvim",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Review" },
    keys = {
      { "<leader>rr", "<cmd>Review<cr>", desc = "Review" },
      { "<leader>rc", "<cmd>Review clear<cr>", desc = "Review clear" },
    },
    opts = {},
  },
}
