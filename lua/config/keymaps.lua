-- Keymaps Configuration
local keymap = vim.keymap.set

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Better indenting in visual mode
keymap("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Keep search terms centered
keymap("n", "n", "nzzzv", { desc = "Next search result (centered)" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Clear search highlighting
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

-- File explorer
keymap("n", "<leader>e", vim.cmd.Ex, { desc = "Open file explorer" })

-- Save file
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- Quit
keymap("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- Telescope keymaps (will be available after plugin loads)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
keymap("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

-- Debugging keymaps (DAP - will be available after plugin loads)
-- Start/Stop debugging
keymap("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", { desc = "Toggle breakpoint" })
keymap("n", "<leader>dB", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", { desc = "Conditional breakpoint" })
keymap("n", "<leader>dc", "<cmd>lua require('dap').continue()<cr>", { desc = "Continue/Start debugging" })
keymap("n", "<leader>dt", "<cmd>lua require('dap').terminate()<cr>", { desc = "Terminate debugging" })

-- Step through code
keymap("n", "<leader>di", "<cmd>lua require('dap').step_into()<cr>", { desc = "Step into" })
keymap("n", "<leader>do", "<cmd>lua require('dap').step_over()<cr>", { desc = "Step over" })
keymap("n", "<leader>dO", "<cmd>lua require('dap').step_out()<cr>", { desc = "Step out" })
keymap("n", "<leader>dC", "<cmd>lua require('dap').run_to_cursor()<cr>", { desc = "Run to cursor" })

-- UI controls
keymap("n", "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", { desc = "Toggle debug UI" })
keymap("n", "<leader>de", "<cmd>lua require('dapui').eval()<cr>", { desc = "Evaluate expression" })
keymap("v", "<leader>de", "<cmd>lua require('dapui').eval()<cr>", { desc = "Evaluate selection" })

-- REPL
keymap("n", "<leader>dr", "<cmd>lua require('dap').repl.open()<cr>", { desc = "Open REPL" })
keymap("n", "<leader>dl", "<cmd>lua require('dap').run_last()<cr>", { desc = "Run last debug config" })
