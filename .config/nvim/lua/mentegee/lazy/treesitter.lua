return {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function ()
        require('nvim-treesitter.configs').setup {
            ensure_installed = { "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query", "go"},
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true
            },
        }
    end
}
