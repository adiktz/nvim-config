-- Android Development Custom Commands
local M = {}

-- Get ADB path
local function get_adb()
  -- Try common locations
  local adb_paths = {
    vim.fn.expand("~/Library/Android/sdk/platform-tools/adb"),
    "/Users/" .. vim.fn.expand("$USER") .. "/Android/Sdk/platform-tools/adb",
    "adb", -- System PATH
  }

  for _, path in ipairs(adb_paths) do
    if vim.fn.executable(path) == 1 then
      return path
    end
  end

  vim.notify("ADB not found. Please install Android SDK.", vim.log.levels.ERROR)
  return nil
end

-- List available Android emulators
function M.list_emulators()
  local emulator_cmd = vim.fn.expand("~/Library/Android/sdk/emulator/emulator")
  if vim.fn.executable(emulator_cmd) == 0 then
    emulator_cmd = "emulator"
  end

  local result = vim.fn.systemlist(emulator_cmd .. " -list-avds")
  if #result == 0 then
    vim.notify("No Android emulators found. Create one in Android Studio.", vim.log.levels.WARN)
    return
  end

  vim.ui.select(result, {
    prompt = "Available Android Emulators:",
  }, function() end)
end

-- Start Android emulator
function M.start_emulator(emulator_name)
  local emulator_cmd = vim.fn.expand("~/Library/Android/sdk/emulator/emulator")
  if vim.fn.executable(emulator_cmd) == 0 then
    emulator_cmd = "emulator"
  end

  if not emulator_name then
    local avds = vim.fn.systemlist(emulator_cmd .. " -list-avds")
    if #avds == 0 then
      vim.notify("No Android emulators found.", vim.log.levels.ERROR)
      return
    end

    vim.ui.select(avds, {
      prompt = "Select emulator to start:",
    }, function(choice)
      if choice then
        vim.fn.jobstart(emulator_cmd .. " -avd " .. vim.fn.shellescape(choice), {
          detach = true,
        })
        vim.notify("Starting emulator: " .. choice, vim.log.levels.INFO)
      end
    end)
  else
    vim.fn.jobstart(emulator_cmd .. " -avd " .. vim.fn.shellescape(emulator_name), {
      detach = true,
    })
    vim.notify("Starting emulator: " .. emulator_name, vim.log.levels.INFO)
  end
end

-- List connected Android devices
function M.list_devices()
  local adb = get_adb()
  if not adb then
    return
  end

  local devices = vim.fn.systemlist(adb .. " devices -l")
  vim.ui.select(devices, {
    prompt = "Connected Android Devices:",
  }, function() end)
end

-- Install APK on device
function M.install_apk()
  local adb = get_adb()
  if not adb then
    return
  end

  -- Find APK files in common locations
  local apk_paths = vim.fn.globpath("app/build/outputs/apk", "**/*.apk", 0, 1)
  if #apk_paths == 0 then
    vim.notify("No APK files found in app/build/outputs/apk", vim.log.levels.ERROR)
    return
  end

  vim.ui.select(apk_paths, {
    prompt = "Select APK to install:",
  }, function(choice)
    if choice then
      vim.cmd("split | terminal " .. adb .. " install -r " .. vim.fn.shellescape(choice))
    end
  end)
end

-- Run Gradle task
function M.gradle_task(task)
  local gradlew = "./gradlew"
  if vim.fn.filereadable("gradlew") == 0 then
    vim.notify("gradlew not found in project root", vim.log.levels.ERROR)
    return
  end

  if not task then
    local common_tasks = {
      "assembleDebug",
      "assembleRelease",
      "installDebug",
      "installRelease",
      "clean",
      "test",
      "connectedAndroidTest",
      "lint",
      "dependencies",
    }

    vim.ui.select(common_tasks, {
      prompt = "Select Gradle task:",
    }, function(choice)
      if choice then
        vim.cmd("split | terminal ./gradlew " .. choice)
      end
    end)
  else
    vim.cmd("split | terminal ./gradlew " .. task)
  end
end

-- Build debug APK
function M.build_debug()
  M.gradle_task("assembleDebug")
end

-- Build and install debug APK
function M.install_debug()
  M.gradle_task("installDebug")
end

-- Run app on device
function M.run_app()
  local adb = get_adb()
  if not adb then
    return
  end

  -- Get package name from AndroidManifest.xml
  local manifest = vim.fn.findfile("AndroidManifest.xml", ".;")
  if manifest == "" then
    vim.notify("AndroidManifest.xml not found", vim.log.levels.ERROR)
    return
  end

  -- Simple package extraction (this could be improved)
  local package_name = vim.fn.system("grep 'package=' " .. manifest .. " | head -1 | sed 's/.*package=\"\\([^\"]*\\)\".*/\\1/'")
  package_name = vim.trim(package_name)

  if package_name ~= "" then
    vim.fn.system(adb .. " shell am start -n " .. package_name .. "/.MainActivity")
    vim.notify("Launching app: " .. package_name, vim.log.levels.INFO)
  else
    vim.notify("Could not determine package name", vim.log.levels.ERROR)
  end
end

-- View logcat
function M.logcat()
  local adb = get_adb()
  if not adb then
    return
  end

  vim.cmd("split | terminal " .. adb .. " logcat")
end

-- Clear logcat
function M.clear_logcat()
  local adb = get_adb()
  if not adb then
    return
  end

  vim.fn.system(adb .. " logcat -c")
  vim.notify("Logcat cleared", vim.log.levels.INFO)
end

-- Uninstall app
function M.uninstall_app()
  local adb = get_adb()
  if not adb then
    return
  end

  local package = vim.fn.input("Package name: ")
  if package ~= "" then
    vim.fn.system(adb .. " uninstall " .. package)
    vim.notify("Uninstalled: " .. package, vim.log.levels.INFO)
  end
end

-- Clean Gradle build
function M.clean_gradle()
  M.gradle_task("clean")
end

-- Run tests
function M.run_tests()
  M.gradle_task("test")
end

-- Run lint
function M.run_lint()
  M.gradle_task("lint")
end

-- Setup commands
function M.setup()
  -- Create user commands
  vim.api.nvim_create_user_command("AndroidEmulatorList", M.list_emulators, {})
  vim.api.nvim_create_user_command("AndroidEmulatorStart", M.start_emulator, {})
  vim.api.nvim_create_user_command("AndroidDeviceList", M.list_devices, {})
  vim.api.nvim_create_user_command("AndroidInstallAPK", M.install_apk, {})
  vim.api.nvim_create_user_command("AndroidBuildDebug", M.build_debug, {})
  vim.api.nvim_create_user_command("AndroidInstallDebug", M.install_debug, {})
  vim.api.nvim_create_user_command("AndroidRunApp", M.run_app, {})
  vim.api.nvim_create_user_command("AndroidLogcat", M.logcat, {})
  vim.api.nvim_create_user_command("AndroidClearLogcat", M.clear_logcat, {})
  vim.api.nvim_create_user_command("AndroidUninstall", M.uninstall_app, {})
  vim.api.nvim_create_user_command("AndroidClean", M.clean_gradle, {})
  vim.api.nvim_create_user_command("AndroidTest", M.run_tests, {})
  vim.api.nvim_create_user_command("AndroidLint", M.run_lint, {})

  vim.api.nvim_create_user_command("GradleTask", function()
    M.gradle_task()
  end, {})

  -- Keymaps for Android development
  vim.keymap.set("n", "<leader>ae", M.list_emulators, { desc = "List Android Emulators" })
  vim.keymap.set("n", "<leader>as", M.start_emulator, { desc = "Start Android Emulator" })
  vim.keymap.set("n", "<leader>ad", M.list_devices, { desc = "List Android Devices" })
  vim.keymap.set("n", "<leader>ab", M.build_debug, { desc = "Build Debug APK" })
  vim.keymap.set("n", "<leader>ai", M.install_debug, { desc = "Install Debug APK" })
  vim.keymap.set("n", "<leader>ar", M.run_app, { desc = "Run Android App" })
  vim.keymap.set("n", "<leader>al", M.logcat, { desc = "View Logcat" })
  vim.keymap.set("n", "<leader>ac", M.clean_gradle, { desc = "Clean Gradle Build" })
  vim.keymap.set("n", "<leader>at", M.run_tests, { desc = "Run Android Tests" })
  vim.keymap.set("n", "<leader>aL", M.run_lint, { desc = "Run Android Lint" })

  vim.keymap.set("n", "<leader>gt", M.gradle_task, { desc = "Run Gradle Task" })
end

return M
