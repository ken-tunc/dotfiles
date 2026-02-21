local opt = vim.opt

-- Encoding
opt.encoding = "utf-8"
opt.fileencodings = { "utf-8", "euc-jp", "sjis", "cp932", "iso-2022-jp" }
opt.fileformats = { "unix", "dos", "mac" }

-- Edit
opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 2
opt.softtabstop = 2

-- UI
opt.lazyredraw = true
opt.mouse = "a"
opt.number = true
opt.showcmd = true
opt.showmatch = true
opt.ruler = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true

-- Files
local cache_dir = vim.fn.expand("~/.cache/nvim")
opt.directory = cache_dir .. "/swap"
opt.backup = true
opt.backupdir = cache_dir .. "/backup"
opt.undofile = true
opt.undodir = cache_dir .. "/undo"
opt.shadafile = cache_dir .. "/shada"

for _, dir in ipairs({ opt.directory:get()[1], opt.backupdir:get()[1], opt.undodir:get()[1] }) do
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
end
