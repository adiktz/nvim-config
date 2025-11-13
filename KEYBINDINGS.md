# Neovim Keybindings Cheatsheet

**Leader Key:** `Space`

## 🚀 Quick Start (Most Used)

| Shortcut | Description |
|----------|-------------|
| `Ctrl + s` | 💾 Save file |
| `Ctrl + p` | 🔍 Find files (like VS Code) |
| `Space + e` | 📁 Toggle file explorer |
| `Ctrl + \` | 💻 Toggle terminal |
| `Space + gg` | 🌿 Open LazyGit |
| `Tab` / `Shift + Tab` | Switch between buffers |
| `jk` or `kj` | Exit insert mode |

## 📁 File Operations

| Shortcut | Description |
|----------|-------------|
| `Ctrl + s` | 💾 Save file |
| `Space + w` | 💾 Save file |
| `Space + q` | Quit |
| `Space + Q` | Quit all without saving |
| `Ctrl + p` | 🔍 Find files |
| `Space + ff` | 🔍 Find files |
| `Space + fg` | 🔎 Search text in files |
| `Space + fr` | 🕐 Recent files |
| `Space + fb` | 📑 Find buffers |

## 🌲 File Explorer (nvim-tree)

| Shortcut | Description |
|----------|-------------|
| `Space + e` | 📁 Toggle file explorer |
| `Space + E` | 📂 Find current file in explorer |

**Inside nvim-tree:**
- `Enter` - Open file/folder
- `o` - Open file
- `a` - Create new file
- `d` - Delete file
- `r` - Rename file
- `x` - Cut file
- `c` - Copy file
- `p` - Paste file
- `R` - Refresh tree

## 📝 Editing

| Shortcut | Description |
|----------|-------------|
| `Ctrl + z` | ↶ Undo |
| `Ctrl + y` | ↷ Redo |
| `Ctrl + a` | Select all |
| `Alt + j` | ⬇ Move line down |
| `Alt + k` | ⬆ Move line up |
| `Shift + Alt + j` | 📋 Duplicate line down |
| `Tab` (visual) | ➡ Indent right |
| `Shift + Tab` (visual) | ⬅ Indent left |
| `p` (visual) | Paste without yanking |

## 🪟 Window Management

| Shortcut | Description |
|----------|-------------|
| `Ctrl + h/j/k/l` | Navigate windows (left/down/up/right) |
| `Space + sv` | ⬌ Split vertically |
| `Space + sh` | ⬍ Split horizontally |
| `Space + se` | = Make splits equal |
| `Space + sx` | ❌ Close split |
| `Ctrl + Arrow Keys` | Resize windows |

## 📑 Buffer Management

| Shortcut | Description |
|----------|-------------|
| `Tab` | ➡ Next buffer |
| `Shift + Tab` | ⬅ Previous buffer |
| `Space + x` | ❌ Close current buffer |
| `Space + X` | ❌ Close all except current |

## 🌿 Git Operations

| Shortcut | Description |
|----------|-------------|
| `Space + gg` | 🌿 Open LazyGit |
| `Space + gs` | 📊 Git status (Telescope) |
| `Space + gc` | 📜 Git commits (Telescope) |
| `Space + gb` | 🌿 Git branches (Telescope) |
| `]h` | Next git hunk |
| `[h` | Previous git hunk |
| `Space + gp` | Preview git hunk |
| `Space + gr` | Reset git hunk |

## 💻 Terminal

| Shortcut | Description |
|----------|-------------|
| `Ctrl + \` | 💻 Toggle terminal |
| `Space + tf` | 💻 Floating terminal |
| `Space + th` | 💻 Horizontal terminal |
| `Space + tv` | 💻 Vertical terminal |
| `Space + tp` | 🐍 Python REPL |
| `Esc` or `jk` (in terminal) | Exit terminal mode |

## 🐍 Python Development

| Shortcut | Description |
|----------|-------------|
| `Space + pv` | 🐍 Select virtual environment |
| `Space + pf` | ✨ Format Python file (Ruff/Black) |
| `Space + pr` | 🐍 Open Python REPL |

### 📓 Jupyter Notebooks

| Shortcut | Description |
|----------|-------------|
| `Space + ji` | 📓 Initialize Jupyter kernel |
| `Space + jl` | ▶️ Evaluate current line |
| `Space + je` (visual) | ▶️ Evaluate selection |
| `Space + jr` | 🔄 Re-evaluate cell |
| `Space + jo` | 👁️ Show output |

## 🧠 LSP (Language Server)

| Shortcut | Description |
|----------|-------------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Show references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `Space + rn` | ✏️ Rename symbol |
| `Space + ca` | 💡 Code actions |
| `Space + fm` | ✨ Format document |
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |
| `Space + dl` | Show diagnostic float |

## 🐛 Debugging (DAP)

| Shortcut | Description |
|----------|-------------|
| `F5` | ▶️ Start/Continue debugging |
| `F10` | ⤵️ Step over |
| `F11` | ⤵️ Step into |
| `F12` | ⤴️ Step out |
| `Space + db` | 🔴 Toggle breakpoint |
| `Space + dB` | 🟡 Conditional breakpoint |
| `Space + dc` | ▶️ Continue |
| `Space + dt` | ⏹️ Terminate |
| `Space + du` | 🖥️ Toggle debug UI |

## 🔍 Telescope (Fuzzy Finder)

| Shortcut | Description |
|----------|-------------|
| `Ctrl + p` | 🔍 Find files |
| `Space + ff` | 🔍 Find files |
| `Space + fg` | 🔎 Live grep (search text) |
| `Space + fr` | 🕐 Recent files |
| `Space + fb` | 📑 Find buffers |
| `Space + fh` | ❓ Help tags |
| `Space + fc` | 🔎 Find word under cursor |
| `Space + fk` | ⌨️ Show all keymaps |

**Inside Telescope:**
- `Ctrl + j/k` - Move down/up
- `Ctrl + q` - Send to quickfix list
- `Esc` - Close

## ⚡ Other Useful Shortcuts

| Shortcut | Description |
|----------|-------------|
| `Esc` | Clear search highlights |
| `Space + nh` | Clear highlights |
| `Space + +` | ➕ Increment number |
| `Space + -` | ➖ Decrement number |

## 💡 Pro Tips

1. **Press `Space` and wait** - which-key will show all available shortcuts
2. **Use `Ctrl + p` instead of `:e`** - Much faster file navigation
3. **Use `jk` or `kj` to exit insert mode** - Faster than reaching for Esc
4. **Use `Tab` to switch buffers** - Just like browser tabs
5. **Press `K` over any word** - Get instant documentation (if LSP available)
6. **Use `Space + gg`** - LazyGit is much better than raw git commands
7. **Press `F5` to debug** - Just like VS Code!

## 🎯 VS Code Users

If you're coming from VS Code, these shortcuts will feel familiar:
- `Ctrl + s` - Save
- `Ctrl + p` - Find files
- `Alt + j/k` - Move lines
- `F5` - Debug
- `Tab`/`Shift+Tab` - Switch buffers (like tabs)
- `Ctrl + \` - Toggle terminal
