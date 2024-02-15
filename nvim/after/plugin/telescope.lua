local builtin = require('telescope.builtin')

nfmap('<leader>ff', builtin.find_files)
nfmap('<leader>pp', builtin.git_files)
nfmap('<leader>ss', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ")})
end)

