-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- Language Packs
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },

  -- Colorscheme
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },

  -- Git integration
  { import = "astrocommunity.git.neogit" },

  -- Additional useful plugins
  { import = "astrocommunity.editing-support.vim-visual-multi" },
  { import = "astrocommunity.motion.flash-nvim" },
}
