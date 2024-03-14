vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.clipboard = 'unnamedplus'

vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = 'yes'

vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.updatetime = 300

vim.o.termguicolors = true

vim.o.mouse = 'a'

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.linebreak = true

vim.o.scrolloff = 5
vim.o.cursorline = true

-- Vimtex settings
vim.g.vimtex_view_method = "skim"
vim.g.vimtex_view_skim_sync = 0
vim.g.vimtex_view_skim_activate = 1

-- Custom commands
-- Vimtex
vim.keymap.set({'i', 'n'}, '<C-F>', '<Leader>lv', { remap = true })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<Leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<Leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<Leader>fh', builtin.help_tags, {})

-- Nvim-tree
vim.keymap.set('n', '<Leader>tt', ':NvimTreeToggle<Return>')
vim.keymap.set('n', '<Leader>tf', ':NvimTreeFindFile<Return>')
