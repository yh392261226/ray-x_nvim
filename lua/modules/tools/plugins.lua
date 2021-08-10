local tools = {}
local conf = require("modules.tools.config")

tools["kristijanhusak/vim-dadbod-ui"] = {
  cmd = {"DBUIToggle", "DBUIAddConnection", "DBUI", "DBUIFindBuffer", "DBUIRenameBuffer"},
  config = conf.vim_dadbod_ui,
  requires = {{"tpope/vim-dadbod", opt = true}},
  opt = true
}

tools["editorconfig/editorconfig-vim"] = {
  opt = true,
  cmd = {"EditorConfigReload"}
  -- ft = { 'go','typescript','javascript','vim','rust','zig','c','cpp' }
}

-- tools["wellle/targets.vim"] = {}
tools["kabouzeid/nvim-lspinstall"] = {}
tools["liuchengxu/vista.vim"] = {cmd = "Vista", setup = conf.vim_vista, opt = true}

tools["kamykn/spelunker.vim"] = {
  opt = true, fn = {"spelunker#check"}, 
  setup = conf.spelunker,
  config = conf.spellcheck,
}
tools["rhysd/vim-grammarous"] = {
  opt = true,
  cmd = {"GrammarousCheck"},
  ft = {"markdown", "txt"},
  setup = conf.grammarous
}


tools["plasticboy/vim-markdown"] = {
  ft = "markdown",
  requires = {"godlygeek/tabular"},
  cmd = {"Toc"},
  setup = conf.markdown,
  opt = true
}

tools["iamcco/markdown-preview.nvim"] = {
  ft = {"markdown", "pandoc.markdown", "rmd"},
  cmd = {"MarkdownPreview"},
  setup = conf.mkdp,
  run = 'sh -c "cd app && yarn install"',
  opt = true
}

-- nvim-toggleterm.lua ?
tools["voldikss/vim-floaterm"] = {
  cmd = {"FloatermNew", "FloatermToggle"},
  setup = conf.floaterm,
  opt = true
}
--
tools["liuchengxu/vim-clap"] = {
  cmd = {"Clap"},
  run = function() vim.fn["clap#installer#download_binary"]() end,
  setup = conf.clap,
  config = conf.clap_after
}


tools["sindrets/diffview.nvim"] = {cmd = "DiffviewOpen", config = conf.diffview}

tools["lewis6991/gitsigns.nvim"] = {
  config = conf.gitsigns,
  -- keys = {']c', '[c'},  -- load by lazy.lua
  opt = true
}

-- early stage...
-- tools['tanvirtin/vgit.nvim'] = {  -- gitsign has similar features
--   setup = function() vim.o.updatetime = 1000 end,
--   opt = true,
--   config = conf.vgit,
--   cmd = "VGit"
-- }
tools["tpope/vim-fugitive"] = {
  cmd = {"Gvsplit", "Git", "Gedit", "Gstatus", "Gdiffsplit", "Gvdiffsplit"},
  opt = true
}


tools["rmagatti/auto-session"] = {
  config = conf.session
}

tools["rmagatti/session-lens"] = {
  cmd = "SearchSession",
  config = function()
    require('session-lens').setup {
    shorten_path=true,
    previewer = true
  }
  end
}

tools['kevinhwang91/nvim-bqf'] = {
  opt = true,
  event = "CmdlineEnter",
  config = conf.bqf
}

--
tools["brooth/far.vim"] = {cmd = {"Farr", "Farf"}, config = conf.far, opt = true} -- brooth/far.vim

tools["rcarriga/vim-ultest"] = {
  run = ":UpdateRemotePlugins",
  requires = {"vim-test/vim-test", setup = conf.vim_test, opt = true},
  cmd = {"Ultest", "UltestNearest"},
  config = 'vim.cmd [[UpdateRemotePlugins]]',
  opt = true
}

return tools
