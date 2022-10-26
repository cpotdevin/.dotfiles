local colorscheme = "gruvbox"

vim.g.gruvbox_contrast_dark = 'hard'
-- vim.cmd("autocmd VimEnter * hi Normal ctermbg=none")

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
