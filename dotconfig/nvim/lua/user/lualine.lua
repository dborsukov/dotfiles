local function active_lsp_client()
    local clients = vim.lsp.get_active_clients()
    if clients[0] ~= nil then
        return clients[0].name
    else
        return clients[1].name
    end
end

require("lualine").setup {
    options = {
        icons_enabled = true,
        theme = 'base16',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {
            { 'filename',
                symbols = {
                    modified = "[+]",
                    readonly = "[RO]",
                    unnamed = "[New File]",
                }
            },
        },
        lualine_c = {
            'branch',
            'diff',
        },
        lualine_x = {
            { 'diagnostics',
                symbols = {
                    error = " ",
                    warn = " ",
                    info = " ",
                    hint = " ",
                }
            },
            active_lsp_client,
            'encoding',
            { 'fileformat',
                symbols = {
                    unix = "unix",
                    dos = "dos",
                    mac = "mac",
                }
            },
            { 'filetype',
                colored = true,
            }
        },
        lualine_y = {},
        lualine_z = {}
    },
    extensions = {
        "nvim-tree",
        "toggleterm",
        "symbols-outline",
        "quickfix",
    }
}
