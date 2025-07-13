function NvimStarter()
  local stats = require("lazy").stats()
  return "󰉁  Neovim loaded "
    .. stats.loaded
    .. "/"
    .. stats.count
    .. " plugins in "
    .. math.floor(stats.startuptime * 100 + 0.5) / 100
    .. "ms"
end
