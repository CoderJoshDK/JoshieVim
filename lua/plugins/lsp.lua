return {
  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { "j-hui/fidget.nvim",       opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    "folke/neodev.nvim",
  },
  config = function()
    -- [[ Configure LSP ]]
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      -- NOTE: Remember that lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself
      -- many times.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

      nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
      nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
      nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
      nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
      nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

      -- See `:help K` for why this keymap
      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

      -- Lesser used LSP functionality
      nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
      nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
      nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "[W]orkspace [L]ist Folders")

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })
    end

    -- document existing key chains
    require("which-key").register({
      ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
      ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
      ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
      ["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
      ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
      ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
      ["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
      ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
    })
    -- register which-key VISUAL mode
    -- required for visual <leader>hs (hunk stage) to work
    require("which-key").register({
      ["<leader>"] = { name = "VISUAL <leader>" },
      ["<leader>h"] = { "Git [H]unk" },
    }, { mode = "v" })

    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.
    require("mason").setup()
    require("mason-lspconfig").setup()

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. They will be passed to
    --  the `settings` field of the server config. You must look up that documentation yourself.
    --
    --  If you want to override the default filetypes that your language server will attach to you can
    --  define the property 'filetypes' to the map in question.
    local servers = {
      -- clangd = {},
      -- gopls = {},
      -- pyright = {},
      -- rust_analyzer = {},
      -- ruff_lsp = { args = { config = "~/.config/ruff/pyproject.toml" } },
      -- html = { filetypes = { 'html', 'twig', 'hbs'} },
      -- pylsp = {
      --   pylsp = {
      --     plugins = {
      --       ruff = {
      --         enabled = true, -- Enable the plugin
      --         -- executable = "<path-to-ruff-bin>",   -- Custom path to ruff
      --         -- path = "<path_to_custom_ruff_toml>", -- Custom config for ruff to use
      --         extendSelect = { "I" },          -- Rules that are additionally used by ruff
      --         extendIgnore = { "C90" },        -- Rules that are additionally ignored by ruff
      --         format = { "I" },                -- Rules that are marked as fixable by ruff that should be fixed when running textDocument/formatting
      --         severities = { ["D212"] = "I" }, -- Optional table of rules where a custom severity is desired
      --         unsafeFixes = false,             -- Whether or not to offer unsafe fixes as code actions. Ignored with the "Fix All" action
      --
      --         -- Rules that are ignored when a pyproject.toml or ruff.toml is present:
      --         lineLength = 99,                                 -- Line length to pass to ruff checking and formatting
      --         exclude = { "__about__.py" },                    -- Files to be excluded by ruff checking
      --         select = { "F", "E", "B", "A" },                 -- Rules to be enabled by ruff
      --         ignore = { "D210" },                             -- Rules to be ignored by ruff
      --         perFileIgnores = { ["__init__.py"] = "CPY001" }, -- Rules that should be ignored for specific files
      --         preview = false,                                 -- Whether to enable the preview style linting and formatting.
      --         targetVersion = "py310",                         -- The minimum python version to target (applies for both linting and formatting).
      --       },
      --       jedi_completion = { fuzzy = true },
      --     },
      --   }, },
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
    }

    -- Setup neovim lua configuration
    require("neodev").setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          -- filetypes = (servers[server_name] or {}).filetypes,
        })
      end,
    })
    require("lspconfig").ruff_lsp.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "python" },
      init_options = {
        settings = {
          -- Any extra CLI arguments for `ruff` go here.
          args = {
            -- "--config=" .. vim.loop.os_homedir() .. "/.config/ruff/pyproject.toml",
          },
          -- lint = {
          --   args = {
          --     "--select=ARG,F,E,I001",
          --     "--line-length=99",
          --   },
          -- },
        },
      },
    }
    --[[ mason_lspconfig.setup_handlers {
      require('lspconfig').pylsp.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = { pylsp = {
          plugins = {
            -- formatter options
            black = { enabled = true },
            autopep8 = { enabled = false },
            yapf = { enabled = false },
            -- linter options
            -- pylint = { enabled = true, executable = "pylint" },
            pylint = { enabled = false },
            ruff = {
              enabled = true,
              -- executable = "<path-to-ruff-bin>",   -- Custom path to ruff
              -- path = "<path_to_custom_ruff_toml>", -- Custom config for ruff to use
              extendSelect = { "I" },          -- Rules that are additionally used by ruff
              extendIgnore = { "C90" },        -- Rules that are additionally ignored by ruff
              format = { "I" },                -- Rules that are marked as fixable by ruff that should be fixed when running textDocument/formatting
              severities = { ["D212"] = "I" }, -- Optional table of rules where a custom severity is desired
              unsafeFixes = false,             -- Whether or not to offer unsafe fixes as code actions. Ignored with the "Fix All" action

              -- Rules that are ignored when a pyproject.toml or ruff.toml is present:
              lineLength = 88,                                 -- Line length to pass to ruff checking and formatting
              exclude = { "__about__.py" },                    -- Files to be excluded by ruff checking
              select = { "F" },                                -- Rules to be enabled by ruff
              ignore = { "D210" },                             -- Rules to be ignored by ruff
              perFileIgnores = { ["__init__.py"] = "CPY001" }, -- Rules that should be ignored for specific files
              preview = false,                                 -- Whether to enable the preview style linting and formatting.
              targetVersion = "py311",                         -- The minimum python version to target (applies for both linting and formatting).
            },
            pyflakes = { enabled = false },
            pycodestyle = { enabled = false },
            -- type checker
            pylsp_mypy = {
              enabled = true,
              overrides = { "--python-executable", py_path, true },
              report_progress = true,
              live_mode = false
            },
            -- auto-completion options
            jedi_completion = { fuzzy = true },
            -- import sorting
            isort = { enabled = false },
          }
        } }
      }
    } ]]
  end,
}
