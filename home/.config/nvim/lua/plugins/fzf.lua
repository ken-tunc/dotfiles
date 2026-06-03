vim.opt.rtp:append("/opt/homebrew/opt/fzf")

vim.pack.add({ { src = "https://github.com/junegunn/fzf.vim" } })

local map = vim.keymap.set
map("n", "<leader>fb", "<cmd>Buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fc", "<cmd>Commands<cr>", { desc = "Commands" })
map("n", "<leader>ff", "<cmd>Files<cr>", { desc = "Files" })
map("n", "<leader>fg", "<cmd>GFiles?<cr>", { desc = "GFiles?" })
map("n", "<leader>fm", "<cmd>Maps<cr>", { desc = "Maps" })
map("n", "<leader>fw", "<cmd>Windows<cr>", { desc = "Windows" })
