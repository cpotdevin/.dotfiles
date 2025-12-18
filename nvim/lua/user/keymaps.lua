vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+y$")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<CR>", "<nop>")

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")

vim.keymap.set("n", "-", "<cmd>Oil<CR>")

-- Execute selection as lua
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

-- Copy absolute file path to the system clipboard
vim.keymap.set('n', '<leader>pc', function()
  local filepath = vim.fn.expand('%:p')
  vim.fn.setreg('+', filepath)
  vim.notify("Copied absolute file path: " .. filepath, vim.log.levels.INFO, { title = "Neovim" })
end, { noremap = true, silent = true, desc = "Copy current file absolute path" })

-- Copy relative file path to the system clipboard
vim.keymap.set('n', '<leader>pr', function()
  local filepath = vim.fn.expand('%')
  vim.fn.setreg('+', filepath)
  vim.notify("Copied relative file path: " .. filepath, vim.log.levels.INFO, { title = "Neovim" })
end, { noremap = true, silent = true, desc = "Copy current file relative path" })

-- Terminal keymaps
local job_id = 0
vim.keymap.set("n", "<space>to", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.windcmd("J")
  vim.api.nvim_win_set_height(0, 15)

  job_id = vim.bo.channel
end)

local current_command = ""
vim.keymap.set("n", "<space>te", function()
  current_command = vim.fn.input("Command: ")
end)

vim.keymap.set("n", "<space>tr", function()
  if current_command == "" then
    current_command = vim.fn.input("Command: ")
  end

  vim.fn.chansend(job_id, { current_command .. "\r\n" })
end)

-- Harpoon keymaps
local harpoon = require "harpoon"

harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set(
  "n",
  "<C-e>",
  function() harpoon.ui:toggle_quick_menu(harpoon:list()) end
)

vim.keymap.set("n", "<C-m>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-,>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-.>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-/>", function() harpoon:list():select(4) end)

vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
