return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local autopairs = require("nvim-autopairs")

        autopairs.setup({
            enable_moveright = true,
            enable_check_bracket_line = true,
            check_ts = true, -- enables Treesitter integration
        })

        -- integrate with nvim-cmp
        local cmp_status, cmp = pcall(require, "cmp")
        if cmp_status then
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
    end,
}
