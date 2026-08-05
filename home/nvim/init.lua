vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cindent = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "catppuccin/nvim", name = "catppuccin", priority = 1000,
    config = function()
      require("catppuccin").setup({ flavour = "mocha" })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  "nvim-treesitter/nvim-treesitter",
  { "windwp/nvim-autopairs", event = "InsertEnter",
    config = function() require("nvim-autopairs").setup() end,
  },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  { "hrsh7th/nvim-cmp", dependencies = {
      "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "buffer" }, { name = "path" },
        }),
      })
    end,
  },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("lualine").setup() end,
  },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local t = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", t.find_files)
      vim.keymap.set("n", "<leader>fg", t.live_grep)
      vim.keymap.set("n", "<leader>fb", t.buffers)
    end,
  },
  { "nvim-neo-tree/neo-tree.nvim", dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim", },
    config = function()
      vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>")
    end,
  },
  { "kdheepak/lazygit.nvim",
    config = function() vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>") end,
  },
  { "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup()
      vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>")
    end,
  },
  { "mbbill/undotree",
    config = function() vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>") end,
  },
  { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end },
})

vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>r", ":!nix-shell --run 'clang % -o out && ./out'<CR>", { noremap = true })
vim.keymap.set({'n', 'v'}, 'j', 'h', { noremap = true })
vim.keymap.set({'n', 'v'}, 'k', 'j', { noremap = true })
vim.keymap.set({'n', 'v'}, 'l', 'k', { noremap = true })
vim.keymap.set({'n', 'v'}, ';', 'l', { noremap = true })
vim.keymap.set({'n', 'v'}, 'h', ';', { noremap = true })
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })
