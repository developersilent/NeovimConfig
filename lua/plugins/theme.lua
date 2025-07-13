return {
  "sainnhe/gruvbox-material",
  enabled = true,
  priority = 1000, -- ensure it loads first
  config = function()
    -- Gruvbox-material global settings
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_foreground = "mix"
    vim.g.gruvbox_material_ui_contrast = "high"
    vim.g.gruvbox_material_float_style = "bright"
    vim.g.gruvbox_material_statusline_style = "material"
    vim.g.gruvbox_material_cursor = "auto"
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_transparent_background = 0

    -- Set colorscheme
    vim.cmd.colorscheme "gruvbox-material"

    -- Float borders and background
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1d2021" }) -- dark0_hard
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7c6f64", bg = "#1d2021" })
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#504945", bg = "#1d2021" })

    -- Tabline
    vim.api.nvim_set_hl(0, "TabLine", { bg = "#1d2021", fg = "#a89984" })
    vim.api.nvim_set_hl(0, "TabLineSel", { bg = "#3c3836", fg = "#ebdbb2", bold = true })
    vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#1d2021" })

    -- Completion menu (nvim-cmp / wildmenu)
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "#282828", fg = "#ebdbb2" })
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#3c3836", fg = "#fabd2f" })
    vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#504945" })

    -- Telescope
    vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#7c6f64", bg = "#1d2021" })
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#1d2021" })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#7c6f64", bg = "#1d2021" })
    vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#1d2021" })
    vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#fabd2f", bold = true })
    vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#b8bb26", bold = true })
    vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#83a598", bold = true })

    -- NeoTree (optional, for float + border style)
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#1d2021", fg = "#ebdbb2" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#1d2021", fg = "#ebdbb2" })
    vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { fg = "#665c54", bg = "#1d2021" })
  end,
}
