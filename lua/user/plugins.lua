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
  -- My plugins here
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim" }
  use { "JoosepAlviste/nvim-ts-context-commentstring" }
  use { "kyazdani42/nvim-web-devicons" }
  use { "kyazdani42/nvim-tree.lua" }
  use { "moll/vim-bbye" }
  use { "nvim-lualine/lualine.nvim" }
  use { "akinsho/toggleterm.nvim" }
  use { "ahmedkhalf/project.nvim" }
  use { "lewis6991/impatient.nvim" }
  use { "lukas-reineke/indent-blankline.nvim" }
  use { "goolord/alpha-nvim" }

  -- Colorschemes
  use "dracula/vim"
  use 'arcticicestudio/nord-vim'
  use { "folke/tokyonight.nvim" }
  use { "lunarvim/darkplus.nvim" }

  -- cmp plugins
  use { "hrsh7th/nvim-cmp" } -- The completion plugin
  use { "hrsh7th/cmp-buffer" } -- buffer completions
  use { "hrsh7th/cmp-path" } -- path completions
  use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-nvim-lua" }

  -- snippets
  use { "L3MON4D3/LuaSnip" } --snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

  -- LSP
  use { "neovim/nvim-lspconfig" } -- enable LSP
  use { "williamboman/nvim-lsp-installer" } -- simple to use language server installer
  use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
  use { "RRethy/vim-illuminate" }

  use { 'mfussenegger/nvim-jdtls' }

  -- Telescope
  use { "nvim-telescope/telescope.nvim" }
  use { 'rudism/telescope-dict.nvim' }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    commit = "518e27589c0463af15463c9d675c65e464efc2fe",
  }

  -- Git
  use { "lewis6991/gitsigns.nvim" }

  -- DAP
  use { "mfussenegger/nvim-dap" }
  use { "rcarriga/nvim-dap-ui" }
  use { "ravenxrz/DAPInstall.nvim" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)


--return require('packer').startup(function()
--  -- Packer can manage itself
--  use 'wbthomason/packer.nvim'
--  use 'neovim/nvim-lspconfig'
--
--  use {
--    'w0rp/ale',
--    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
--    cmd = 'ALEEnable',
--    config = 'vim.cmd[[ALEEnable]]'
--  }
--
--  use 'lewis6991/impatient.nvim'
--
--  -- use 'ryanoasis/vim-devicons'
--  -- use 'scrooloose/nerdtree'
--
--  use {
--    'kyazdani42/nvim-tree.lua', 
--    requires = {
--      'kyazdani42/nvim-web-devicons', -- optional, for file icons
--    }
--  }
--
--
--  use {
--    'nvim-telescope/telescope.nvim', tag = '0.1.0',
--    requires = { {'nvim-lua/plenary.nvim'} }
--  }
--
--  use 'frazrepo/vim-rainbow'
--  use 'tpope/vim-fugitive'
--  use 'vim-airline/vim-airline'
--  use 'vim-airline/vim-airline-themes'
--  use 'wincent/ferret'
--  use 'junegunn/fzf'
--  use 'junegunn/fzf.vim'
--
--
--  -- cmp plugins
--  use { "hrsh7th/nvim-cmp" } -- The completion plugin
--  use { "hrsh7th/cmp-buffer" } -- buffer completions
--  use { "hrsh7th/cmp-path" } -- path completions
--  use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
--  use { "hrsh7th/cmp-nvim-lsp" }
--  use { "hrsh7th/cmp-nvim-lua" }
--
--
--  -- use { 'neoclide/coc.nvim', run = 'yarn install --frozen-lockfile' }
--
--  use 'jackguo380/vim-lsp-cxx-highlight'
--
--  use 'lervag/vimtex'
----  use 'preservim/nerdcommenter'
--
---- use 'honza/vim-snippets'
--  use { "L3MON4D3/LuaSnip" } --snippet engine
--  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use
--
--  use 'arcticicestudio/nord-vim'
--  use 'cocopon/iceberg.vim'
--  use 'junegunn/seoul256.vim'
--  use 'tyrannicaltoucan/vim-deep-space'
--  -- You add plugins here  
--
--  use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter
--
--    -- DAP
--  use { "mfussenegger/nvim-dap" }
--  use { "rcarriga/nvim-dap-ui" }
--  use { "ravenxrz/DAPInstall.nvim" }
--end)
