return {
    "AlejandroSuero/freeze-code.nvim",
    config = function()
        local fz_api = require("freeze-code.utils.api")
        local opts = {
            freeze_path = vim.fn.exepath("freeze"), -- where is freeze installed
            copy_cmd = "", -- the default copy command is native to your OS (see below)
            copy = false, -- copy after screenshot option
            open = false, -- open after screenshot option
            dir = vim.env.PWD, -- where is the image going to be saved "." as default
            freeze_config = { -- configuration options for `freeze` command
                config = vim.fn.expand("~") .. "/.config/freeze/user.json",
                output = "_freeze",
            },
        }

        require("freeze-code").setup(opts)

        vim.keymap.set('n', '<leader>bb', fz_api.freeze)
        vim.keymap.set('v', '<leader>bb', ":Freeze<cr>")
        vim.keymap.set('n', '<leader>bl', fz_api.freeze_line)
    end
}
