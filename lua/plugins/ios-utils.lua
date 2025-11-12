-- iOS Development Utilities and Commands
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          swift = { "swiftformat" },
          java = { "google-java-format" },
          kotlin = { "ktlint" },
          lua = { "stylua" },
          python = { "black" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
        },
        format_on_save = {
          timeout_ms = 1000,
          lsp_fallback = true,
        },
        formatters = {
          swiftformat = {
            command = "swiftformat",
            args = { "--indent", "4", "$FILENAME" },
            stdin = false,
          },
          ["google-java-format"] = {
            command = "google-java-format",
            args = { "-" },
            stdin = true,
          },
          ktlint = {
            command = "ktlint",
            args = { "--format", "--stdin" },
            stdin = true,
          },
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>F", function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "Format file or selection" })
    end,
  },
}
