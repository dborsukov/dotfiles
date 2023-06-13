require("nvim-tree").setup({
    sort_by = "name",
    hijack_cursor = true,
    view = {
        side = "left",
        adaptive_size = true,
        hide_root_folder = false,
    },
    renderer = {
        add_trailing = false,
        highlight_git = true,
        indent_markers = {
            enable = false,
        },
        icons = {
            show = {
                file = true,
                folder = true,
            },
            webdev_colors = true,
            git_placement = "before",
            glyphs = {
                git = {
                    unstaged = "",
                    staged = "",
                    renamed = "",
                    untracked = "",
                    deleted = "",
                    ignored = "",
                },
            },
        },
        special_files = {
            "LICENSE",
            "README",
            "Makefile",
            "Dockerfile",
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = false,
        icons = {
            error = "",
            warning = "",
            hint = "",
            info = "",
        },
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 400,
        show_on_dirs = true,
    },
    actions = {
        change_dir = {
            enable = false,
            global = false,
            restrict_above_cwd = false,
        },
    },
    filters = {
        custom = {
            ".git$",
        },
    },
})
