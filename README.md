# Neovim Configuration Guide

Complete modern Neovim setup with LSP, Treesitter, Telescope, and more.

## Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Main config file
├── lua/
│   ├── config/
│   │   ├── options.lua        # Editor settings
│   │   ├── keymaps.lua        # Key bindings
│   │   ├── ios-commands.lua   # iOS development commands
│   │   ├── android-commands.lua # Android development commands
│   │   ├── kmp-commands.lua   # Kotlin Multiplatform commands
│   │   └── rn-commands.lua    # React Native commands
│   └── plugins/
│       ├── colorscheme.lua    # Catppuccin theme
│       ├── treesitter.lua     # Syntax highlighting
│       ├── telescope.lua      # Fuzzy finder
│       ├── lsp.lua            # Language servers
│       ├── dap.lua            # Debug Adapter Protocol (debuggers)
│       ├── cmp.lua            # Autocompletion
│       ├── ui.lua             # UI enhancements
│       ├── editing.lua        # Editing tools
│       ├── terminal.lua       # Terminal & LazyGit
│       ├── ios-dev.lua        # iOS/Xcode integration
│       ├── ios-utils.lua      # Swift/Java/Kotlin formatting
│       └── java-kotlin-lsp.lua # Java/Kotlin LSP config
```

## Installed Features

### 1. Plugin Manager
- **lazy.nvim** - Modern plugin manager with lazy loading

### 2. Color Scheme
- **Catppuccin Mocha** - Beautiful dark theme with great integration

### 3. Syntax Highlighting (Treesitter)
Advanced syntax highlighting for multiple languages:
- Lua, Python, JavaScript, TypeScript, Rust, Go
- HTML, CSS, JSON, Markdown, Bash, C

**Features:**
- Incremental selection with `Ctrl+Space`
- Smart text objects (`af`/`if` for functions, `ac`/`ic` for classes)
- Jump between functions: `]f` / `[f` (next/previous function)
- Jump between classes: `]c` / `[c` (next/previous class)

### 4. Fuzzy Finder (Telescope) with Enhanced Live Grep
Powerful file and text search with advanced ripgrep integration.

**Basic Search:**
- `Space + ff` - Find files (includes hidden files)
- `Space + fg` - Live grep (search in files)
- `Space + fb` - Find buffers
- `Space + fh` - Help tags
- `Space + fo` - Recent files

**Advanced Live Grep:**
- `Space + fG` - Live grep with args (advanced search with ripgrep arguments)
- `Space + fc` - Fuzzy find in current buffer
- `Space + fB` - Live grep in open buffers only
- `Space + fw` - Grep current word under cursor
- `Space + fW` - Grep current WORD under cursor
- `Space + fr` - Resume last telescope search

**Git Integration:**
- `Space + fgf` - Find git files
- `Space + fgc` - Git commits
- `Space + fgb` - Git branches
- `Space + fgs` - Git status

**Live Grep Args Features:**
While in live grep with args (`Space + fG`), you can:
- `Ctrl+k` - Quote prompt
- `Ctrl+i` - Add file glob pattern
- `Ctrl+t` - Add file type filter
- Use ripgrep syntax: `"search term" --iglob "*.js"` to search only in JS files

**Quickfix List:**
- `Ctrl+q` - Send all results to quickfix list
- `Alt+q` - Send selected results to quickfix list

### 5. LSP (Language Server Protocol)
Pre-configured language servers for code intelligence.

**Installed Servers:**
- `lua_ls` - Lua
- `pyright` - Python
- `ts_ls` - TypeScript/JavaScript (with inlay hints for React Native)
- `eslint` - ESLint (React Native linting with auto-fix on save)
- `rust_analyzer` - Rust
- `gopls` - Go
- `sourcekit` - Swift/Objective-C (iOS Development)
- `jdtls` - Java (Android Development)
- `kotlin_language_server` - Kotlin (Android Development)
- `html` - HTML
- `cssls` - CSS
- `jsonls` - JSON

**LSP Keybindings:**
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gr` - Show references
- `K` - Hover documentation
- `Ctrl+k` - Signature help
- `Space + rn` - Rename symbol
- `Space + ca` - Code action
- `Space + f` - Format document
- `[d` / `]d` - Previous/Next diagnostic
- `Space + d` - Show diagnostic
- `Space + dl` - Diagnostic list

**Mason:**
- `:Mason` - Open Mason UI to install/manage LSP servers

### 6. Autocompletion (nvim-cmp)
Intelligent code completion with snippets.

**Features:**
- LSP-based completion
- Snippet support
- Path completion
- Buffer completion
- Command-line completion

**Keybindings:**
- `Tab` / `Shift+Tab` - Navigate completions
- `Ctrl+Space` - Trigger completion
- `Enter` - Confirm selection
- `Ctrl+e` - Abort completion
- `Ctrl+b` / `Ctrl+f` - Scroll documentation

### 7. UI Enhancements

#### File Explorer (nvim-tree)
- `Space + e` - Toggle file explorer

#### Status Line (lualine)
Beautiful status line with git info, diagnostics, and file info.

#### Buffer Line (bufferline)
Tab-like buffer line at the top.
- `Tab` - Next buffer
- `Shift+Tab` - Previous buffer
- `Space + x` - Close buffer

#### Dashboard (alpha-nvim)
Welcome screen with quick actions on startup.

#### Indent Guides (indent-blankline)
Visual indent guides for better code readability.

#### Which Key
Shows available keybindings after pressing leader key.
- Press `Space` and wait to see available commands

### 8. Editing Tools

#### Git Integration (gitsigns)
Git status in sign column and commands.

**Keybindings:**
- `]c` / `[c` - Next/Previous git hunk
- `Space + hp` - Preview hunk
- `Space + hs` - Stage hunk
- `Space + hr` - Reset hunk
- `Space + hS` - Stage buffer
- `Space + hR` - Reset buffer
- `Space + hu` - Undo stage hunk
- `Space + hb` - Blame line
- `Space + hd` - Diff this
- `Space + tb` - Toggle line blame

#### Auto Pairs (nvim-autopairs)
Automatically close brackets, quotes, and parentheses.

#### Comment Toggle (Comment.nvim)
Easy commenting and uncommenting.

**Keybindings:**
- `gcc` - Toggle line comment
- `gbc` - Toggle block comment
- `gc` + motion - Comment using motion (e.g., `gc3j` to comment 3 lines down)
- `gb` + motion - Block comment using motion

#### Surround (nvim-surround)
Add, delete, and change surroundings (quotes, brackets, tags).

**Examples:**
- `ysiw"` - Surround word with quotes
- `ds"` - Delete surrounding quotes
- `cs"'` - Change surrounding quotes to single quotes

#### Better Escape
Type `jk` or `jj` to quickly exit insert mode.

### 9. LazyGit & Terminal Integration

#### LazyGit
Beautiful terminal UI for Git with full mouse support.

**Keybindings:**
- `Space + gg` - Open LazyGit in floating window
- Within LazyGit:
  - `?` - Show help/keybindings
  - `q` - Quit LazyGit
  - `1-5` - Switch between panels (Status, Files, Branches, Commits, Stash)
  - `Space` - Stage/unstage files
  - `c` - Commit
  - `P` - Push
  - `p` - Pull
  - `a` - Stage all
  - `A` - Amend commit
  - `e` - Edit file
  - `o` - Open file
  - `d` - View diff
  - `Enter` - Confirm action

#### Terminal (toggleterm)
Integrated terminal with multiple layouts.

**Keybindings:**
- `Ctrl+\` - Toggle terminal (default floating)
- `Space + tf` - Toggle floating terminal
- `Space + th` - Toggle horizontal terminal
- `Space + tv` - Toggle vertical terminal

**Terminal Mode:**
- `Esc` or `jk` - Exit terminal mode (back to normal mode)
- `Ctrl+h/j/k/l` - Navigate between windows from terminal

### 10. iOS Development

Complete iOS and Swift development environment with Xcode integration.

#### Language Support
- **Swift** - Full LSP support via sourcekit-lsp
- **Objective-C** - Full LSP support
- **SwiftUI** - Syntax highlighting and code completion
- **Xcode Projects** - Project and workspace support

#### Code Formatting & Linting
- **SwiftFormat** - Automatic code formatting (installed)
- **SwiftLint** - Code style and conventions linting (installed)
- Format on save enabled for Swift files
- Manual format: `Space + F`

#### iOS Simulator Management
**Keybindings:**
- `Space + is` - List available iOS simulators
- `Space + ib` - Boot an iOS simulator
- `Space + io` - Open Simulator app
- `Space + id` - List connected iOS devices
- `Space + ic` - Clean Xcode Derived Data

**Commands:**
- `:IOSSimulatorList` - Show all available simulators
- `:IOSSimulatorBoot` - Boot a simulator
- `:IOSSimulatorOpen` - Open Simulator.app
- `:IOSDeviceList` - List connected physical devices
- `:IOSCleanDerivedData` - Clean Xcode derived data

#### Swift Package Manager
**Keybindings:**
- `Space + sb` - Swift build
- `Space + sR` - Swift run
- `Space + st` - Swift test
- `Space + sr` - Swift REPL

**Commands:**
- `:SwiftBuild` - Build Swift package
- `:SwiftRun` - Run Swift package
- `:SwiftTest` - Run Swift tests
- `:SwiftREPL` - Open Swift REPL

#### Xcode Integration
**Keybindings:**
- `Space + xB` - Build Xcode project
- `Space + xR` - Run app in simulator
- `Space + xT` - Run tests
- `Space + xS` - Select build scheme
- `Space + xD` - Select target device/simulator
- `Space + xC` - Clean build
- `Space + xl` - Show current Xcode config

#### Code Quality
**Keybindings:**
- `Space + sl` - Run SwiftLint on current file

**Commands:**
- `:SwiftLint` - Run SwiftLint on current file

#### Features
- Automatic code formatting on save
- Real-time diagnostics and error checking
- Code completion with LSP
- Symbol navigation (go to definition, find references)
- Syntax highlighting for Swift and Objective-C
- Xcode project/workspace detection
- iOS simulator integration
- Build and run commands
- Test runner integration

### 11. Android Development

Complete Android development environment with Java and Kotlin support.

#### Language Support
- **Java** - Full LSP support via jdtls (Eclipse JDT)
- **Kotlin** - Full LSP support via kotlin-language-server
- **Gradle** - Syntax highlighting and integration
- **Android XML** - Resource and layout file support

#### Code Formatting & Linting
- **google-java-format** - Google's Java code formatter (installed)
- **ktlint** - Kotlin linter and formatter (installed)
- Format on save enabled for Java and Kotlin files
- Manual format: `Space + F`

#### Android Emulator Management
**Keybindings:**
- `Space + ae` - List available Android emulators
- `Space + as` - Start an Android emulator
- `Space + ad` - List connected Android devices
- `Space + al` - View logcat output

**Commands:**
- `:AndroidEmulatorList` - Show all available emulators
- `:AndroidEmulatorStart` - Start an emulator
- `:AndroidDeviceList` - List connected devices
- `:AndroidLogcat` - View logcat in split window
- `:AndroidClearLogcat` - Clear logcat buffer

#### Gradle Integration
**Keybindings:**
- `Space + ab` - Build debug APK (assembleDebug)
- `Space + ai` - Install debug APK on device
- `Space + ar` - Run app on device
- `Space + ac` - Clean Gradle build
- `Space + at` - Run tests
- `Space + aL` - Run Android Lint
- `Space + gt` - Select and run Gradle task

**Commands:**
- `:AndroidBuildDebug` - Build debug APK
- `:AndroidInstallDebug` - Build and install debug APK
- `:AndroidRunApp` - Launch app on device
- `:AndroidClean` - Clean Gradle build
- `:AndroidTest` - Run unit tests
- `:AndroidLint` - Run lint checks
- `:GradleTask` - Interactive Gradle task selector

**Common Gradle Tasks:**
- `assembleDebug` - Build debug APK
- `assembleRelease` - Build release APK
- `installDebug` - Install debug on device
- `clean` - Clean build artifacts
- `test` - Run unit tests
- `connectedAndroidTest` - Run instrumented tests
- `lint` - Run lint checks

#### Java-Specific Features
**Keybindings (Java files only):**
- `Space + jo` - Organize imports
- `Space + jv` - Extract variable
- `Space + jc` - Extract constant
- `Space + jm` - Extract method (visual mode)
- `Space + jt` - Test nearest method
- `Space + jT` - Test class

#### APK Management
**Commands:**
- `:AndroidInstallAPK` - Select and install APK file
- `:AndroidUninstall` - Uninstall app by package name

#### Features
- Automatic code formatting on save
- Real-time diagnostics and error checking
- Code completion with LSP
- Symbol navigation (go to definition, find references)
- Syntax highlighting for Java, Kotlin, and Gradle
- Android SDK and emulator integration
- Gradle build system integration
- APK installation and management
- Logcat viewing
- Test runner integration
- Code refactoring tools for Java

### 12. Kotlin Multiplatform (KMP)

Complete Kotlin Multiplatform development environment for cross-platform mobile development.

#### What is Kotlin Multiplatform?
Kotlin Multiplatform allows you to share code between iOS, Android, and other platforms while keeping platform-specific code separate using expect/actual declarations.

#### Project Structure Support
KMP projects typically have this structure:
```
shared/
  └── src/
      ├── commonMain/kotlin/     - Shared code for all platforms
      ├── commonTest/kotlin/     - Shared tests
      ├── androidMain/kotlin/    - Android-specific implementations
      ├── iosMain/kotlin/        - iOS-specific implementations
      ├── jvmMain/kotlin/        - JVM-specific implementations
      └── jsMain/kotlin/         - JavaScript-specific implementations

androidApp/                       - Android application module
iosApp/                           - iOS application module (Xcode)
```

#### Language Support
- **Kotlin LSP** - Full language server support with KMP source set indexing
- **Java 17 target** - Configured for modern Kotlin/JVM
- **Multi-platform navigation** - Navigate between expect/actual declarations
- **Gradle integration** - Full Gradle Kotlin DSL support

#### Build & Run Commands

**Keybindings:**
- `Space + kb` - Build shared module (select task)
- `Space + ka` - Run on Android
- `Space + ki` - Run on iOS (builds framework + runs)
- `Space + kc` - Clean KMP build

**Commands:**
- `:KMPBuildShared` - Build shared module (interactive task selection)
- `:KMPRunAndroid` - Install and run Android app
- `:KMPRuniOS` - Build iOS framework and run app
- `:KMPClean` - Clean all build artifacts

**Build Tasks Available:**
- `assemble` - Build all variants
- `assembleDebug` - Build debug variant
- `assembleRelease` - Build release variant
- `build` - Full build with tests

#### Testing

**Keybindings:**
- `Space + kt` - Run tests (interactive selection)

**Commands:**
- `:KMPTest` - Select and run tests for specific platform

**Test Targets:**
- `allTests` - Run tests for all platforms
- `commonTest` - Common shared tests
- `androidTest` - Android-specific tests
- `iosTest` - iOS-specific tests
- `jvmTest` - JVM-specific tests
- `jsTest` - JavaScript-specific tests

#### iOS Framework Generation

**Keybindings:**
- `Space + kf` - Generate iOS framework

**Commands:**
- `:KMPiOSFramework` - Interactive iOS framework generation

**Available Frameworks:**
- `linkDebugFrameworkIosArm64` - Debug framework for physical devices
- `linkReleaseFrameworkIosArm64` - Release framework for physical devices
- `linkDebugFrameworkIosX64` - Debug for Intel simulators
- `linkDebugFrameworkIosSimulatorArm64` - Debug for Apple Silicon simulators
- `assembleXCFramework` - Universal XCFramework for all iOS targets

#### Expect/Actual Declarations

**Keybindings:**
- `Space + ke` - Create expect/actual declarations

**Commands:**
- `:KMPExpectActual` - Interactive expect/actual creator

Creates platform-specific implementations:
```kotlin
// commonMain/kotlin/Platform.kt
expect class Platform {
    fun getName(): String
}

// androidMain/kotlin/Platform.kt
actual class Platform {
    actual fun getName(): String = "Android"
}

// iosMain/kotlin/Platform.kt
actual class Platform {
    actual fun getName(): String = "iOS"
}
```

#### Project Management

**Keybindings:**
- `Space + ks` - Show KMP project structure
- `Space + kg` - Gradle sync/refresh dependencies
- `Space + kT` - Show all KMP Gradle targets
- `Space + kp` - Publish to Maven Local
- `Space + kx` - Run custom Gradle task

**Commands:**
- `:KMPStructure` - Display KMP project structure guide
- `:KMPSync` - Refresh Gradle dependencies
- `:KMPTargets` - List all Kotlin Multiplatform tasks
- `:KMPPublishLocal` - Publish shared module to Maven Local
- `:KMPTask` - Run custom Gradle task (prompts for input)

#### Workflow Examples

**Starting a New KMP Project:**
1. **Check structure:** `Space + ks`
2. **Sync dependencies:** `Space + kg`
3. **Build shared module:** `Space + kb` → select `assemble`
4. **Run tests:** `Space + kt` → select `allTests`
5. **Run on Android:** `Space + ka`
6. **Generate iOS framework:** `Space + kf` → select appropriate target
7. **Run on iOS:** `Space + ki`

**Adding Platform-Specific Code:**
1. **Create expect/actual:** `Space + ke`
2. Enter class/function name
3. Implement in `commonMain`, `androidMain`, `iosMain`
4. **Build:** `Space + kb`
5. **Test:** `Space + kt`

**Publishing Shared Library:**
1. **Build:** `Space + kb` → `build`
2. **Test:** `Space + kt` → `allTests`
3. **Publish:** `Space + kp`

#### Integration with iOS/Android Commands

KMP works seamlessly with existing iOS and Android commands:
- Use `Space + as` to start Android emulator
- Use `Space + is` to start iOS simulator
- Use `Space + al` for Android logcat
- Use Android/iOS debugging with `Space + db`

#### Features
- Full Kotlin LSP with KMP source set support
- Gradle integration for all KMP tasks
- iOS framework generation (debug/release, device/simulator)
- Cross-platform test runner
- Expect/actual declaration helpers
- Maven Local publishing
- Interactive task selection
- Project structure visualization
- Supports all KMP targets (Android, iOS, JVM, JS, Native)

#### External Dependencies
- Gradle (installed via gradlew or system)
- Kotlin compiler (managed by Gradle)
- Android SDK (for androidMain)
- Xcode (for iosMain)
- CocoaPods (for iOS dependencies, optional)

### 13. React Native Development

Complete React Native development environment with TypeScript, ESLint, and Metro bundler integration.

#### Language Support
- **TypeScript/JavaScript** - Full LSP support with inlay hints
- **React/JSX/TSX** - Syntax highlighting and intelligent code completion
- **ESLint** - Automatic linting with React Native plugins
- **Prettier** - Code formatting on save

#### Metro Bundler
**Keybindings:**
- `Space + rm` - Start Metro bundler
- `Space + rM` - Start Metro bundler with reset cache
- `Space + rr` - Reload React Native app

**Commands:**
- `:RNMetroStart` - Start Metro bundler
- `:RNMetroReset` - Start Metro with cache reset
- `:RNReload` - Reload the app

#### Running on Devices
**Keybindings:**
- `Space + ri` - Run on iOS simulator (with device selection)
- `Space + ra` - Run on Android emulator/device

**Commands:**
- `:RNRunIOS` - Run on iOS (prompts for simulator selection)
- `:RNRunAndroid` - Run on Android

#### Logging
**Keybindings:**
- `Space + rli` - View iOS logs
- `Space + rla` - View Android logs

**Commands:**
- `:RNLogIOS` - View iOS logs in split terminal
- `:RNLogAndroid` - View Android logs in split terminal

#### Developer Tools
**Keybindings:**
- `Space + rd` - Open React Native Debugger
- `Space + rdi` - Open developer menu on iOS
- `Space + rda` - Open developer menu on Android

**Commands:**
- `:RNDebugger` - Open React Native Debugger app
- `:RNDevMenuIOS` - Open dev menu on iOS simulator
- `:RNDevMenuAndroid` - Open dev menu on Android device

#### Project Management
**Keybindings:**
- `Space + rc` - Clean caches (interactive menu)
- `Space + rp` - Install CocoaPods (iOS dependencies)
- `Space + rt` - Run tests
- `Space + rl` - Run linter
- `Space + rn` - Create new React Native component

**Commands:**
- `:RNClean` - Clean caches (Metro, iOS, Android, or all)
- `:RNPodInstall` - Install CocoaPods dependencies
- `:RNTest` - Run Jest tests
- `:RNLint` - Run ESLint
- `:RNComponent` - Create new component from template

#### Component Template
When creating a new component with `:RNComponent` or `Space + rn`, a TypeScript React component template is generated:
```typescript
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

interface ComponentNameProps {
  // Define your props here
}

const ComponentName: React.FC<ComponentNameProps> = (props) => {
  return (
    <View style={styles.container}>
      <Text>ComponentName Component</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

export default ComponentName;
```

#### Clean Options
When using `Space + rc` or `:RNClean`, you can choose:
- **Clean all caches** - Removes node_modules, build folders, Metro cache, and reinstalls dependencies
- **Clean iOS only** - Removes iOS build and Xcode DerivedData
- **Clean Android only** - Runs Gradle clean
- **Clean Metro only** - Clears Metro bundler and watchman caches

#### Features
- Full TypeScript/JavaScript LSP with inlay hints
- ESLint integration with auto-fix on save
- Prettier formatting on save
- Metro bundler management
- iOS and Android device management (leverages existing iOS/Android commands)
- Hot reload support
- Developer menu shortcuts
- Component scaffolding
- Comprehensive logging tools
- Cache and build management
- CocoaPods integration
- Test and lint runners

#### External Dependencies Required
- Node.js and npm (installed)
- React Native CLI (installed)
- Watchman (installed)
- ESLint (installed globally)
- Prettier (installed globally)
- iOS: Xcode, iOS Simulator, CocoaPods
- Android: Android Studio, Android SDK, Java 17

#### Workflow Example
1. **Start Metro:** `Space + rm`
2. **Run on iOS:** `Space + ri` (select simulator from menu)
3. **Or run on Android:** `Space + ra`
4. **View logs:** `Space + rli` or `Space + rla`
5. **Make changes** - Hot reload happens automatically
6. **Manual reload if needed:** `Space + rr`
7. **Open dev menu:** `Space + rdi` (iOS) or `Space + rda` (Android)
8. **Clean if issues:** `Space + rc` (select clean option)

### 14. Debugging (DAP)

Full debugging support for all configured languages using nvim-dap (Debug Adapter Protocol).

#### Supported Languages & Debuggers
- **Python** - debugpy (installed)
- **Go** - delve (installed)
- **JavaScript/TypeScript/React Native** - vscode-js-debug (auto-installed via Mason)
- **Swift/Rust/C++** - CodeLLDB (auto-installed via Mason)
- **Java/Kotlin** - Built-in with nvim-jdtls

#### UI Components
- **nvim-dap-ui** - Beautiful debugging interface with:
  - Variables/Scopes window
  - Watches window
  - Call stack window
  - Breakpoints list
  - Debug REPL/Console
- **nvim-dap-virtual-text** - Shows variable values inline as you debug

#### Core Debugging Keybindings

**Breakpoints:**
- `Space + db` - Toggle breakpoint at current line
- `Space + dB` - Set conditional breakpoint (prompts for condition)

**Start/Stop:**
- `Space + dc` - Continue/Start debugging
- `Space + dt` - Terminate debugging session

**Step Through Code:**
- `Space + di` - Step into function
- `Space + do` - Step over (next line)
- `Space + dO` - Step out of function
- `Space + dC` - Run to cursor

**UI & Evaluation:**
- `Space + du` - Toggle debug UI windows
- `Space + de` - Evaluate expression under cursor (normal or visual mode)
- `Space + dr` - Open debug REPL
- `Space + dl` - Run last debug configuration

#### Debug UI Layout

When debugging starts (`Space + dc`), the UI automatically opens with:

**Left Panel (40 columns):**
- Scopes - Local and global variables
- Breakpoints - All set breakpoints
- Stacks - Call stack trace
- Watches - Watch expressions

**Bottom Panel (10 rows):**
- REPL - Interactive debug console
- Console - Program output and logs

#### Language-Specific Setup

**Python:**
```lua
-- Automatically detects virtualenv
-- Looks for: venv/, .venv/, or system python3
```

**Go:**
```lua
-- Debug current file: Space + dc
-- Debug tests: Select "Debug test" configuration
```

**JavaScript/TypeScript:**
```lua
-- Debug Node.js app: Space + dc (launch file)
-- Attach to process: Select "Attach" configuration
```

**React Native:**
```lua
-- Start Metro first: Space + rm
-- Run app: Space + ri or Space + ra
-- Attach debugger: Space + dc (select "Attach to React Native")
```

**Java:**
```lua
-- Built-in with jdtls
-- Set breakpoint and run: Space + dc
-- Hot code replace supported
```

**Swift/Rust:**
```lua
-- Builds and debugs executable
-- Prompts for path to binary on first run
```

#### Breakpoint Features
- **Visual indicators:** 🔴 active, 🟡 conditional, 🚫 rejected, ▶️ current line
- **Conditional breakpoints:** Only break when condition is true
- **Log points:** Log messages without stopping execution
- **Hit counts:** Break after N hits

#### Debug REPL
Access with `Space + dr` to:
- Evaluate expressions in debug context
- Inspect variables
- Call functions
- Modify variables during debugging

#### Workflow Example
1. **Open a file** (Python, Go, JavaScript, etc.)
2. **Set breakpoints:** `Space + db` on lines you want to inspect
3. **Start debugging:** `Space + dc`
4. **UI auto-opens** with variables, stack, etc.
5. **Step through code:**
   - `Space + do` - Next line
   - `Space + di` - Into function
   - `Space + dO` - Out of function
6. **Inspect variables:**
   - Hover over variables (shown in virtual text)
   - Check "Scopes" panel
   - Use `Space + de` to evaluate expressions
7. **Continue execution:** `Space + dc`
8. **Stop debugging:** `Space + dt`

#### Features
- Visual breakpoint indicators in sign column
- Inline variable values (virtual text)
- Full call stack navigation
- Variable inspection and modification
- Conditional breakpoints
- Debug REPL for interactive debugging
- Auto-open/close UI on debug start/stop
- Watch expressions
- Multi-language support
- Hot code replace (Java)

## General Keybindings

### Leader Key
- **Leader:** `Space`

### Window Navigation
- `Ctrl+h` - Move to left window
- `Ctrl+j` - Move to bottom window
- `Ctrl+k` - Move to top window
- `Ctrl+l` - Move to right window

### Window Resizing
- `Ctrl+Up` - Increase window height
- `Ctrl+Down` - Decrease window height
- `Ctrl+Left` - Decrease window width
- `Ctrl+Right` - Increase window width

### Scrolling
- `Ctrl+d` - Scroll down (centered)
- `Ctrl+u` - Scroll up (centered)

### Search
- `n` - Next search result (centered)
- `N` - Previous search result (centered)
- `Esc` - Clear search highlighting

### Visual Mode
- `<` / `>` - Indent left/right and reselect
- `J` / `K` - Move selected text down/up

### File Operations
- `Space + e` - Toggle file explorer
- `Space + w` - Save file
- `Space + q` - Quit

## First Steps

1. **Open Neovim:**
   ```bash
   nvim
   ```

2. **Dashboard Actions:**
   - Press `f` to find files
   - Press `e` to create a new file
   - Press `r` to see recent files
   - Press `g` to search text
   - Press `c` to open config

3. **Install LSP Servers:**
   ```
   :Mason
   ```
   Navigate and press `i` to install additional language servers.

4. **Explore Keybindings:**
   - Press `Space` and wait to see the which-key popup
   - Press `Space + f` to see file/search commands

5. **Check Health:**
   ```
   :checkhealth
   ```

6. **Try LazyGit:**
   - Press `Space + gg` to open LazyGit
   - Explore your git repository with a beautiful UI

7. **Try Advanced Live Grep:**
   - Press `Space + fG` for live grep with args
   - Try searching with patterns like: `function --iglob "*.lua"`

## External Dependencies

This configuration uses the following external tools (already installed):

### Required
- **ripgrep (rg)** - Fast search tool for live grep functionality
  ```bash
  brew install ripgrep
  ```

- **lazygit** - Terminal UI for Git
  ```bash
  brew install lazygit
  ```

### iOS Development Tools (Installed)
- **Xcode** - Required for iOS development and sourcekit-lsp
- **swiftformat** - Swift code formatter
  ```bash
  brew install swiftformat
  ```
- **swiftlint** - Swift linter
  ```bash
  brew install swiftlint
  ```

### Android Development Tools (Installed)
- **Android SDK** - Required for Android development
- **Java 17** - OpenJDK 17 for Android development
- **google-java-format** - Google's Java formatter
  ```bash
  brew install google-java-format
  ```
- **ktlint** - Kotlin linter and formatter
  ```bash
  brew install ktlint
  ```

### Optional (for LSP)
- **Node.js** - Required for many LSP servers (ts_ls, html, cssls, jsonls)
- **Python** - Required for pyright
- **Go** - Required for gopls
- **Rust** - Required for rust-analyzer

All LSP servers will be automatically installed through Mason when you open a file of that type. sourcekit-lsp comes bundled with Xcode Command Line Tools.

## Managing Plugins

### Lazy.nvim Commands
- `:Lazy` - Open plugin manager UI
- `:Lazy sync` - Install missing plugins and update existing ones
- `:Lazy update` - Update plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy check` - Check for plugin updates

### Treesitter Commands
- `:TSUpdate` - Update all parsers
- `:TSInstall <language>` - Install parser for a language
- `:TSInstallInfo` - Show installed parsers

### Mason Commands
- `:Mason` - Open Mason UI
- `:MasonUpdate` - Update Mason registry
- `:MasonInstall <server>` - Install a language server
- `:MasonUninstall <server>` - Uninstall a language server

## Customization

### Changing Color Scheme
Edit `~/.config/nvim/lua/plugins/colorscheme.lua`:
```lua
flavour = "mocha"  -- Options: latte, frappe, macchiato, mocha
```

### Adding Keybindings
Edit `~/.config/nvim/lua/config/keymaps.lua`:
```lua
keymap("n", "<leader>your_key", "<cmd>YourCommand<cr>", { desc = "Description" })
```

### Changing Editor Settings
Edit `~/.config/nvim/lua/config/options.lua`:
```lua
opt.tabstop = 2      -- Change tab width
opt.wrap = true      -- Enable line wrap
```

### Adding Plugins
Create a new file in `~/.config/nvim/lua/plugins/` or add to existing files:
```lua
return {
  "author/plugin-name",
  config = function()
    -- Plugin configuration
  end,
}
```

## Tips and Tricks

1. **Use Telescope for Everything:**
   - Find files with `Space + ff`
   - Search in files with `Space + fg`
   - Find recent files with `Space + fo`
   - Advanced search with `Space + fG` (use ripgrep args)
   - Search current word with `Space + fw`
   - Resume last search with `Space + fr`

2. **Advanced Live Grep:**
   - Use `Space + fG` for live grep with args
   - Examples:
     - `"search term" --iglob "*.js"` - Search only in JS files
     - `"function.*export" -t typescript` - Regex search in TypeScript files
     - `TODO --hidden` - Search including hidden files

3. **LazyGit Workflow:**
   - Press `Space + gg` to open LazyGit
   - Use `1-5` keys to switch between panels
   - Stage files with `Space`, commit with `c`, push with `P`
   - View beautiful diffs and manage branches easily

4. **LSP Workflow:**
   - Use `K` to see documentation
   - Use `gd` to jump to definitions
   - Use `Space + ca` for code actions
   - Use `Space + rn` to rename symbols

5. **Git Integration:**
   - Quick git UI: `Space + gg` (LazyGit)
   - Stage hunks with `Space + hs`
   - Preview changes with `Space + hp`
   - Toggle blame with `Space + tb`
   - Browse commits with `Space + fgc`

6. **Buffer Management:**
   - Switch buffers with `Tab` / `Shift+Tab`
   - Close buffer with `Space + x`
   - Find buffers with `Space + fb`

7. **Terminal Usage:**
   - Quick terminal: `Ctrl+\`
   - Floating terminal: `Space + tf`
   - Exit terminal mode: `Esc` or `jk`

8. **Quick Exit Insert Mode:**
   - Type `jk` or `jj` instead of `Esc`

## Troubleshooting

### Plugin Issues
```
:Lazy sync
```

### LSP Not Working
1. Check if server is installed: `:Mason`
2. Check LSP status: `:LspInfo`
3. Check health: `:checkhealth lsp`

### Treesitter Issues
```
:TSUpdate
:checkhealth treesitter
```

### Telescope Issues
```
:checkhealth telescope
```

## Resources

- [Neovim Docs](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Catppuccin](https://github.com/catppuccin/nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

## Configuration Location

All configuration files are located in:
```
~/.config/nvim/
```

To edit your configuration:
```bash
nvim ~/.config/nvim/init.lua
```

Or from within Neovim:
```
:e ~/.config/nvim/init.lua
```

---

**Enjoy your new Neovim setup!**
