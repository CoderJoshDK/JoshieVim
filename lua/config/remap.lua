-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Movement
vim.keymap.set({ 'n', 'v' }, '<C-u>', '<C-u>zz', { desc = 'Go up half page; center page' })
vim.keymap.set({ 'n', 'v' }, '<C-d>', '<C-d>zz', { desc = 'Go down half page; center page' })
-- Window Movement
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true, noremap = true }) -- left window
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true, noremap = true }) -- up window
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true, noremap = true }) -- down window
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true, noremap = true }) -- right window

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Diagnostic keymaps
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end,
    { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end,
    { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Highlighted paste doesn't overwrite buffer
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = '[P]aste while putting deleted in void buffer' })

-- nvim-tree
vim.keymap.set('n', "<leader>tt", "<cmd>NvimTreeToggle<CR>", { desc = '[T]oggle [T]ree' })

-- Playground functions
-- scratch for temporary code
vim.keymap.set("n", "<leader>rss", "<cmd>Scratch<cr>", { desc = '[R]un [S]cratch [S]tart' })
vim.keymap.set("n", "<leader>rsn", "<cmd>ScratchWithName<cr>", { desc = '[R]un [S]cratch [N]ame' })
vim.keymap.set("n", "<leader>rso", "<cmd>ScratchOpen<cr>", { desc = '[R]un [S]cratch [O]pen' })
vim.keymap.set("n", "<leader>rsO", "<cmd>ScratchOpenFzf<cr>", { desc = '[R]un [S]cratch Fuzzy Open' })
-- Sniprun for running code
-- vim.keymap.set({ 'n', 'v' }, '<leader>rc', '<Plug>SnipRun', { silent = true, desc = '[R]un [C]ode' })
-- vim.keymap.set('n', '<F5>', ":let b:caret=winsaveview() <CR> | :%SnipRun <CR>| :call winrestview(b:caret) <CR>", {})

-- Extra git commands
vim.keymap.set("n", "<leader>Gc", ":Git switch -c ", { desc = "[G]it create new branch" })
