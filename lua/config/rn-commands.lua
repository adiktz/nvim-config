-- React Native Development Custom Commands
local M = {}

-- Get React Native CLI path
local function get_rn_cli()
  if vim.fn.filereadable("node_modules/.bin/react-native") == 1 then
    return "npx react-native"
  elseif vim.fn.executable("react-native") == 1 then
    return "react-native"
  else
    vim.notify("React Native CLI not found. Run 'npm install' first.", vim.log.levels.ERROR)
    return nil
  end
end

-- Check if in React Native project
local function is_rn_project()
  return vim.fn.filereadable("package.json") == 1 and vim.fn.filereadable("app.json") == 1
end

-- Start Metro bundler
function M.start_metro()
  if not is_rn_project() then
    vim.notify("Not in a React Native project", vim.log.levels.ERROR)
    return
  end

  local rn = get_rn_cli()
  if not rn then
    return
  end

  vim.cmd("split | terminal " .. rn .. " start")
  vim.notify("Metro bundler started", vim.log.levels.INFO)
end

-- Start Metro bundler with reset cache
function M.start_metro_reset()
  if not is_rn_project() then
    vim.notify("Not in a React Native project", vim.log.levels.ERROR)
    return
  end

  local rn = get_rn_cli()
  if not rn then
    return
  end

  vim.cmd("split | terminal " .. rn .. " start --reset-cache")
  vim.notify("Metro bundler started with cache reset", vim.log.levels.INFO)
end

-- Run on iOS
function M.run_ios(simulator)
  if not is_rn_project() then
    vim.notify("Not in a React Native project", vim.log.levels.ERROR)
    return
  end

  local rn = get_rn_cli()
  if not rn then
    return
  end

  if simulator then
    vim.cmd("split | terminal " .. rn .. " run-ios --simulator='" .. simulator .. "'")
    vim.notify("Running on iOS simulator: " .. simulator, vim.log.levels.INFO)
  else
    -- Get list of available iOS simulators
    local result = vim.fn.systemlist("xcrun simctl list devices available | grep -E '\\(Booted\\)|iPhone|iPad' | grep -v 'unavailable'")

    if #result == 0 then
      vim.cmd("split | terminal " .. rn .. " run-ios")
      vim.notify("Running on default iOS simulator", vim.log.levels.INFO)
    else
      -- Parse and display simulators
      local devices = {}
      for _, line in ipairs(result) do
        local name = line:match("([^%(]+)")
        if name then
          table.insert(devices, vim.trim(name))
        end
      end

      if #devices > 0 then
        vim.ui.select(devices, {
          prompt = "Select iOS simulator:",
        }, function(choice)
          if choice then
            vim.cmd("split | terminal " .. rn .. " run-ios --simulator='" .. choice .. "'")
            vim.notify("Running on iOS simulator: " .. choice, vim.log.levels.INFO)
          end
        end)
      else
        vim.cmd("split | terminal " .. rn .. " run-ios")
      end
    end
  end
end

-- Run on Android
function M.run_android(device)
  if not is_rn_project() then
    vim.notify("Not in a React Native project", vim.log.levels.ERROR)
    return
  end

  local rn = get_rn_cli()
  if not rn then
    return
  end

  if device then
    vim.cmd("split | terminal " .. rn .. " run-android --deviceId=" .. device)
    vim.notify("Running on Android device: " .. device, vim.log.levels.INFO)
  else
    vim.cmd("split | terminal " .. rn .. " run-android")
    vim.notify("Running on Android", vim.log.levels.INFO)
  end
end

-- View React Native logs
function M.log_ios()
  if not is_rn_project() then
    vim.notify("Not in a React Native project", vim.log.levels.ERROR)
    return
  end

  local rn = get_rn_cli()
  if not rn then
    return
  end

  vim.cmd("split | terminal " .. rn .. " log-ios")
end

function M.log_android()
  if not is_rn_project() then
    vim.notify("Not in a React Native project", vim.log.levels.ERROR)
    return
  end

  local rn = get_rn_cli()
  if not rn then
    return
  end

  vim.cmd("split | terminal " .. rn .. " log-android")
end

-- Open React Native debugger
function M.open_debugger()
  vim.fn.system("open 'rndebugger://set-debugger-loc?host=localhost&port=8081'")
  vim.notify("Opening React Native Debugger", vim.log.levels.INFO)
end

-- Reload React Native app
function M.reload_app()
  -- Send reload command to Metro bundler
  vim.fn.system("curl -X POST http://localhost:8081/reload")
  vim.notify("Reloading React Native app", vim.log.levels.INFO)
end

-- Open developer menu on iOS
function M.dev_menu_ios()
  vim.fn.system("xcrun simctl io booted sendKey 'd'")
  vim.notify("Opening developer menu on iOS", vim.log.levels.INFO)
end

-- Open developer menu on Android
function M.dev_menu_android()
  local adb = "adb"
  if vim.fn.executable(vim.fn.expand("~/Library/Android/sdk/platform-tools/adb")) == 1 then
    adb = vim.fn.expand("~/Library/Android/sdk/platform-tools/adb")
  end

  vim.fn.system(adb .. " shell input keyevent 82")
  vim.notify("Opening developer menu on Android", vim.log.levels.INFO)
end

-- Clean build and caches
function M.clean_all()
  if not is_rn_project() then
    vim.notify("Not in a React Native project", vim.log.levels.ERROR)
    return
  end

  local commands = {
    "rm -rf node_modules",
    "rm -rf ios/build",
    "rm -rf android/build",
    "rm -rf android/app/build",
    "rm -rf $TMPDIR/react-*",
    "rm -rf $TMPDIR/metro-*",
    "watchman watch-del-all",
    "npm install",
  }

  vim.ui.select(
    { "Clean all caches", "Clean iOS only", "Clean Android only", "Clean Metro only", "Cancel" },
    { prompt = "Select clean option:" },
    function(choice)
      if choice == "Clean all caches" then
        vim.cmd("split | terminal " .. table.concat(commands, " && "))
        vim.notify("Cleaning all caches...", vim.log.levels.INFO)
      elseif choice == "Clean iOS only" then
        vim.cmd("split | terminal rm -rf ios/build && rm -rf ~/Library/Developer/Xcode/DerivedData")
        vim.notify("Cleaning iOS build...", vim.log.levels.INFO)
      elseif choice == "Clean Android only" then
        vim.cmd("split | terminal cd android && ./gradlew clean && cd ..")
        vim.notify("Cleaning Android build...", vim.log.levels.INFO)
      elseif choice == "Clean Metro only" then
        vim.cmd("split | terminal rm -rf $TMPDIR/react-* && rm -rf $TMPDIR/metro-* && watchman watch-del-all")
        vim.notify("Cleaning Metro cache...", vim.log.levels.INFO)
      end
    end
  )
end

-- Install pods (iOS dependencies)
function M.install_pods()
  if not is_rn_project() then
    vim.notify("Not in a React Native project", vim.log.levels.ERROR)
    return
  end

  if vim.fn.isdirectory("ios") == 0 then
    vim.notify("iOS directory not found", vim.log.levels.ERROR)
    return
  end

  vim.cmd("split | terminal cd ios && pod install && cd ..")
  vim.notify("Installing CocoaPods...", vim.log.levels.INFO)
end

-- Run tests
function M.run_tests()
  if not is_rn_project() then
    vim.notify("Not in a React Native project", vim.log.levels.ERROR)
    return
  end

  vim.cmd("split | terminal npm test")
end

-- Run linter
function M.run_lint()
  if not is_rn_project() then
    vim.notify("Not in a React Native project", vim.log.levels.ERROR)
    return
  end

  vim.cmd("split | terminal npm run lint")
end

-- Create new React Native component
function M.create_component()
  local component_name = vim.fn.input("Component name: ")
  if component_name == "" then
    return
  end

  local component_dir = "src/components"
  if vim.fn.isdirectory(component_dir) == 0 then
    component_dir = "components"
    if vim.fn.isdirectory(component_dir) == 0 then
      component_dir = "."
    end
  end

  local file_path = component_dir .. "/" .. component_name .. ".tsx"

  local template = string.format([[import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

interface %sProps {
  // Define your props here
}

const %s: React.FC<%sProps> = (props) => {
  return (
    <View style={styles.container}>
      <Text>%s Component</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

export default %s;
]], component_name, component_name, component_name, component_name, component_name)

  vim.fn.writefile(vim.split(template, "\n"), file_path)
  vim.cmd("edit " .. file_path)
  vim.notify("Created component: " .. file_path, vim.log.levels.INFO)
end

-- Setup commands
function M.setup()
  -- Create user commands
  vim.api.nvim_create_user_command("RNMetroStart", M.start_metro, {})
  vim.api.nvim_create_user_command("RNMetroReset", M.start_metro_reset, {})
  vim.api.nvim_create_user_command("RNRunIOS", M.run_ios, {})
  vim.api.nvim_create_user_command("RNRunAndroid", M.run_android, {})
  vim.api.nvim_create_user_command("RNLogIOS", M.log_ios, {})
  vim.api.nvim_create_user_command("RNLogAndroid", M.log_android, {})
  vim.api.nvim_create_user_command("RNDebugger", M.open_debugger, {})
  vim.api.nvim_create_user_command("RNReload", M.reload_app, {})
  vim.api.nvim_create_user_command("RNDevMenuIOS", M.dev_menu_ios, {})
  vim.api.nvim_create_user_command("RNDevMenuAndroid", M.dev_menu_android, {})
  vim.api.nvim_create_user_command("RNClean", M.clean_all, {})
  vim.api.nvim_create_user_command("RNPodInstall", M.install_pods, {})
  vim.api.nvim_create_user_command("RNTest", M.run_tests, {})
  vim.api.nvim_create_user_command("RNLint", M.run_lint, {})
  vim.api.nvim_create_user_command("RNComponent", M.create_component, {})

  -- Keymaps for React Native development
  vim.keymap.set("n", "<leader>rm", M.start_metro, { desc = "Start Metro bundler" })
  vim.keymap.set("n", "<leader>rM", M.start_metro_reset, { desc = "Start Metro (reset cache)" })
  vim.keymap.set("n", "<leader>ri", M.run_ios, { desc = "Run on iOS" })
  vim.keymap.set("n", "<leader>ra", M.run_android, { desc = "Run on Android" })
  vim.keymap.set("n", "<leader>rli", M.log_ios, { desc = "View iOS logs" })
  vim.keymap.set("n", "<leader>rla", M.log_android, { desc = "View Android logs" })
  vim.keymap.set("n", "<leader>rd", M.open_debugger, { desc = "Open debugger" })
  vim.keymap.set("n", "<leader>rr", M.reload_app, { desc = "Reload app" })
  vim.keymap.set("n", "<leader>rdi", M.dev_menu_ios, { desc = "Dev menu (iOS)" })
  vim.keymap.set("n", "<leader>rda", M.dev_menu_android, { desc = "Dev menu (Android)" })
  vim.keymap.set("n", "<leader>rc", M.clean_all, { desc = "Clean caches" })
  vim.keymap.set("n", "<leader>rp", M.install_pods, { desc = "Install pods" })
  vim.keymap.set("n", "<leader>rt", M.run_tests, { desc = "Run tests" })
  vim.keymap.set("n", "<leader>rl", M.run_lint, { desc = "Run lint" })
  vim.keymap.set("n", "<leader>rn", M.create_component, { desc = "New component" })
end

return M
