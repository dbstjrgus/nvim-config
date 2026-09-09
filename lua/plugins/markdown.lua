-- in your plugins/markdown.lua or lazy setup file
return {
    -- Live preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        ft = "markdown",
    },

    -- Markdown syntax + improvements
    { "preservim/vim-markdown",     ft = "markdown" },

    -- Auto format tables
    { "dhruvasagar/vim-table-mode", ft = "markdown" },

    -- Pretty headings (optional but clean)
    {
        "lukas-reineke/headlines.nvim",
        ft = "markdown",
        config = true
    },
}
