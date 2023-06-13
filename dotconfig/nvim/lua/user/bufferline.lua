require("bufferline").setup({
    options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, _, _)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        show_close_icon = false,
        show_buffer_close_icons = false,
        offsets = {
            {
                filetype = "NvimTree",
                text = "Explorer",
                text_align = "center",
                separator = true,
            },
        },
    },
})
