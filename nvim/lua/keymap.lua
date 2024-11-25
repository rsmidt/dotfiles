vim.keymap.set('n', '<M-p>', '<cmd>lua require("telescope.builtin").buffers()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files{ path_display = { "truncate" } }<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fb', require'telescope'.extensions.file_browser.file_browser, bufopts)
