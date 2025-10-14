-- NOTE: First, some plugins that don't require any configuration
return {
    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

    'mfussenegger/nvim-ansible',

    -- Useful plugin to show you pending keybinds.
    {
        'folke/which-key.nvim',
        event = "VeryLazy",
        opts = {
            preset = "modern"
        }
    },
    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gitsigns.nav_hunk('next')
                    end
                end, { expr = true, desc = 'Jump to next hunk' })

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end, { expr = true, desc = 'Jump to previous hunk' })

                -- Actions
                -- visual mode
                map('v', '<leader>hs', function()
                    gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end, { desc = 'stage git hunk' })
                map('v', '<leader>hr', function()
                    gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end, { desc = 'reset git hunk' })
                -- normal mode
                map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'git stage hunk' })
                map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'git reset hunk' })
                map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'git Stage buffer' })
                map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'git Reset buffer' })
                map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'preview git hunk' })
                map('n', '<leader>gdd', gitsigns.diffthis, { desc = 'git diff against index' })
                map('n', '<leader>gdD', function()
                    gitsigns.diffthis('@')
                end, { desc = 'git diff against last commit' })
                map('n', '<leader>gdm', function()
                    gitsigns.diffthis('main')
                end, { desc = 'git diff against main' })

                -- Toggles
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'toggle git blame line' })
                map('n', '<leader>td', gitsigns.preview_hunk_inline, { desc = 'toggle git show deleted' })

                -- Text object
                map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'select git hunk' })
            end,
        },
    },

    {
        -- Theme
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                auto_integrations = true,
                flavour = "mocha"
            })
            vim.cmd.colorscheme "catppuccin"
        end,
    },

    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = true,
                theme = 'catppuccin',
                component_separators = '|',
                section_separators = '',
            },
            extensions = {
                'nvim-tree', 'fugitive', 'quickfix', 'trouble'
            },

        },
    },

    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help ibl`
        main = 'ibl',
        opts = {},
    },
    {
        -- Render MD
        'MeanderingProgrammer/render-markdown.nvim',
        event = { "VeryLazy" },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    -- "gc" to comment visual regions/lines
    {
        'numToStr/Comment.nvim',
        event = "BufEnter",
        opts = {}
    },
}
