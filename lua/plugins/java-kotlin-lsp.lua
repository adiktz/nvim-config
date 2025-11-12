-- Java and Kotlin LSP Configuration
return {
  -- Java LSP (jdtls) with special configuration
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      local jdtls = require("jdtls")

      -- Find root directory
      local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
      local root_dir = require("jdtls.setup").find_root(root_markers)

      -- Get jdtls installation path from Mason
      local mason_registry = require("mason-registry")
      local jdtls_pkg = mason_registry.get_package("jdtls")
      local jdtls_path = jdtls_pkg:get_install_path()

      -- Data directory for workspace
      local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
      local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name

      -- OS detection
      local os_config = "linux"
      if vim.fn.has("mac") == 1 then
        os_config = "mac"
      elseif vim.fn.has("win32") == 1 then
        os_config = "win"
      end

      local config = {
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xmx1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
          "-configuration",
          jdtls_path .. "/config_" .. os_config,
          "-data",
          workspace_dir,
        },

        root_dir = root_dir,

        settings = {
          java = {
            eclipse = {
              downloadSources = true,
            },
            configuration = {
              updateBuildConfiguration = "interactive",
            },
            maven = {
              downloadSources = true,
            },
            implementationsCodeLens = {
              enabled = true,
            },
            referencesCodeLens = {
              enabled = true,
            },
            references = {
              includeDecompiledSources = true,
            },
            format = {
              enabled = true,
            },
          },
          signatureHelp = { enabled = true },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
          },
          contentProvider = { preferred = "fernflower" },
          extendedClientCapabilities = jdtls.extendedClientCapabilities,
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
          },
        },

        flags = {
          allow_incremental_sync = true,
        },

        init_options = {
          bundles = {},
        },

        -- Setup DAP
        on_attach = function(client, bufnr)
          -- Setup jdtls DAP
          jdtls.setup_dap({ hotcodereplace = "auto" })

          -- Java-specific keymaps
          vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, { desc = "Organize imports", buffer = bufnr })
          vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, { desc = "Extract variable", buffer = bufnr })
          vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, { desc = "Extract constant", buffer = bufnr })
          vim.keymap.set("v", "<leader>jm", [[<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>]], { desc = "Extract method", buffer = bufnr })
          vim.keymap.set("n", "<leader>jt", jdtls.test_nearest_method, { desc = "Test method", buffer = bufnr })
          vim.keymap.set("n", "<leader>jT", jdtls.test_class, { desc = "Test class", buffer = bufnr })
        end,
      }

      -- Start jdtls
      jdtls.start_or_attach(config)
    end,
  },

  -- Kotlin LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    ft = { "kotlin" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.kotlin_language_server.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern(
          "settings.gradle.kts",
          "settings.gradle",
          "build.gradle.kts",
          "build.gradle",
          ".git"
        ),
        init_options = {
          storagePath = vim.fn.stdpath("data") .. "/kotlin_language_server",
        },
        settings = {
          kotlin = {
            -- Support for Kotlin Multiplatform source sets
            compiler = {
              jvm = {
                target = "17",
              },
            },
            -- Enable indexing of all source sets
            indexing = {
              enabled = true,
            },
          },
        },
      })
    end,
  },
}
