return {
    -- Autocompletion
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        { 'L3MON4D3/LuaSnip', version = 'v2.*' },
        -- -- Adds a number of user-friendly snippets
        'rafamadriz/friendly-snippets',
        'Kaiser-Yang/blink-cmp-git',
        'disrupted/blink-cmp-conventional-commits',
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        snippets = { preset = "luasnip" },
        -- Keep an eye on signature support. Remove ray-x/lsp_signature.nvim once stable
        -- signature = { enabled = true },
        cmdline = {
            keymap = { preset = 'inherit' },
            completion = { menu = { auto_show = true } },
        },
        sources = {
            -- add 'git' to the list
            default = { 'git', 'lsp', 'path', 'snippets', 'buffer', 'conventional_commits', },
            providers = {
                git = {
                    module = 'blink-cmp-git',
                    name = 'Git',
                    opts = {},
                },
                conventional_commits = {
                    name = 'Conventional Commits',
                    module = 'blink-cmp-conventional-commits',
                    enabled = function()
                        return vim.bo.filetype == 'gitcommit'
                    end,
                    ---@module 'blink-cmp-conventional-commits'
                    ---@type blink-cmp-conventional-commits.Options
                    opts = {},
                }
            },
        },

        keymap = {
            preset = 'default',
            ['<C-S-n>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<Up>'] = false,
            ['<Down>'] = false,
        },
    },
}
