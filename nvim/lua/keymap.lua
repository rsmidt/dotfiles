local map = vim.api.nvim_set_keymap

map('n', '<M-p>', '<cmd>lua require("telescope.builtin").buffers()<CR>', { noremap = true, silent = true })
map('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files()<CR>', { noremap = true, silent = true })
