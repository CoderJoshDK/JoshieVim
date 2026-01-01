local M = {}
table.insert(M, {
    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    -- LSP Configuration & Plugins
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { "mason-org/mason.nvim", config = true },
        "neovim/nvim-lspconfig",

        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { "j-hui/fidget.nvim",    opts = {} },
        {
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- Library items can be absolute paths
                        -- "~/projects/my-awesome-lib",
                        -- Or relative, which means they will be resolved as a plugin
                        -- "LazyVim",
                        -- When relative, you can also provide a path to the library in the plugin dir
                        "luvit-meta/library", -- see below
                    },
                },
            },
            { "Bilal2453/luvit-meta", lazy = true }, -- `vim.uv` typings
        }
    },
    config = function()
        -- [[ Configure LSP ]]
        --  This function gets run when an LSP connects to a particular buffer.
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if not client then
                    return
                end

                local nmap = function(keys, func, desc)
                    if desc then
                        desc = "LSP: " .. desc
                    end

                    vim.keymap.set("n", keys, func, { buffer = true, desc = desc })
                end
                if client.name == "ruff" then
                    client.server_capabilities.hoverProvider = false
                end

                nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                nmap("<leader>cd", vim.diagnostic.open_float, "[C]ode [D]iagnostic")

                -- See `:help K` for why this keymap
                nmap("K", vim.lsp.buf.hover, "Hover Documentation")
                nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

                -- Lesser used LSP functionality
                nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
                nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
                nmap("<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, "[W]orkspace [L]ist Folders")

                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(ev.buf, "Format", function(_)
                    vim.lsp.buf.format()
                end, { desc = "Format current buffer with LSP" })
            end
        })

        -- document existing key chains
        require("which-key").add({
            {
                group = "LSP",
                { "<leader>c",  desc = "[C]ode" },
                { "<leader>d",  desc = "[D]ocument" },
                { "<leader>g",  desc = "[G]it" },
                { "<leader>gd", desc = "[G]it [D]iff" },
                { "<leader>r",  desc = "[R]ename" },
                { "<leader>f",  desc = "[F]ind" },
                { "<leader>s",  desc = "[S]earch" },
                { "<leader>t",  desc = "[T]oggle" },
                { "<leader>w",  desc = "[W]orkspace" },
            }
        })
        -- register which-key VISUAL mode
        -- required for visual <leader>hs (hunk stage) to work
        require("which-key").add({
            {
                mode = { "v" },
                { "<leader>",  desc = "VISUAL <leader>" },
                { "<leader>g", desc = "[G]it Hunk" },
            }
        })

        -- mason-lspconfig requires that these setup functions are called in this order
        -- before setting up the servers.

        -- Enable the following language servers
        --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
        --
        --  Add any additional override configuration in the following tables. They will be passed to
        --  the `settings` field of the server config. You must look up that documentation yourself.
        --
        --  If you want to override the default filetypes that your language server will attach to you can
        --  define the property 'filetypes' to the map in question.
        --
        vim.lsp.config('rust_analyzer', {
            settings = {
                ['rust-analyzer'] = {
                    completion = {
                        callable = {
                            snippets = 'add_parentheses'
                        }
                    },
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                        runBuildScripts = true,
                    },
                    checkOnSave = true,
                    -- Add clippy lints for Rust.
                    check = {
                        allFeatures = true,
                        command = "clippy",
                        extraArgs = {
                            "--",
                            "--no-deps",
                        },
                    },
                    procMacro = {
                        enable = true,
                        ignored = {
                            ["async-trait"] = { "async_trait" },
                            ["napi-derive"] = { "napi" },
                            ["async-recursion"] = { "async_recursion" },
                        },
                    },
                }
            }
        })
        vim.lsp.config('ty', {
            settings = {
                ty = {}
            }
        })
        vim.lsp.config('basedpyright', {
            settings = {
                basedpyright = {
                    enableBasedFeatures = true,
                    disableOrganizeImports = true,
                    reportMissingTypeStubs = false,
                    reportAny = false,
                    reportExplicitAny = false,
                    analysis = { typeCheckingMode = "recommended" }
                },
                python = {}
            }
        })
        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                    -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                    -- diagnostics = { disable = { 'missing-fields' } },
                }
            }
        })

        require("mason").setup()
        require("mason-lspconfig").setup()

        -- Ensure the servers above are installed
        local mason_lspconfig = require("mason-lspconfig")

        mason_lspconfig.setup({
            automatic_enable = true,
            automatic_installation = true,
            ensure_installed = { "ruff", "rust_analyzer", "basedpyright", "ty", "lua_ls" }
        })
        vim.lsp.enable('ty', false)
    end,
})

table.insert(M, {
    "folke/trouble.nvim",
    specs = {
        "folke/snacks.nvim",
        opts = function(_, opts)
            return vim.tbl_deep_extend("force", opts or {}, {
                picker = {
                    actions = require("trouble.sources.snacks").actions,
                    win = {
                        input = {
                            keys = {
                                ["<c-t>"] = {
                                    "trouble_open",
                                    mode = { "n", "i" },
                                },
                            },
                        },
                    },
                },
            })
        end,
    },
    opts = {
        modes = {
            mydiags = {
                mode = "diagnostics",
                focus = true,
                win = {
                    type = "split",
                    size = 0.40,
                    position = "right"
                },
            },
        },
    },
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble mydiags toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            "<cmd>Trouble mydiags toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>cs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>cl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
})

table.insert(M, {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
        bind = true,
        handler_opts = {
            border = "rounded"
        }
    },
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
})

table.insert(M, {
    "Davidyz/inlayhint-filler.nvim",
    keys = {
        {
            "<Leader>I",
            function()
                require("inlayhint-filler").fill()
            end,
            desc = "Insert the [i]nlay-hint",
            mode = { "n", "v" },
        },
    }
})

return M
