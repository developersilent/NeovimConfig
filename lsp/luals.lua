local blink = require "blink.cmp"

return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT", -- Required for Neovim
      },
      diagnostics = {
        globals = { "vim", "Snacks" }, -- Recognize global variables
        disable = { "missing-fields" },
      },
      hint = {
        enable = true,
        setType = true,
        paramType = true,
        paramName = "All",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath "config" .. "/lua", -- Your config files
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
  capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    blink.get_lsp_capabilities(),
    {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true,
        },
      },
    }
  ),
}
