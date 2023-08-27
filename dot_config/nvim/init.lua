--[[
  File: init.lua
  Description: Entry point file for neovim
]]

require 'core.fennel' -- Fennel code goes to fnl/
require 'core.options'
require 'core.keymaps'
require 'core.lazy' -- Load plugins

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0