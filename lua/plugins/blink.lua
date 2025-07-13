return {
  { "L3MON4D3/LuaSnip", keys = {} },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    event = "InsertEnter",
    version = "*",
    config = function()
      vim.cmd "highlight Pmenu guibg=none"
      vim.cmd "highlight PmenuExtra guibg=none"
      vim.cmd "highlight FloatBorder guibg=none"
      vim.cmd "highlight NormalFloat guibg=none"

      require("blink.cmp").setup {
        snippets = { preset = "luasnip" },
        signature = { enabled = true },
        appearance = {
          use_nvim_cmp_as_default = false,
          nerd_font_variant = "normal",
        },
        sources = {
          per_filetype = {
            codecompanion = { "codecompanion" },
          },
          default = { "lsp", "path", "snippets", "buffer" },
          providers = {
            cmdline = {
              min_keyword_length = 2,
            },
          },
        },
        keymap = {
          preset = "none",
          ["<C-a>"] = { "select_prev", "fallback" },
          ["<C-d>"] = { "select_next", "fallback" },

          ["<C-w>"] = { "scroll_documentation_up", "fallback" },
          ["<C-s>"] = { "scroll_documentation_down", "fallback" },

          ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

          ["<Enter>"] = { "select_and_accept", "fallback" },
          ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        },
        cmdline = {
          enabled = false,
          completion = { menu = { auto_show = true } },
          keymap = {
            ["<CR>"] = { "accept_and_enter", "fallback" },
          },
        },
        completion = {
          menu = {
            border = "single",
            scrolloff = 1,
            scrollbar = false,
            draw = {
              columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "kind" },
                { "source_name" },
              },
            },
          },
          documentation = {
            window = {
              border = "single",
              scrollbar = false,
              winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
            },
            auto_show = true,
            auto_show_delay_ms = 500,
          },
        },
      }

      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
