-- Minimal Neovim starter config - copy to ~/.config/nvim/init.lua
-- Safe sane defaults plus the Claude Code editor integration.

-- ===== Basic options =====
vim.g.mapleader = " "            -- space as the leader key
vim.opt.number = true            -- line numbers
vim.opt.relativenumber = true    -- relative line numbers
vim.opt.mouse = "a"              -- mouse support
vim.opt.ignorecase = true        -- case-insensitive search...
vim.opt.smartcase = true         -- ...unless you type a capital
vim.opt.wrap = false             -- do not wrap long lines
vim.opt.expandtab = true         -- spaces instead of tabs
vim.opt.shiftwidth = 2           -- indent width
vim.opt.tabstop = 2
vim.opt.termguicolors = true     -- full color
vim.opt.clipboard = "unnamedplus"-- share clipboard with the system
vim.opt.scrolloff = 8            -- keep some context around the cursor

-- ===== Plugin manager (lazy.nvim) - bootstraps itself on first launch =====
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ===== Plugins =====
require("lazy").setup({
  -- Claude Code integration: lets the agent see and edit what you have open
  { "coder/claudecode.nvim", config = true },

  -- A calm dark theme
  { "folke/tokyonight.nvim", priority = 1000, config = function()
      vim.cmd.colorscheme("tokyonight-night")
  end },

  -- Fuzzy finder: press Space then f to find files, Space then g to grep
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>g", builtin.live_grep,  { desc = "Grep" })
    end },
})
