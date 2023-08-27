--[[
  File: noice.lua
  Description: Experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu
  See: https://github.com/folke/noice.nvim
]]

local M = {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
        'MunifTanjim/nui.nvim',
        'nvim-telescope/telescope.nvim',
    }
}

function M.config()
  require('noice').setup {
    cmdline = {
      enabled = true, -- enable Noice cmdline UI
      view = 'cmdline', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
    },
    messages = {
      -- NOTE: If you enable messages, then the cmdline is enabled automatically.
      enabled = true, -- enable Noice messages UI
    },
    popupmenu = {
      enabled = true, -- enable Noice popupmenu UI
      ---@type 'nui'|'cmp'
      backend = 'cmp', -- use cmp as a backend to show cmdline completions
      -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
      kind_icons = require('core.icons').kind, -- set to `false` to disable icons
    },
    notify = {
      -- Turn off noice as `vim.notify`
      enabled = false,
    },
    lsp = {
        progress = {
            enabled = true,
            view = 'mini',
        },
        override = {
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true,
            },
        },
        hover = {
            enabled = true,
        },
        signature = {
            enabled = true,
        },
        message = {
            -- Messages shown by lsp servers
            enabled = true,
        },
    },
    presets = {
      -- you can enable a preset by setting it to true, or a table that will override the preset config
      -- you can also add custom presets that you can enable/disable with enabled=true
      bottom_search = true, -- turn on to use a classic bottom cmdline for search
      command_palette = false, -- turn on to position the cmdline and popupmenu together
      long_message_to_split = true, -- turn on to send long messages to a split
      inc_rename = true, -- turn on to enable an input dialog for inc-rename.nvim
      lsp_doc_border = 'rounded', -- add a border to hover docs and signature help
    },
  }

  require('telescope').load_extension('noice')
end

return M