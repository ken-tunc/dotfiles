return {
  "sainnhe/sonokai",
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    vim.g.sonokai_transparent_background = 1
    vim.cmd.colorscheme("sonokai")
  end,
}
