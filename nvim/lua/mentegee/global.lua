nmap = function(map, cmd) vim.api.nvim_set_keymap("n", map, cmd, { noremap = true, silent = true }) end
nfmap = function(map, cmd) vim.keymap.set("n", map, cmd, { noremap = true, silent = true }) end


