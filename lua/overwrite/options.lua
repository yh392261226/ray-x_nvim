local vim = vim
local options = setmetatable({}, { __index = { global_local = {}, window_local = {} } })

local function bind_option(opts)
  for k, v in pairs(opts) do
    if v == true or v == false then
      vim.cmd('set ' .. k)
    else
      vim.cmd('set ' .. k .. '=' .. v)
    end
  end
end

function options:load_options()
  self.global_local = {}
  self.window_local = {}
  if vim.wo.diff then
    self.global_local = { foldmethod = 'diff', diffopt = 'context:0', foldlevel = 10, mouse = 'a' }
    self.window_local = {
      -- foldmethod = "expr",
      cursorline = false,
      -- noreadonly = false;
    }
    self.bw_local = {}
  else
    self.global_local = {}

    self.window_local = {
      foldmethod = 'expr',
      relativenumber = true,
      number = true,
      foldenable = true,
    }
  end
  local bw_local = {}
  bind_option(bw_local)
  for name, value in pairs(self.global_local) do
    vim.o[name] = value
  end
  for name, value in pairs(self.window_local) do
    vim.wo[name] = value
  end
  -- vim.g.python_host_prog = ""
end

options:load_options()

return options
