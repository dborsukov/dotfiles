local telescope = require("telescope")

telescope.setup {
    defaults = {
        layout_config = {
            vertical = { width = 0.3 },
            horizontal = { width = 0.8 }
        },
        mappings = {
            i = {
                ["<C-h>"] = "which_key",
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous"
            },
            n = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous"
            }
        },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
}

telescope.load_extension("projects")
