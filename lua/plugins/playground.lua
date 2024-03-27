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
    "CoderJoshDK/playground.nvim",

    -- the bellow is for me to test things with local dev
    -- commit = "502e1fbdafe28b6ee986aa5e4fd355aa3925cf54",
    -- dir = "~/Dev/projects/plugins/playground.nvim/",

    opts = { hours_to_live = 0 },
    cmd = {
      "Playground",
      "PlaygroundSelect",
      "PlaygroundDelete",
      "PlaygroundDeleteSelect",
      "PlaygroundDeleteAll",
    },
    -- config = function()
    -- end,
  }
}
