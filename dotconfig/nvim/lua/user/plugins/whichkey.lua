return {
  {
    "folke/which-key.nvim",
    config = function()
      local mappings = {
        ["F"] = { "<cmd>Telescope live_grep<cr>", "Find Text" },
        ["S"] = { "<cmd>Spectre<cr>", "Find and Replace" },
        ["e"] = { "<cmd>Neotree toggle<cr>", "Explorer" },
        ["f"] = { "<cmd>Telescope find_files<cr>", "Find File" },
        ["q"] = { "<cmd>bd<CR>", "Close buffer" },
        g = {
          name = "Git",
          R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
          b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
          c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
          j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
          k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
          l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
          o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
          p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
          r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
          s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
          u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
        },
        l = {
          name = "LSP",
          I = { "<cmd>LspInstall<cr>", "Install New" },
          M = { "<cmd>Mason<cr>", "Mason" },
          N = { "<cmd>NullLsInfo<cr>", "Null-ls info" },
          R = { "<cmd>Telescope lsp_references<cr>", "References" },
          S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
          T = { "<cmd>Telescope lsp_type_definitions<cr>", "Type Definition" },
          a = { "<cmd>CodeActionMenu<cr>", "Code Action" },
          d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
          f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
          i = { "<cmd>LspInfo<cr>", "Info" },
          j = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic" },
          k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
          r = { ":IncRename <C-R><C-W>", "Rename" },
          s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        },
        m = {
          name = "Misc",
          d = { "<cmd>BufferLineSortByDirectory<cr>", "Sort bufferline by dir" },
          e = { "<cmd>BufferLineSortByExtension<cr>", "Sort bufferline by extension" },
          h = { "<cmd>nohl<cr>", "Remove Highligh" },
          L = { "<cmd>Lazy<cr>", "Open Lazy" },
        },
        s = {
          name = "Search",
          R = { "<cmd>Telescope registerse<cr>", "Registers" },
          c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
          h = { "<cmd>Telescope help_tags<cr>", "Help tags" },
          k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
          m = { "<cmd>Telescope man_pages<cr>", "Man pages" },
          p = { "<cmd>Telescope projects<cr>", "Projects" },
          r = { "<cmd>Telescope oldfilese<cr>", "Recent files" },
        },
      }

      require("which-key").setup({
        window = {
          border = "rounded",
        },
        layout = {
          align = "center",
        },
        icons = {
          group = "",
          separator = "",
        },
        ignore_missing = true,
        show_help = false,
      })

      local opts = {
        mode = "n",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
      }

      require("which-key").register(mappings, opts)
    end,
  },
}
