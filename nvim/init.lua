-- Neovim Setup
-- General

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " " 
-- auto-source init.lua on save

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "init.lua",
	callback = function()
	  vim.cmd("source " .. vim.fn.expand("<afile>"))
	  print("init.lua reloaded automatically")
	end,
})
-- 0. Basis: Lazy Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup Lazy

local plugins = {
	{  
		"folke/tokyonight.nvim",
  		lazy = false,
  		priority = 1000,
  		opts = {},
	},
	{ 
		"nvim-telescope/telescope.nvim", 
		dependencies = { "nvim-lua/plenary.nvim" 
		} 
	},
        { 
		"nvim-treesitter/nvim-treesitter", 
		build = ":TSUpdate" 
	},

}
local opts = {}

require("lazy".setup(plugins, opts)

-- Loading plugins

require("tokyonight").setup()
vim.cmd.colorscheme "tokyonight"

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- 3. Treesitter Setup

local config = require("nvim-treesitter.configs")
require'nvim-treesitter.configs'.setup({
  ensure_installed = {
    "bash", "lua", "python", "json", "yaml", "markdown",
    "dockerfile", "html", "css", "javascript", "typescript",
    "make", "gitignore", "java", "c", "cpp"
  },
  highlight = { enable = true },
  indent = { enable = true },
})



