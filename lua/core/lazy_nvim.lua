local uv, api, fn = vim.uv, vim.api, vim.fn
local helper = require('core.helper')
local global = require('core.global')
local win = global.is_windows
local lazy = {}
lazy.__index = lazy
local start = global.start
local sep = global.path_sep

function lazy.add(repo)
  if not lazy.plug then
    lazy.plug = {}
  end
  if repo.lazy == nil then
    repo.lazy = true
  end
  table.insert(lazy.plug, repo)
end

local createdir = function()
  local data_dir = {
    global.cache_dir .. global.path_sep .. 'backup',
    global.cache_dir .. global.path_sep .. 'sessions',
    global.cache_dir .. global.path_sep .. 'swap',
    global.cache_dir .. global.path_sep .. 'tags',
    global.cache_dir .. global.path_sep .. 'undo',
  }
  -- There only check once that If cache_dir exists
  -- Then I don't want to check subs dir exists
  for _, v in pairs(data_dir) do
    if vim.fn.isdirectory(v) == 0 then
      os.execute('mkdir -p ' .. v)
    end
  end
end

function lazy:load_modules_lazy()
  createdir()
  if not win then
    vim.loader.enable()
  end
  local modules_dir = helper.get_config_path() .. sep .. 'lua' .. sep .. 'modules'
  self.repos = {}
  -- stylua: ignore
  local plugins_list = {
    modules_dir .. sep .. 'completion' .. sep .. 'plugins.lua',
    modules_dir .. sep .. 'lang' .. sep .. 'plugins.lua',
    modules_dir .. sep .. 'ui' .. sep .. 'plugins.lua',
    modules_dir .. sep .. 'editor' .. sep .. 'plugins.lua',
    modules_dir .. sep .. 'tools' .. sep .. 'plugins.lua',
  }

  if vim.g.vscode then
  -- stylua: ignore
    plugins_list = {
      modules_dir .. sep .. 'editor' .. sep .. 'plugins.lua',
      modules_dir .. sep .. 'tools' .. sep .. 'plugins.lua',
    }
  end

  local disable_modules = {}

  if fn.exists('g:disable_modules') == 1 then
    disable_modules = vim.split(vim.g.disable_modules, ',')
  end

  for _, f in pairs(plugins_list) do
    if win then
      f = string.gsub(f, '/', '\\')
    end
    local _, pos = f:find(modules_dir)
    if pos then
      f = f:sub(pos - 6, #f - 4)
    end
    -- lprint(f) -- modules/completion/plugins ...
    if not vim.tbl_contains(disable_modules, f) then
      local plugins = require(f)
      plugins(lazy.add)
      lprint('loaded ' .. f, vim.uv.now() - start)
    end
  end
  lprint('lazy modules loaded', vim.loop.now() - start)
end

function lazy:boot_strap()
  local start = uv.now()
  local lazy_path = string.format('%s%slazy%slazy.nvim', helper.get_data_path(), sep, sep)
  local state = uv.fs_stat(lazy_path)
  if not state then
    local cmd = '!git clone https://github.com/folke/lazy.nvim ' .. lazy_path
    vim.cmd(cmd)
  end
  vim.opt.runtimepath:prepend(lazy_path)
  local lz = require('lazy')
  local opts = {
    lockfile = helper.get_data_path() .. sep .. 'lazy-lock.json',
    dev = { path = win and global.home .. '\\github\\ray-x' or '~/github/ray-x' },
  }
  self:load_modules_lazy()
  lz.setup(self.plug, opts)
  lprint(' lazy boot_strap ', vim.uv.now() - start)
end

return lazy
