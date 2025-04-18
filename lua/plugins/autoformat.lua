return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    -- Full list with :help conform-formatters
    -- Define your formatters
    formatters = {
      ruff_isort = {
        command = "ruff",
        args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME" },
        stdin = true,
      },
    },
    formatters_by_ft = {
      -- lua = { "stylua" },
      json = { "jq", "prettierd", "prettier", stop_after_first = true },
      python = { "ruff_isort", "ruff_format" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "markdownlint" },
      rust = { "rustfmt", lsp_format = "fallback", args = { "+nightly" } },
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 1000, lsp_fallback = true }, -- Customize formatters
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
