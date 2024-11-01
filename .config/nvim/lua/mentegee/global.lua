nmap = function(map, cmd) vim.api.nvim_set_keymap("n", map, cmd, { noremap = true, silent = true }) end
vmap = function(map, cmd) vim.api.nvim_set_keymap("v", map, cmd, { noremap = true, silent = true }) end
