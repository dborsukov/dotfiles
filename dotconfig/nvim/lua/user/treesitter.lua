require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "python",
        "html",
        "css",
        "scss",
        "javascript",
        "dockerfile",
        "bash",
        "fish",
        "lua",
        "tsx",
        "typescript",
        "yaml",
        "rust",
        "vue",
        "toml",
        "json",
        "markdown",
    },
    sync_install = true,
    ignore_install = {},
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = {},
    },
    indent = {
        enable = true,
    },
    -- required for JoosepAlviste/nvim-ts-context-commentstring
    context_commentstring = {
        enable = true
    }
}
