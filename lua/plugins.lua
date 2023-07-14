local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here.
  -- Have packer manage itself.
  use "wbthomason/packer.nvim"

  -- Colorschemes --
  use "lunarvim/darkplus.nvim"

  -- Completion --
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      {"hrsh7th/cmp-buffer"},
      {"hrsh7th/cmp-path"},
      {"hrsh7th/cmp-cmdline"},
      {
        "saadparwaiz1/cmp_luasnip", -- Bridge cmp and snippets.
        requires = {
          {"L3MON4D3/LuaSnip"}, -- Snippets engine.
          {"rafamadriz/friendly-snippets"} -- Snippets collection.
        },
      },
      {"hrsh7th/cmp-nvim-lsp"}, -- Bridge cmp and lsp.
    }
  }

  -- LSP --
  use {
    "neovim/nvim-lspconfig", -- Enable LSP.
    requires = {
      {"williamboman/mason.nvim"}, -- LSP Servers Manager.
      {"williamboman/mason-lspconfig.nvim"}, -- Bridge manson and lsp.
    }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
