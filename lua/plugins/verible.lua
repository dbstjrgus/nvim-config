-- ~/.config/nvim/lua/plugins/verible.lua
return {
    {
        "chipsalliance/verible",
        ft = { "verilog" },
        config = function()
            -- Treesitter
            local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
            if ok then
                ts_configs.setup({
                    ensure_installed = { "verilog" },
                    highlight = { enable = true },
                })
            end

            -- Start LSP when opening a verilog file
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "verilog",
                callback = function()
                    vim.lsp.start_client({
                        name = "verible",
                        cmd = { "verible-verilog-ls", "--rules_config_search" },
                        root_dir = vim.loop.cwd,
                        filetypes = { "verilog" },
                        on_attach = function(client, bufnr)
                            vim.api.nvim_create_autocmd("BufWritePost", {
                                buffer = bufnr,
                                callback = function()
                                    vim.lsp.buf.format({ async = false })
                                end,
                            })
                        end,
                    })
                end,
            })
        end,
    }
}
