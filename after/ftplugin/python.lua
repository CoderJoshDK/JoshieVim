---@param tab vim.lsp.Client[]
---@param val string
---@return boolean
local function has_value(tab, val)
    for _, value in pairs(tab) do
        if value.name == val then
            return true
        end
    end

    return false
end

vim.keymap.set({ 'n', 'i' }, '<M-s>', function()
        local clients = vim.lsp.get_clients()

        if has_value(clients, 'basedpyright') then
            vim.lsp.enable('basedpyright', false);
            vim.lsp.enable('ty', true);
            vim.notify("Switching to ty");
        else
            vim.lsp.enable('basedpyright', true);
            vim.lsp.enable('ty', false);
            vim.notify("Switching to basedpyright");
        end
        -- Not ideal, but clears diagnostics to prevent duplicates
        vim.api.nvim_command(':e')
    end,
    { desc = 'Swap active LSP between basedpyright and ty' }
)
