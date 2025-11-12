-- Kotlin Multiplatform Development Commands
local M = {}

-- Check if in KMP project
local function is_kmp_project()
  return vim.fn.filereadable("build.gradle.kts") == 1
    or vim.fn.filereadable("build.gradle") == 1
    or vim.fn.filereadable("settings.gradle.kts") == 1
end

-- Get gradle wrapper
local function get_gradle()
  if vim.fn.filereadable("gradlew") == 1 then
    return "./gradlew"
  elseif vim.fn.executable("gradle") == 1 then
    return "gradle"
  else
    vim.notify("Gradle not found in project", vim.log.levels.ERROR)
    return nil
  end
end

-- Build shared module
function M.build_shared()
  if not is_kmp_project() then
    vim.notify("Not in a Kotlin Multiplatform project", vim.log.levels.ERROR)
    return
  end

  local gradle = get_gradle()
  if not gradle then
    return
  end

  vim.ui.select({
    "assemble",
    "assembleDebug",
    "assembleRelease",
    "build",
  }, {
    prompt = "Select build task:",
  }, function(choice)
    if choice then
      vim.cmd("split | terminal " .. gradle .. " :shared:" .. choice)
      vim.notify("Building shared module: " .. choice, vim.log.levels.INFO)
    end
  end)
end

-- Run KMP tests
function M.run_tests()
  if not is_kmp_project() then
    vim.notify("Not in a Kotlin Multiplatform project", vim.log.levels.ERROR)
    return
  end

  local gradle = get_gradle()
  if not gradle then
    return
  end

  vim.ui.select({
    "allTests - Run all tests",
    "commonTest - Common module tests",
    "androidTest - Android tests",
    "iosTest - iOS tests",
    "jvmTest - JVM tests",
    "jsTest - JavaScript tests",
  }, {
    prompt = "Select test target:",
  }, function(choice)
    if choice then
      local task = choice:match("^(%S+)")
      vim.cmd("split | terminal " .. gradle .. " " .. task)
      vim.notify("Running tests: " .. task, vim.log.levels.INFO)
    end
  end)
end

-- Generate iOS framework
function M.generate_ios_framework()
  if not is_kmp_project() then
    vim.notify("Not in a Kotlin Multiplatform project", vim.log.levels.ERROR)
    return
  end

  local gradle = get_gradle()
  if not gradle then
    return
  end

  vim.ui.select({
    "linkDebugFrameworkIosArm64",
    "linkReleaseFrameworkIosArm64",
    "linkDebugFrameworkIosX64",
    "linkReleaseFrameworkIosX64",
    "linkDebugFrameworkIosSimulatorArm64",
    "assembleXCFramework",
  }, {
    prompt = "Select iOS framework task:",
  }, function(choice)
    if choice then
      vim.cmd("split | terminal " .. gradle .. " " .. choice)
      vim.notify("Generating iOS framework: " .. choice, vim.log.levels.INFO)
    end
  end)
end

-- Run on Android
function M.run_android()
  if not is_kmp_project() then
    vim.notify("Not in a Kotlin Multiplatform project", vim.log.levels.ERROR)
    return
  end

  local gradle = get_gradle()
  if not gradle then
    return
  end

  vim.cmd("split | terminal " .. gradle .. " :androidApp:installDebug")
  vim.notify("Installing Android app", vim.log.levels.INFO)
end

-- Run on iOS
function M.run_ios()
  if not is_kmp_project() then
    vim.notify("Not in a Kotlin Multiplatform project", vim.log.levels.ERROR)
    return
  end

  local gradle = get_gradle()
  if not gradle then
    return
  end

  -- Build iOS framework first
  vim.cmd("split | terminal " .. gradle .. " linkDebugFrameworkIosSimulatorArm64")
  vim.notify("Building iOS framework and running app", vim.log.levels.INFO)
end

-- Clean KMP build
function M.clean()
  if not is_kmp_project() then
    vim.notify("Not in a Kotlin Multiplatform project", vim.log.levels.ERROR)
    return
  end

  local gradle = get_gradle()
  if not gradle then
    return
  end

  vim.cmd("split | terminal " .. gradle .. " clean")
  vim.notify("Cleaning KMP project", vim.log.levels.INFO)
end

-- Show KMP project structure
function M.show_structure()
  if not is_kmp_project() then
    vim.notify("Not in a Kotlin Multiplatform project", vim.log.levels.ERROR)
    return
  end

  local structure = {
    "Kotlin Multiplatform Project Structure:",
    "",
    "shared/",
    "  └── src/",
    "      ├── commonMain/kotlin/     - Shared code",
    "      ├── commonTest/kotlin/     - Shared tests",
    "      ├── androidMain/kotlin/    - Android-specific",
    "      ├── iosMain/kotlin/        - iOS-specific",
    "      ├── jvmMain/kotlin/        - JVM-specific",
    "      └── jsMain/kotlin/         - JS-specific",
    "",
    "androidApp/                       - Android application",
    "iosApp/                           - iOS application",
  }

  vim.notify(table.concat(structure, "\n"), vim.log.levels.INFO)
end

-- Create expect/actual declarations
function M.create_expect_actual()
  local name = vim.fn.input("Class/Function name: ")
  if name == "" then
    return
  end

  local type_choice = vim.fn.confirm("Create expect/actual for:", "&Class\n&Function\n&Property", 1)

  local shared_dir = "shared/src"
  local common_main = shared_dir .. "/commonMain/kotlin"
  local android_main = shared_dir .. "/androidMain/kotlin"
  local ios_main = shared_dir .. "/iosMain/kotlin"

  if type_choice == 1 then
    -- Class
    local expect_content = string.format("expect class %s {\n    // Define expected members\n}\n", name)
    local android_actual = string.format("actual class %s {\n    // Android implementation\n}\n", name)
    local ios_actual = string.format("actual class %s {\n    // iOS implementation\n}\n", name)

    vim.notify(
      "Create files:\n"
        .. common_main
        .. "/"
        .. name
        .. ".kt (expect)\n"
        .. android_main
        .. "/"
        .. name
        .. ".kt (actual)\n"
        .. ios_main
        .. "/"
        .. name
        .. ".kt (actual)",
      vim.log.levels.INFO
    )
  elseif type_choice == 2 then
    -- Function
    local expect_content = string.format("expect fun %s()\n", name)
    vim.notify("Add to common file: " .. expect_content, vim.log.levels.INFO)
  end
end

-- Gradle sync
function M.gradle_sync()
  if not is_kmp_project() then
    vim.notify("Not in a Kotlin Multiplatform project", vim.log.levels.ERROR)
    return
  end

  local gradle = get_gradle()
  if not gradle then
    return
  end

  vim.cmd("split | terminal " .. gradle .. " --refresh-dependencies")
  vim.notify("Syncing Gradle dependencies", vim.log.levels.INFO)
end

-- Show KMP targets
function M.show_targets()
  if not is_kmp_project() then
    vim.notify("Not in a Kotlin Multiplatform project", vim.log.levels.ERROR)
    return
  end

  local gradle = get_gradle()
  if not gradle then
    return
  end

  vim.cmd("split | terminal " .. gradle .. " tasks --group=kotlin")
  vim.notify("Showing Kotlin Multiplatform tasks", vim.log.levels.INFO)
end

-- Publish to Maven Local
function M.publish_local()
  if not is_kmp_project() then
    vim.notify("Not in a Kotlin Multiplatform project", vim.log.levels.ERROR)
    return
  end

  local gradle = get_gradle()
  if not gradle then
    return
  end

  vim.cmd("split | terminal " .. gradle .. " publishToMavenLocal")
  vim.notify("Publishing to Maven Local", vim.log.levels.INFO)
end

-- Run specific target
function M.run_gradle_task()
  if not is_kmp_project() then
    vim.notify("Not in a Kotlin Multiplatform project", vim.log.levels.ERROR)
    return
  end

  local gradle = get_gradle()
  if not gradle then
    return
  end

  local task = vim.fn.input("Gradle task: ")
  if task ~= "" then
    vim.cmd("split | terminal " .. gradle .. " " .. task)
    vim.notify("Running: " .. task, vim.log.levels.INFO)
  end
end

-- Setup commands and keymaps
function M.setup()
  -- Create user commands
  vim.api.nvim_create_user_command("KMPBuildShared", M.build_shared, {})
  vim.api.nvim_create_user_command("KMPTest", M.run_tests, {})
  vim.api.nvim_create_user_command("KMPiOSFramework", M.generate_ios_framework, {})
  vim.api.nvim_create_user_command("KMPRunAndroid", M.run_android, {})
  vim.api.nvim_create_user_command("KMPRuniOS", M.run_ios, {})
  vim.api.nvim_create_user_command("KMPClean", M.clean, {})
  vim.api.nvim_create_user_command("KMPStructure", M.show_structure, {})
  vim.api.nvim_create_user_command("KMPExpectActual", M.create_expect_actual, {})
  vim.api.nvim_create_user_command("KMPSync", M.gradle_sync, {})
  vim.api.nvim_create_user_command("KMPTargets", M.show_targets, {})
  vim.api.nvim_create_user_command("KMPPublishLocal", M.publish_local, {})
  vim.api.nvim_create_user_command("KMPTask", M.run_gradle_task, {})

  -- Keymaps for KMP development (leader k for KMP)
  vim.keymap.set("n", "<leader>kb", M.build_shared, { desc = "Build shared module" })
  vim.keymap.set("n", "<leader>kt", M.run_tests, { desc = "Run KMP tests" })
  vim.keymap.set("n", "<leader>kf", M.generate_ios_framework, { desc = "Generate iOS framework" })
  vim.keymap.set("n", "<leader>ka", M.run_android, { desc = "Run on Android" })
  vim.keymap.set("n", "<leader>ki", M.run_ios, { desc = "Run on iOS" })
  vim.keymap.set("n", "<leader>kc", M.clean, { desc = "Clean KMP build" })
  vim.keymap.set("n", "<leader>ks", M.show_structure, { desc = "Show KMP structure" })
  vim.keymap.set("n", "<leader>ke", M.create_expect_actual, { desc = "Create expect/actual" })
  vim.keymap.set("n", "<leader>kg", M.gradle_sync, { desc = "Gradle sync" })
  vim.keymap.set("n", "<leader>kT", M.show_targets, { desc = "Show KMP targets" })
  vim.keymap.set("n", "<leader>kp", M.publish_local, { desc = "Publish to Maven Local" })
  vim.keymap.set("n", "<leader>kx", M.run_gradle_task, { desc = "Run Gradle task" })
end

return M
