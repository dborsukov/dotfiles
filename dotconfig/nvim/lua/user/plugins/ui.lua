return {
  -- better vim.ui
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = true,
  },
  -- impoved, visualized rename
  {
    "smjonas/inc-rename.nvim",
    event = "VeryLazy",
    opts = {
      input_buffer_type = "dressing",
      preview_empty_name = true,
    },
  },
  -- improved code actions menu
  {
    "weilbith/nvim-code-action-menu",
    event = "VeryLazy",
  },
  -- hightlights ranges entered in commandline
  {
    "winston0410/range-highlight.nvim",
    event = "VeryLazy",
    dependencies = { "winston0410/cmd-parser.nvim" },
    config = true,
  },
  -- color highlighter
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = { "css", "scss", "html", "vue" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue or blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background,  virtualtext
        mode = "virtualtext",
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = true,
        virtualtext = "■",
      },
    },
  },
  -- LSP progress indicator
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "VeryLazy",
    opts = { align = { bottom = false } },
  },
  --bufferline
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
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
    },
  },
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        icons_enabled = true,
        theme = "base16",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha" },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          {
            "filename",
            symbols = {
              modified = "[+]",
              readonly = "[RO]",
              unnamed = "[New File]",
            },
          },
        },
        lualine_c = {
          "branch",
          "diff",
        },
        lualine_x = {
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = " ",
            },
          },
          "encoding",
          {
            "fileformat",
            symbols = {
              unix = "unix",
              dos = "dos",
              mac = "mac",
            },
          },
          {
            "filetype",
            colored = true,
          },
        },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = {
        "nvim-tree",
        "toggleterm",
        "symbols-outline",
        "quickfix",
      },
    },
  },
  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "│",
      filetype_exclude = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      show_current_context = false,
    },
  },
  -- dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    init = function()
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("n", "New file", ":ene <BAR> startinsert <CR>", {}),
        dashboard.button(
          "f",
          "Find files",
          ":cd $HOME | Telescope find_files theme=dropdown previewer=false<CR>",
          {}
        ),
        dashboard.button(
          "r",
          "Recent",
          ":Telescope oldfiles theme=dropdown previewer=false<CR>",
          {}
        ),
        dashboard.button(
          "p",
          "Projects",
          ":Telescope projects theme=dropdown previewer=false<CR>",
          {}
        ),
        dashboard.button("c", "Config", ":e ~/.config/nvim/lua/ | Neotree<CR>", {}),
        dashboard.button("q", "Quit", ":qa<CR>", {}),
      }

      require("alpha").setup(dashboard.opts)

      vim.cmd([[
          autocmd FileType alpha setlocal nofoldenable
      ]])
    end,
  },
  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },
  -- ui elements
  { "MunifTanjim/nui.nvim", lazy = true },
}
