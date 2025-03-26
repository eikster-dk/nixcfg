require("eikster-dk.autocmd")
require("eikster-dk.options")
require("eikster-dk.keymaps")

vim.notify = require("notify")

--
-- BASIC
--
require("eikster-dk.plugins.colorscheme")
require("nvim-web-devicons").setup()

require("eikster-dk.plugins.which-key")
require("eikster-dk.plugins.harpoon")
require("eikster-dk.plugins.oil")
require("eikster-dk.plugins.cloak")
require("eikster-dk.plugins.flash")
require("eikster-dk.plugins.git")
require("eikster-dk.plugins.trouble")
require("eikster-dk.plugins.lualine")
require("eikster-dk.plugins.noice")
require("eikster-dk.plugins.snacks")

--
--
-- Formatters and linting
--
--
require("eikster-dk.plugins.conform")

--
--
-- CODING and LSP
--
--
require("lazydev").setup({})
require("eikster-dk.plugins.blink-cmp")
require("eikster-dk.plugins.treesitter")
require("eikster-dk.plugins.treesitter-autotag")
require("eikster-dk.lsp-autocommands").setup()
require("eikster-dk.plugins.lsp")

-- require("nvim-autopairs").setup({ check_ts = true })
-- require("nvim-ts-autotag").setup({ enable = true })
-- require("user.lsp")
-- require("user.cmp")
-- require("nvim-surround").setup()
-- require("user.treesitter")
-- require("user.other")
-- require("user.conform")
-- require("user.neogen")
-- require("user.avante")
