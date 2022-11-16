vim.keymap.set('n', '<M-p>', '<cmd>lua require("telescope.builtin").buffers()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ff', '<cmd>lua require("telescope.builtin").live_grep()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fb', require'telescope'.extensions.file_browser.file_browser, bufopts)
