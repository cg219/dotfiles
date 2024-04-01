-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


return require('lazy').setup({
	"folke/tokyonight.nvim",
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		dependencies = {'nvim-lua/plenary.nvim'}
	},
	'Mofiqul/dracula.nvim',
	{
		'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'
	},
	'nvim-treesitter/playground',
	'mbbill/undotree',
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		dependencies = {
			--- Uncomment these if you want to manage LSP servers from neovim
			-- {'williamboman/mason.nvim'},
			-- {'williamboman/mason-lspconfig.nvim'},

			-- LSP Support
			{'neovim/nvim-lspconfig'},
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'L3MON4D3/LuaSnip'},
		}
	},
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	'ThePrimeagen/vim-be-good',
	{
		"windwp/nvim-autopairs",
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {"nvim-lua/plenary.nvim"}
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",         -- required
			"sindrets/diffview.nvim",        -- optional - Diff integration
			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = true
	},
	{
		"iamcco/markdown-preview.nvim",
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	{ "iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		init = function() vim.g.mkdp_filetypes = { "markdown" } end,
		ft = { "markdown" }
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true }
	},
	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	-- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim', lazy = {} },
	{ 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }}
})
