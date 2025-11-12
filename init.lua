-- Modern Neovim Configuration
-- Bootstrap lazy.nvim plugin manager

-- Load options first (includes leader key)
require("config.options")

-- Install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

-- Setup lazy.nvim
require("lazy").setup("plugins", {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})

-- Load keymaps
require("config.keymaps")

-- Load iOS development commands
require("config.ios-commands").setup()

-- Load Android development commands
require("config.android-commands").setup()

-- Load React Native development commands
require("config.rn-commands").setup()

print("Neovim configuration loaded successfully!")
