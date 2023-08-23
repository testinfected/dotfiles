--[[
  File: go.lua
  Description: Feature-rich Go development plugin
  See: https://github.com/ray-x/go.nvim
]]

local M = {
  'ray-x/go.nvim',
  dependencies = {
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
  },
  event = { "CmdlineEnter" },
  ft = { 'go', 'gomod' },
  build = [[:lua require('go.install').update_all_sync()]] -- if you need to install/update all binaries
}

function M.config()
  -- TODO:
  -- [] configure test coverage
  -- [] configure symbols outline
  -- [] use lsp snippets from go.nvim
  -- [] integrate null-ls
  -- [] add buffer key mappings for test, etc.

  -- [] add https://github.com/jeniasaigak/goplay.nvim plugin
  -- [] consider https://github.com/ray-x/navigator.lua plugin

  require('go').setup {
    icons = false, -- We have already setup dap icons so don't want them overridden here
    lsp_cfg = false, -- Use mason, then apply gopls config after setup
    lsp_keymaps = function(bufnr)
      local opts = function(values)
        values.buffer = bufnr
        return values
      end
      local keys = require("core.utils").keys
      local prefix = '<leader>c' -- +Code
      keys.nmap(prefix .. 'a', require('go.codeaction').run_code_action, opts { desc = "Go Code action" })
      keys.vmap(prefix .. 'a', require('go.codeaction').run_range_code_action, opts { desc = "Go Code action" })
      keys.nmap(prefix .. 'r', require('go.rename').lsprename, opts { desc = "Go Rename..."})
    end,
    lsp_diag_virtual_text = false, -- Set up as part of diagnostics
    dap_debug_keymap = false, -- I have set this up already with all my other nvim-dap setup
    textobjects = false, -- Already have textobjects set up so do not add a mapping for this
    run_in_floaterm = true,
    -- TODO: make this a project specific setup, rather than a global setup?
    test_runner = 'ginkgo',
    trouble = true,
    lua_snip = true,
  }

  -- Use go.nvim gopls config with lsp
  local cfg = require('go.lsp').config()
  require('lspconfig').gopls.setup(cfg)
end

return M