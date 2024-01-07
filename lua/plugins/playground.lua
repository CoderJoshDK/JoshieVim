return {
  {
    "michaelb/sniprun",
    branch = "master",

    build = "sh install.sh",

    config = function()
      require("sniprun").setup({
        display = {
          "Classic",
          -- "VirtualText",
          "VirtualTextOk",
        },
        repl_enable = { 'Python3_original' },
        live_mode_toggle = 'enable',
        inline_messages = true,
      })
    end,
  },
  {
    "LintaoAmons/scratch.nvim",
    event = "VeryLazy",
  }
}
