--[[
  File: colorscheme.lua
  Description: Catppuccin theme for (Neo)vim
  See: https://github.com/catppuccin/nvim
]]

local M = {
  'catppuccin/nvim',
  name = "catppuccin",
  -- Load immediately to make it available for lazy
  lazy = false,
  -- Load before anything else since this is our main theme
  priority = 1000,
}

function M.config()
  local catppuccin = require('catppuccin')

  catppuccin.setup {
    flavor = 'mocha',
    transparent_background = true,
    term_colors = true,
    dim_inactive = {
      enabled = false, -- dims the background color of inactive window
      shade = 'dark',
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { 'italic' }, -- Change the style of comments
      conditionals = { 'italic' },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    highlight_overrides = {
      mocha = function(mocha)
        return {
          -- missing bg highlight for notify
          NotifyBackground = { bg = mocha.mantle },
        }
      end,
    },
    integrations = {
      alpha = true,
      barbecue = {
        dim_dirname = true, -- directory name is dimmed by default
        bold_basename = true,
        dim_context = false,
        alt_background = false,
      },
      cmp = true,
      dap = {
        enabled = true,
        enable_ui = true, -- enable nvim-dap-ui
      },
      gitsigns = true,
      illuminate = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = true,
      },
      lsp_saga = true,
      lsp_trouble = true,
      mason = true,
      neotest = true,
      neotree = true,
      noice = true,
      notifier = true,
      telescope = {
        enabled = true,
      },
      treesitter = true,
      treesitter_context = true,
      which_key = true,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { 'italic' },
        hints = { 'italic' },
        warnings = { 'italic' },
        information = { 'italic' },
      },
      underlines = {
        errors = { 'underline' },
        hints = { 'underline' },
        warnings = { 'underline' },
        information = { 'underline' },
      },
      inlay_hints = {
        background = true,
      },
    },
  }

  vim.cmd [[colorscheme catppuccin]]
end

return M