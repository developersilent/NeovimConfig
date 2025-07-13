return {
  -- Common Lua functions used by many plugins
  { "nvim-lua/plenary.nvim" },

  -- Auto-close and auto-rename HTML/JSX tags
  -- Commenting utility with treesitter support
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascriptreact", "typescriptreact", "tsx" },
    config = function()
      require("nvim-ts-autotag").setup {
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
        filetypes = {
          "html",
          "javascriptreact",
          "typescriptreact",
          "tsx",
        },
      }
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      local comment = require "Comment"
      local ts_context_commentstring = require "ts_context_commentstring.integrations.comment_nvim"
      comment.setup {
        pre_hook = ts_context_commentstring.create_pre_hook(),
      }
    end,
  },

  -- Notification UI and LSP progress
  { "j-hui/fidget.nvim", event = "VeryLazy" },

  -- Project-wide find and replace
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    keys = {
      { "<leader>rr", function() require("spectre").open() end, desc = "Replace" },
      {
        "<leader>Rw",
        function() require("spectre").open_visual { select_word = true } end,
        desc = "Replace Word",
      },
      {
        "<leader>Rf",
        function() require("spectre").open_file_search() end,
        desc = "Replace Buffer",
      },
    },
  },

  -- Automatically detect and set tabstop/shiftwidth
  {
    "tpope/vim-sleuth",
    event = "BufReadPost", -- optional lazy loading
  },

  -- Lua LSP enhancement and completion source
  {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    {
      "saghen/blink.cmp",
      opts = {
        sources = {
          default = { "lazydev", "lsp", "path", "snippets", "buffer" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
          },
        },
      },
    },
  },

  -- EditorConfig file support
  { "editorconfig/editorconfig-vim" },

  -- Breadcrumb-style winbar/status for navigation
  {
    "utilyre/barbecue.nvim",
    event = { "BufReadPre", "BufNewFile" },
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("barbecue").setup { create_autocmd = false }
      vim.api.nvim_create_autocmd({
        "WinScrolled",
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function() require("barbecue.ui").update() end,
      })
    end,
  },

  -- Session persistence between restarts
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },

  -- Mini.nvim suite: AI text objects, surrounding, pairs, statusline
  {
    "echasnovski/mini.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mini.ai").setup { n_lines = 500 }
      require("mini.surround").setup()
      require("mini.pairs").setup()
      --local statusline = require "mini.statusline"
      vim.opt.laststatus = 0
      --statusline.setup { use_icons = vim.g.have_nerd_font }
      --statusline.section_location = function() return "%2l:%-2v" end
    end,
  },

  -- Icon support for Mini.nvim
  {
    "echasnovski/mini.icons",
    enabled = true,
    lazy = true,
    opts = {},
  },

  -- Indentation guide
  {
    "echasnovski/mini.indentscope",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mini.indentscope").setup {
        symbol = "│",
        options = { try_as_border = true },
      }
    end,
  },

  -- Indent line with custom char
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = { indent = { char = "|" } },
  },

  -- Syntax highlighting for Kitty terminal config
  {
    "fladson/vim-kitty",
    ft = "kitty",
  },

  -- UI Component framework (lazy-loaded)
  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },
}
