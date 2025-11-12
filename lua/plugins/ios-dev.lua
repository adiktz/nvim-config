-- iOS Development Tools
return {
  {
    "xbase-lab/xbase",
    build = "make install",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("xbase").setup({
        sourcekit = {
          lsp = {
            config = {
              cmd = { "sourcekit-lsp" },
            },
          },
        },
        simctl = {
          iOS = {
            -- Auto-select iOS simulator
            simulator_name = nil,
          },
        },
      })

      -- Xbase keymaps
      vim.keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Xcode Build" })
      vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildRun<cr>", { desc = "Xcode Run" })
      vim.keymap.set("n", "<leader>xt", "<cmd>XcodebuildTest<cr>", { desc = "Xcode Test" })
      vim.keymap.set("n", "<leader>xs", "<cmd>XcodebuildSelectScheme<cr>", { desc = "Xcode Select Scheme" })
      vim.keymap.set("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Xcode Select Device" })
      vim.keymap.set("n", "<leader>xc", "<cmd>XcodebuildClean<cr>", { desc = "Xcode Clean" })
    end,
  },

  -- Swift-specific plugins
  {
    "wojciech-kulik/xcodebuild.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-tree.lua",
    },
    config = function()
      require("xcodebuild").setup({
        -- Auto-select device/simulator
        auto_select_device = true,
        -- Show build progress
        show_build_progress_bar = true,
        -- Build logs directory
        logs_dir = vim.fn.expand("~/.cache/nvim/xcodebuild"),
        -- Auto-save before build
        auto_save = true,
        -- Simulator settings
        simulator = {
          boot_simulator_when_running = true,
        },
      })

      -- Xcodebuild keymaps
      vim.keymap.set("n", "<leader>xB", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
      vim.keymap.set("n", "<leader>xR", "<cmd>XcodebuildRun<cr>", { desc = "Run App" })
      vim.keymap.set("n", "<leader>xT", "<cmd>XcodebuildTest<cr>", { desc = "Run Tests" })
      vim.keymap.set("n", "<leader>xS", "<cmd>XcodebuildSelectScheme<cr>", { desc = "Select Scheme" })
      vim.keymap.set("n", "<leader>xD", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
      vim.keymap.set("n", "<leader>xC", "<cmd>XcodebuildClean<cr>", { desc = "Clean Build" })
      vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildShowConfig<cr>", { desc = "Show Xcode Config" })
    end,
  },
}
