----------------------------------- SETUP ------------------------------------

-- Automatically install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Automatically sync on write
vim.cmd([[
  augroup packer_user_config
    autocmd!
        autocmd BufWritePost packer.lua source <afile> | PackerSync
    augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

----------------------------------- PLUGINS ----------------------------------

packer.startup(function()
    ------------------------------- GENERAL ------------------------------------

    use("wbthomason/packer.nvim")

    use("dstein64/vim-startuptime")

    use({
        "tpope/vim-repeat",
        "tpope/vim-surround",
    })

    use({
        "tpope/vim-commentary",
        "JoosepAlviste/nvim-ts-context-commentstring",
    })

    use({
        "lervag/vimtex",
    })

    use("windwp/nvim-autopairs")
    use({
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    })

    use({
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup({})
        end,
    })

    use({
        "akinsho/toggleterm.nvim",
        "godlygeek/tabular",
    })

    use({
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
    })

    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
        },
    })

    use({
        "ggandor/leap.nvim",
        config = function()
            require("leap").set_default_keymaps()
        end,
    })

    use({
        "lewis6991/impatient.nvim",
        config = function()
            require("impatient")
        end,
    })

    ------------------------------- VISUALS ------------------------------------

    use("RRethy/nvim-base16")

    use({
        "folke/which-key.nvim",
        "goolord/alpha-nvim",
        "lukas-reineke/indent-blankline.nvim",
        "norcalli/nvim-colorizer.lua",
        "nvim-lualine/lualine.nvim",
        "nvim-treesitter/nvim-treesitter",
        "onsails/lspkind.nvim",
        "sakshamgupta05/vim-todo-highlight",
        "smjonas/inc-rename.nvim",
        "stevearc/dressing.nvim",
        "weilbith/nvim-code-action-menu",
    })

    use({
        "akinsho/bufferline.nvim",
        tag = "v3.*",
        requires = "nvim-tree/nvim-web-devicons",
    })

    use({
        "winston0410/range-highlight.nvim",
        requires = "winston0410/cmd-parser.nvim",
        config = function()
            require("range-highlight").setup()
        end,
    })

    use({
        "j-hui/fidget.nvim",
	tag = "legacy",
        config = function()
            require("fidget").setup({ align = { bottom = false } })
        end,
    })

    --------------------------------- GIT --------------------------------------

    use("lewis6991/gitsigns.nvim")

    --------------------------------- LSP --------------------------------------

    use({
        "neovim/nvim-lspconfig",
        "ray-x/lsp_signature.nvim",
        "williamboman/mason-lspconfig.nvim",
        "williamboman/mason.nvim",
    })

    use({
        "saecki/crates.nvim",
        tag = "v0.3.0",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup()
        end,
    })

    -----------------------------  COMPLETION ------------------------------

    use({
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
    })

    use({
        "saadparwaiz1/cmp_luasnip",
        requires = "L3MON4D3/LuaSnip",
    })

    use("rafamadriz/friendly-snippets")

    -------------------- Sync After Bootstraping Packer ------------------------
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
