vim.g.webdevicons_enable_startify = 1
vim.g.startify_enable_special = 0
vim.g.startify_padding_left = 3
vim.g.startify_files_number = 8
vim.g.startify_session_dir = '~/.config/nvim/session'
vim.g.startify_session_autoload = 1
vim.g.startify_session_sort = 1
vim.g.startify_session_delete_buffers = 1
vim.g.startify_change_to_dir = 1
vim.g.startify_fortune_use_unicode = 1
vim.g.startify_session_persistence = 1
vim.g.startify_session_dir = '~/.config/nvim/session'

vim.api.nvim_exec('let startify_bookmarks = [ { \'d\': \'~/Dev\' }, { \'c\': \'~/.config/nvim/init.vim\' }, { \'b\': \'~/.bashrc\' }]', true)
vim.api.nvim_exec('let startify_lists = [ { \'type\': \'files\',     \'header\': [\'  MRU Files\'] }, { \'type\': \'sessions\',  \'header\': [\'   Sessions\'] },    { \'type\': \'bookmarks\', \'header\': [\'  Bookmarks\'] },                                                                   ]',true)

