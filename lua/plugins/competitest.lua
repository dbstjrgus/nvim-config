return {
    'xeluxee/competitest.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
        require('competitest').setup {
            -- path where all received problems go
            received_problems_path = "/Users/jsyoon27/compfiles/$(PROBLEM).$(FEXT)",
            received_files_extension = "cpp",
            received_problems_prompt_path = false,
            template_file = false,

            -- compile & run commands
            compile_command = {
                cpp = { exec = "g++", args = { "-std=c++17", "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
            },
            run_command = {
                cpp = { exec = "./$(FNOEXT)" },
            },

            -- testcases options
            testcases_use_single_file = false,
            testcases_auto_detect_storage = true,
            testcases_input_file_format = "$(FNOEXT)_input$(TCNUM).txt",
            testcases_output_file_format = "$(FNOEXT)_output$(TCNUM).txt",
            multiple_testing = -1,
            maximum_time = 5000,

            -- 🧩 ADD THIS PART ↓↓↓
            receive = {
                enable = true,
                address = "127.0.0.1",
                port = 10045,
                open_received_problems = true,
            },


        }

        vim.keymap.set('n', '<leader>r', ':CompetiTest run<CR>', { desc = 'Run test cases' })
        vim.keymap.set('n', '<leader>e', ':CompetiTest edit_testcase<CR>', { desc = 'Edit test cases' })
        vim.keymap.set('n', '<leader>ad', ':CompetiTest add_testcase<CR>', { desc = 'Add test cases' })
    end
}
