return {
  'goolord/alpha-nvim',
  config = function()
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }
    dashboard.section.buttons.val = {
      dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("o", "󰈞  > Toggle directory tree", "<cmd>NvimTreeToggle<CR>"),
      dashboard.button("u", "  > Update plugins", "<cmd>Lazy sync<CR><cmd>MasonUpdate<CR>"),
      dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
      dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
      dashboard.button("q", "󰅚  > Quit", "<cmd>qa<CR>"),
    }
    dashboard.section.footer.val = "Make something cool"
    require 'alpha'.setup(dashboard.opts)
    -- require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
  end
}
