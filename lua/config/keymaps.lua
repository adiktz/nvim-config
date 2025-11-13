-- Keymaps - User-friendly shortcuts inspired by VS Code
local keymap = vim.keymap.set

-- ============================================================================
-- GENERAL KEYMAPS (No leader key required)
-- ============================================================================

-- Quick exit insert mode
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode" })
keymap("i", "kj", "<ESC>", { desc = "Exit insert mode" })

-- Save file (like VS Code: Ctrl+S)
keymap("n", "<C-s>", "<cmd>w<CR>", { desc = "💾 Save file" })
keymap("i", "<C-s>", "<ESC><cmd>w<CR>", { desc = "💾 Save file" })

-- Quit
keymap("n", "<C-q>", "<cmd>q<CR>", { desc = "Quit" })

-- Undo/Redo (standard)
keymap("n", "<C-z>", "u", { desc = "↶ Undo" })
keymap("n", "<C-y>", "<C-r>", { desc = "↷ Redo" })

-- Select all (like Ctrl+A)
keymap("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Better indenting (stay in visual mode)
keymap("v", "<", "<gv", { desc = "⬅ Indent left" })
keymap("v", ">", ">gv", { desc = "➡ Indent right" })
keymap("v", "<Tab>", ">gv", { desc = "➡ Indent right" })
keymap("v", "<S-Tab>", "<gv", { desc = "⬅ Indent left" })

-- Move lines up/down (like Alt+Up/Down in VS Code)
keymap("n", "<A-j>", ":m .+1<CR>==", { desc = "⬇ Move line down" })
keymap("n", "<A-k>", ":m .-2<CR>==", { desc = "⬆ Move line up" })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "⬇ Move selection down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "⬆ Move selection up" })

-- Duplicate line (like Shift+Alt+Down in VS Code)
keymap("n", "<S-A-j>", ":t.<CR>", { desc = "📋 Duplicate line down" })
keymap("n", "<S-A-k>", ":t.-1<CR>", { desc = "📋 Duplicate line up" })

-- Better paste (don't yank replaced text)
keymap("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Clear search highlights
keymap("n", "<Esc>", "<cmd>nohl<CR>", { desc = "Clear search highlights" })

-- ============================================================================
-- WINDOW NAVIGATION (Vim-style: Ctrl+hjkl)
-- ============================================================================

keymap("n", "<C-h>", "<C-w>h", { desc = "⬅ Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "⬇ Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "⬆ Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "➡ Go to right window" })

-- Window resizing
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase width" })

-- ============================================================================
-- BUFFER NAVIGATION (Tab-like behavior)
-- ============================================================================

keymap("n", "<Tab>", ":bnext<CR>", { desc = "➡ Next buffer" })
keymap("n", "<S-Tab>", ":bprevious<CR>", { desc = "⬅ Previous buffer" })
keymap("n", "<leader>x", "<cmd>bd<CR>", { desc = "❌ Close buffer" })
keymap("n", "<leader>X", "<cmd>%bd|e#|bd#<CR>", { desc = "❌ Close all buffers except current" })

-- ============================================================================
-- LEADER KEY MAPPINGS (Space is leader)
-- ============================================================================

-- File operations
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "💾 Save file" })
keymap("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
keymap("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Quit all without saving" })

-- File explorer
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "📁 Toggle file explorer" })
keymap("n", "<leader>E", "<cmd>NvimTreeFindFile<CR>", { desc = "📂 Find file in explorer" })

-- Telescope (Find files - like Ctrl+P in VS Code)
keymap("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "🔍 Find files" })
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "🔍 Find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "🔎 Search text" })
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "🕐 Recent files" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "📑 Find buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "❓ Help" })
keymap("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "🔎 Find word under cursor" })
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "⌨️  Keymaps" })

-- Git operations
keymap("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "🌿 Open LazyGit" })
keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "📊 Git status" })
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "📜 Git commits" })
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "🌿 Git branches" })

-- Git hunks navigation
keymap("n", "]h", "<cmd>lua require('gitsigns').next_hunk()<CR>", { desc = "Next git hunk" })
keymap("n", "[h", "<cmd>lua require('gitsigns').prev_hunk()<CR>", { desc = "Previous git hunk" })

-- Terminal
keymap("n", "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "💻 Toggle terminal" })
keymap("n", "<leader>tf", "<cmd>lua _FLOAT_TERM_TOGGLE()<CR>", { desc = "💻 Floating terminal" })
keymap("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "💻 Horizontal terminal" })
keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "💻 Vertical terminal" })
keymap("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", { desc = "🐍 Python REPL" })

-- Terminal mode escape
keymap("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
keymap("t", "jk", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Python specific
keymap("n", "<leader>pv", "<cmd>VenvSelect<cr>", { desc = "🐍 Select virtual environment" })
keymap("n", "<leader>pf", "<cmd>lua require('conform').format({lsp_fallback = true})<cr>", { desc = "✨ Format Python file" })
keymap("n", "<leader>pr", "<cmd>lua _PYTHON_TOGGLE()<CR>", { desc = "🐍 Python REPL" })

-- Jupyter notebook
keymap("n", "<leader>ji", ":MoltenInit<CR>", { desc = "📓 Initialize Jupyter" })
keymap("n", "<leader>je", ":MoltenEvaluateOperator<CR>", { desc = "▶️  Evaluate operator" })
keymap("n", "<leader>jl", ":MoltenEvaluateLine<CR>", { desc = "▶️  Evaluate line" })
keymap("v", "<leader>je", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "▶️  Evaluate selection" })
keymap("n", "<leader>jr", ":MoltenReevaluateCell<CR>", { desc = "🔄 Re-evaluate cell" })
keymap("n", "<leader>jo", ":MoltenShowOutput<CR>", { desc = "👁️  Show output" })

-- LSP operations (will be overridden by LSP when attached)
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "✏️  Rename symbol" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "💡 Code actions" })
keymap("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end, { desc = "✨ Format document" })

-- Diagnostics
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show diagnostic" })
keymap("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Diagnostic list" })

-- Debugging (DAP)
keymap("n", "<F5>", "<cmd>lua require('dap').continue()<cr>", { desc = "▶️  Start/Continue" })
keymap("n", "<F10>", "<cmd>lua require('dap').step_over()<cr>", { desc = "⤵️  Step over" })
keymap("n", "<F11>", "<cmd>lua require('dap').step_into()<cr>", { desc = "⤵️  Step into" })
keymap("n", "<F12>", "<cmd>lua require('dap').step_out()<cr>", { desc = "⤴️  Step out" })
keymap("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", { desc = "🔴 Toggle breakpoint" })
keymap("n", "<leader>dB", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", { desc = "🟡 Conditional breakpoint" })
keymap("n", "<leader>dc", "<cmd>lua require('dap').continue()<cr>", { desc = "▶️  Continue" })
keymap("n", "<leader>dt", "<cmd>lua require('dap').terminate()<cr>", { desc = "⏹️  Terminate" })
keymap("n", "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", { desc = "🖥️  Toggle UI" })

-- Window splits
keymap("n", "<leader>sv", "<C-w>v", { desc = "⬌ Split vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "⬍ Split horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "= Equal splits" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "❌ Close split" })

-- Quick commands
keymap("n", "<leader>nh", ":nohl<CR>", { desc = "Clear highlights" })
keymap("n", "<leader>+", "<C-a>", { desc = "➕ Increment number" })
keymap("n", "<leader>-", "<C-x>", { desc = "➖ Decrement number" })
