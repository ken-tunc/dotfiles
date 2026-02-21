require("options")
require("keymaps")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.g.sonokai_transparent_background = 1
      vim.cmd.colorscheme("sonokai")
    end,
  },
  {
    "junegunn/fzf.vim",
    dependencies = { { "junegunn/fzf", dir = vim.fn.expand("/opt/homebrew/opt/fzf") } },
    keys = {
      { "<leader>fb", "<cmd>Buffers<cr>", desc = "Buffers" },
      { "<leader>fc", "<cmd>Commands<cr>", desc = "Commands" },
      { "<leader>ff", "<cmd>Files<cr>", desc = "Files" },
      { "<leader>fg", "<cmd>GFiles?<cr>", desc = "GFiles?" },
      { "<leader>fw", "<cmd>Windows<cr>", desc = "Windows" },
    },
  },
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
      { "<leader>rc", "<cmd>Review commits<cr>", desc = "Review commits" },
    },
    opts = {},
  }
})
