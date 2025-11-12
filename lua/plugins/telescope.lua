-- Telescope Configuration
return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local lga_actions = require("telescope-live-grep-args.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = "  ",
          selection_caret = " ",
          path_display = { "smart" },
          file_ignore_patterns = { ".git/", "node_modules", "%.lock" },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
          },

          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
            n = {
              ["<esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = false,
            hidden = true,
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
            initial_mode = "normal",
          },
          live_grep = {
            additional_args = function()
              return { "--hidden" }
            end,
          },
        },
        extensions = {
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t" }),
              },
            },
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      -- Load extensions
      telescope.load_extension("fzf")
      telescope.load_extension("live_grep_args")

      -- Custom functions for enhanced live grep
      local builtin = require("telescope.builtin")

      -- Grep in current buffer
      vim.keymap.set("n", "<leader>fc", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "Fuzzy find in current buffer" })

      -- Grep in open buffers
      vim.keymap.set("n", "<leader>fB", function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Buffers",
        })
      end, { desc = "Live grep in open buffers" })

      -- Grep with args (advanced)
      vim.keymap.set("n", "<leader>fG", function()
        telescope.extensions.live_grep_args.live_grep_args()
      end, { desc = "Live grep with args" })

      -- Grep current word
      vim.keymap.set("n", "<leader>fw", function()
        builtin.grep_string({ search = vim.fn.expand("<cword>") })
      end, { desc = "Grep current word" })

      -- Grep current word (case sensitive)
      vim.keymap.set("n", "<leader>fW", function()
        builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
      end, { desc = "Grep current WORD" })

      -- Resume last telescope search
      vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume last search" })

      -- Search in git files
      vim.keymap.set("n", "<leader>fgf", builtin.git_files, { desc = "Find git files" })

      -- Search git commits
      vim.keymap.set("n", "<leader>fgc", builtin.git_commits, { desc = "Git commits" })

      -- Search git branches
      vim.keymap.set("n", "<leader>fgb", builtin.git_branches, { desc = "Git branches" })

      -- Search git status
      vim.keymap.set("n", "<leader>fgs", builtin.git_status, { desc = "Git status" })
    end,
  },
}
