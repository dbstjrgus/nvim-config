return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() 
        local builtin = require('telescope.builtin')

        -- Search files only in the directory you opened Neovim in
        vim.keymap.set('n', '<leader>ff', function()
            builtin.find_files({
                cwd = vim.fn.getcwd(),
                hidden = true,  -- include hidden files
            })
        end, { desc = 'Telescope find files in current directory' })

        -- Other keymaps
        vim.keymap.set('n', '<leader>fg', function()
            builtin.live_grep({ cwd = vim.fn.getcwd() })
        end, { desc = 'Telescope live grep in current directory' })

        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end 
}
