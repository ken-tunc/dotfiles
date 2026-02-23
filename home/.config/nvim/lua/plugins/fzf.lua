return {
  "junegunn/fzf.vim",
  dependencies = { { "junegunn/fzf", dir = vim.fn.expand("/opt/homebrew/opt/fzf") } },
  keys = {
    { "<leader>fb", "<cmd>Buffers<cr>", desc = "Buffers" },
    { "<leader>fc", "<cmd>Commands<cr>", desc = "Commands" },
    { "<leader>ff", "<cmd>Files<cr>", desc = "Files" },
    { "<leader>fg", "<cmd>GFiles?<cr>", desc = "GFiles?" },
    { "<leader>fm", "<cmd>Maps<cr>", desc = "Maps" },
    { "<leader>fw", "<cmd>Windows<cr>", desc = "Windows" },
  },
}
