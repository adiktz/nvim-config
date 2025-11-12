-- Basic Neovim Options
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Line Numbers
opt.number = true
opt.relativenumber = true

-- Mouse
opt.mouse = "a"

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Appearance
opt.wrap = false
opt.breakindent = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Timing
opt.updatetime = 250
opt.timeoutlen = 300

-- Clipboard
opt.clipboard = "unnamedplus"

-- Undo
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Completion
opt.completeopt = "menu,menuone,noselect"
