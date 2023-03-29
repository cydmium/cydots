require("notify").setup {timeout = 250}
vim.notify = require("notify")
require("telescope").load_extension("notify")
