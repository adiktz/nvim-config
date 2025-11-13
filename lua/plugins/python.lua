-- Python-specific Tools
return {
  -- Python virtual environment support
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      name = { "venv", ".venv", "env", ".env" },
    },
    config = function(_, opts)
      require("venv-selector").setup(opts)

      -- Keymap
      vim.keymap.set("n", "<leader>pv", "<cmd>VenvSelect<cr>", { desc = "Select Python virtual environment" })
    end,
  },

  -- Formatting with conform.nvim (supports Black and Ruff)
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_format", "ruff_fix" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })

      -- Manual format keymap
      vim.keymap.set({ "n", "v" }, "<leader>pf", function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "Format file or selection" })
    end,
  },

  -- Jupyter notebook support
  {
    "GCBallesteros/jupytext.nvim",
    config = function()
      require("jupytext").setup({
        style = "markdown",
        output_extension = "md",
        force_ft = "markdown",
      })
    end,
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    init = function()
      -- Configuration
      vim.g.molten_auto_open_output = false
      vim.g.molten_image_provider = "none" -- Disable image rendering (no extra dependencies needed)
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    config = function()
      -- Keymaps for Jupyter
      vim.keymap.set("n", "<leader>pi", ":MoltenInit<CR>", { desc = "Initialize Molten" })
      vim.keymap.set("n", "<leader>pe", ":MoltenEvaluateOperator<CR>", { desc = "Evaluate operator" })
      vim.keymap.set("n", "<leader>pl", ":MoltenEvaluateLine<CR>", { desc = "Evaluate line" })
      vim.keymap.set("n", "<leader>pr", ":MoltenReevaluateCell<CR>", { desc = "Re-evaluate cell" })
      vim.keymap.set("v", "<leader>pe", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Evaluate visual selection" })
      vim.keymap.set("n", "<leader>po", ":MoltenShowOutput<CR>", { desc = "Show output" })
      vim.keymap.set("n", "<leader>ph", ":MoltenHideOutput<CR>", { desc = "Hide output" })
      vim.keymap.set("n", "<leader>pd", ":MoltenDelete<CR>", { desc = "Delete cell" })
    end,
  },
}
