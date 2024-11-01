return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    'ThePrimeagen/vim-be-good',
    { 
        'numToStr/Comment.nvim',
        lazy = false,
        config = function ()
           require("Comment").setup() 
        end
    },
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    }
}
