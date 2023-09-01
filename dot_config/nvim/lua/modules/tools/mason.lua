--[[
  File: mason.lua
  Description: Portable package manager to install and manage LSP servers, DAP servers, linters, and formatters.
  See: https://github.com/williamboman/mason.nvim
]]

local M = {
  'williamboman/mason.nvim',
  build = [[:MasonUpdate]],
  dependencies = {
    'neovim/nvim-lspconfig',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  -- Load Mason immediately, it needs to be ready before LSP
  lazy = false,
}

local servers = {
  'lua_ls', -- LSP for Lua language
  'tsserver', -- LSP for Typescript and Javascript
  'emmet_ls', -- LSP for Emmet (Vue, HTML, CSS)
  'cssls', -- LSP for CSS
  'pyright', -- LSP for Python
  'gopls', -- LSP for Go
  'bashls', -- LSP for Bash
  'dagger', -- LSP for CUE
  'dockerls', -- LSP for Docker (exl. Docker Compose)
  --'fennel_language_server', -- LSP for Fennel
  'gradle_ls', -- LSP for Gradle
  'html', -- LSP for HTML
  'marksman', -- LSP for Markdown
  -- 'ruby_ls',                -- LSP for Ruby
  -- 'rust_analyzer',          -- LSP for Rust
  'sqlls', -- LSP for SQL
  'taplo', -- LSP for TOML
  'lemminx', -- LSP for XML
  'yamlls', -- LSP for YAML
}

function M.config()
  require('mason').setup()

  local mason_lspconfig = require('mason-lspconfig')
  mason_lspconfig.setup {
    ensure_installed = servers
  }

  --Setup every needed language server in lspconfig
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      lspconfig[server_name].setup {
        capabilities = capabilities,
      }
    end,
  }
end

return M