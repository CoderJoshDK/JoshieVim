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
    formatters_by_ft = {
      -- lua = { "stylua" },

      -- TODO: https://docs.astral.sh/ruff/formatter/#sorting-imports
      -- ruff_format does not automatically do isort.
      -- It can be done in a code action but for now, I am keeping isort. Remove when updated
      python = { "ruff_format", "isort" },
      -- python = { "ruff_format" },

      -- javascript = { { "prettierd", "prettier" } },
      markdown = { "markdownlint" },
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 1000, lsp_fallback = true }, -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
