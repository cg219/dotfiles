local builtin = require('telescope.builtin')
nmap = function(map, cmd) vim.api.nvim_set_keymap("n", map, cmd, { noremap = true, silent = true }) end
nfmap = function(map, cmd) vim.keymap.set("n", map, cmd, { noremap = true, silent = true }) end

nmap("<leader>ll", ":Ex<CR>")
nmap("Q", "<nop>")
nmap("<leader>`", ":b#<CR>")
nmap("<C-d>", "<C-d>zz")
nmap("<C-u>", "<C-u>zz")

nmap("<leader>u", ":UndotreeToggle<cr>")
nmap("<leader>ut", ":Undotree<cr>")
nmap("<leader>gi", ":LazyGit<cr>")
nmap("<leader>s", ":w<cr>")

nfmap('<leader>ff', builtin.find_files)
nfmap('<leader>pp', builtin.git_files)
nfmap('<leader>gs', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ")})
end)

