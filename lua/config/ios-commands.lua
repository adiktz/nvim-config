-- iOS Development Custom Commands
local M = {}

-- List available iOS simulators
function M.list_simulators()
  local result = vim.fn.systemlist("xcrun simctl list devices available | grep -E '(iPhone|iPad)'")
  vim.ui.select(result, {
    prompt = "Available iOS Simulators:",
  }, function() end)
end

-- Boot iOS simulator
function M.boot_simulator(device_name)
  if not device_name then
    local devices = vim.fn.systemlist(
      "xcrun simctl list devices available | grep -E '(iPhone|iPad)' | head -5 | sed 's/.*\\(iPhone.*\\) (\\(.*\\)).*/\\2/'"
    )
    vim.ui.select(devices, {
      prompt = "Select simulator to boot:",
    }, function(choice)
      if choice then
        vim.fn.system("xcrun simctl boot " .. vim.fn.shellescape(choice))
        vim.notify("Booting simulator: " .. choice, vim.log.levels.INFO)
      end
    end)
  else
    vim.fn.system("xcrun simctl boot " .. vim.fn.shellescape(device_name))
    vim.notify("Booting simulator: " .. device_name, vim.log.levels.INFO)
  end
end

-- Open simulator app
function M.open_simulator()
  vim.fn.system("open -a Simulator")
  vim.notify("Opening Simulator", vim.log.levels.INFO)
end

-- Build current Xcode project
function M.xcode_build()
  local project = vim.fn.findfile("*.xcodeproj", ".;")
  local workspace = vim.fn.findfile("*.xcworkspace", ".;")

  if workspace ~= "" then
    vim.cmd('split | terminal xcodebuild -workspace "' .. workspace .. '" -scheme <scheme> build')
  elseif project ~= "" then
    vim.cmd('split | terminal xcodebuild -project "' .. project .. '" -scheme <scheme> build')
  else
    vim.notify("No Xcode project or workspace found", vim.log.levels.ERROR)
  end
end

-- Run SwiftLint
function M.swiftlint()
  local output = vim.fn.system("swiftlint lint " .. vim.fn.expand("%:p"))
  if vim.v.shell_error ~= 0 then
    vim.notify("SwiftLint found issues:\n" .. output, vim.log.levels.WARN)
  else
    vim.notify("SwiftLint: No issues found", vim.log.levels.INFO)
  end
end

-- Run Swift REPL
function M.swift_repl()
  vim.cmd("split | terminal swift")
end

-- Build and run on simulator (for SPM projects)
function M.swift_run()
  vim.cmd("split | terminal swift run")
end

-- Build SPM project
function M.swift_build()
  vim.cmd("split | terminal swift build")
end

-- Run SPM tests
function M.swift_test()
  vim.cmd("split | terminal swift test")
end

-- Get iOS device list
function M.get_connected_devices()
  local devices = vim.fn.systemlist("xcrun xctrace list devices")
  vim.ui.select(devices, {
    prompt = "Connected Devices:",
  }, function() end)
end

-- Clean derived data
function M.clean_derived_data()
  local choice = vim.fn.confirm("Clean Xcode Derived Data?", "&Yes\n&No", 2)
  if choice == 1 then
    vim.fn.system("rm -rf ~/Library/Developer/Xcode/DerivedData/*")
    vim.notify("Cleaned Derived Data", vim.log.levels.INFO)
  end
end

-- Setup commands
function M.setup()
  -- Create user commands
  vim.api.nvim_create_user_command("IOSSimulatorList", M.list_simulators, {})
  vim.api.nvim_create_user_command("IOSSimulatorBoot", M.boot_simulator, {})
  vim.api.nvim_create_user_command("IOSSimulatorOpen", M.open_simulator, {})
  vim.api.nvim_create_user_command("IOSDeviceList", M.get_connected_devices, {})
  vim.api.nvim_create_user_command("IOSCleanDerivedData", M.clean_derived_data, {})

  vim.api.nvim_create_user_command("SwiftLint", M.swiftlint, {})
  vim.api.nvim_create_user_command("SwiftREPL", M.swift_repl, {})
  vim.api.nvim_create_user_command("SwiftRun", M.swift_run, {})
  vim.api.nvim_create_user_command("SwiftBuild", M.swift_build, {})
  vim.api.nvim_create_user_command("SwiftTest", M.swift_test, {})

  -- Keymaps for iOS development
  vim.keymap.set("n", "<leader>is", M.list_simulators, { desc = "List iOS Simulators" })
  vim.keymap.set("n", "<leader>ib", M.boot_simulator, { desc = "Boot iOS Simulator" })
  vim.keymap.set("n", "<leader>io", M.open_simulator, { desc = "Open Simulator App" })
  vim.keymap.set("n", "<leader>id", M.get_connected_devices, { desc = "List iOS Devices" })
  vim.keymap.set("n", "<leader>ic", M.clean_derived_data, { desc = "Clean Derived Data" })

  vim.keymap.set("n", "<leader>sl", M.swiftlint, { desc = "Run SwiftLint" })
  vim.keymap.set("n", "<leader>sr", M.swift_repl, { desc = "Swift REPL" })
  vim.keymap.set("n", "<leader>sR", M.swift_run, { desc = "Swift Run" })
  vim.keymap.set("n", "<leader>sb", M.swift_build, { desc = "Swift Build" })
  vim.keymap.set("n", "<leader>st", M.swift_test, { desc = "Swift Test" })
end

return M
