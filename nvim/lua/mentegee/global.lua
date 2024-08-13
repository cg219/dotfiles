nmap = function(map, cmd) vim.api.nvim_set_keymap("n", map, cmd, { noremap = true, silent = true }) end
-- vmap = function(map, cmd) vim.api.nvim_set_keymap("v", map, cmd, { noremap = true, silent = true }) end
nfmap = function(map, cmd) vim.keymap.set("n", map, cmd, { noremap = true, silent = true }) end
-- vfmap = function(map, cmd) vim.keymap.set("v", map, cmd, { noremap = true, silent = true }) end
