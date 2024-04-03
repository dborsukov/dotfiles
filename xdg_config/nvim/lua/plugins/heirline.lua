return {
  'rebelot/heirline.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    vim.o.showmode = false

    local utils = require('heirline.utils')
    local devicons = require('nvim-web-devicons')
    local conditions = require('heirline.conditions')

    local colors = {
      fg = utils.get_highlight('NormalFloat').fg,
      bg = utils.get_highlight('NormalFloat').bg,
    }

    local SPACE = { provider = ' ' }
    local SPRING = { provider = '%=' }

    local ViMode = {
      init = function(self)
        self.mode = vim.fn.mode(1):sub(1, 1):lower()
      end,

      static = {
        modes = {
          n = { name = 'N', color = utils.get_highlight('Character').fg },
          i = { name = 'I', color = utils.get_highlight('Special').fg },
          v = { name = 'V', color = utils.get_highlight('Repeat').fg },
          ['\22'] = { name = 'V', utils.get_highlight('Repeat').fg },
          c = { name = 'C', color = utils.get_highlight('Keyword').fg },
        },
      },

      provider = function(self)
        local mode = self.modes[self.mode]
        if mode then
          return ' ' .. mode.name .. ' '
        else
          return ' ?' .. self.mode .. '? '
        end
      end,

      hl = function(self)
        local mode = self.modes[self.mode]
        if mode then
          return { fg = 'bg', bg = mode.color, bold = true }
        else
          return { fg = 'white', bg = 'black', bold = true }
        end
      end,

      update = {
        'ModeChanged',
        pattern = '*:*',
        callback = vim.schedule_wrap(function()
          vim.cmd('redrawstatus')
        end),
      },
    }

    local FileNameBlock = {
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
      end,
    }

    local FileIcon = {
      init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ':e')
        self.icon, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
      end,
      provider = function(self)
        return self.icon and (self.icon .. ' ')
      end,
      hl = function(self)
        return { fg = self.icon_color }
      end,
    }

    local FileName = {
      provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ':.')
        if filename == '' then
          return '[No Name]'
        end
        if not conditions.width_percent_below(#filename, 0.4) then
          filename = vim.fn.pathshorten(filename)
        end
        return filename
      end,
      hl = { fg = utils.get_highlight('NormalFloat').fg },
    }

    local FileFlags = {
      {
        condition = function()
          return vim.bo.modified
        end,
        provider = ' [+]',
        hl = { fg = utils.get_highlight('DiffChange').fg },
      },
      {
        condition = function()
          return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = ' [ro]',
        hl = { fg = utils.get_highlight('DiffChange').fg },
      },
    }

    FileNameBlock = utils.insert(FileNameBlock, FileIcon, FileName, FileFlags)

    local Git = {
      condition = conditions.is_git_repo,

      init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.head_exists = self.status_dict.head ~= ''
        self.has_changes = self.head_exists
          and (self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0)
        self.untracked = self.head_exists
          and (self.status_dict.added == nil or self.status_dict.removed == nil or self.status_dict.changed == nil)
      end,

      hl = { fg = utils.get_highlight('Constant').fg },

      {
        provider = function(self)
          if self.head_exists then
            return ' ' .. self.status_dict.head
          else
            return ' [No HEAD]'
          end
        end,
        hl = { bold = true },
      },
      {
        condition = function(self)
          return self.has_changes
        end,
        provider = '[',
        hl = { bold = true },
      },
      {
        condition = function(self)
          return self.untracked
        end,
        provider = 'untracked',
        hl = { fg = utils.get_highlight('DiffDelete').fg, bold = true },
      },
      {
        provider = function(self)
          local count = self.status_dict.added or 0
          return count > 0 and ('+' .. count)
        end,
        hl = { fg = utils.get_highlight('DiffAdd').fg },
      },
      {
        provider = function(self)
          local count = self.status_dict.removed or 0
          return count > 0 and ('-' .. count)
        end,
        hl = { fg = utils.get_highlight('DiffDelete').fg },
      },
      {
        provider = function(self)
          local count = self.status_dict.changed or 0
          return count > 0 and ('~' .. count)
        end,
        hl = { fg = utils.get_highlight('DiffChange').fg },
      },
      {
        condition = function(self)
          return self.has_changes
        end,
        provider = ']',
        hl = { bold = true },
      },
    }

    local LSP = {
      init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      end,
      update = { 'BufEnter', 'LspAttach', 'LspDetach', 'DiagnosticChanged' },
      {
        condition = conditions.lsp_attached,
        {
          provider = function()
            local names = {}
            for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
              table.insert(names, server.name)
            end
            return ' [' .. table.concat(names, ' ')
          end,
        },
        {
          provider = function()
            return ']'
          end,
        },
        hl = { fg = utils.get_highlight('DiffAdd').fg },
      },
      {
        condition = conditions.has_diagnostics,
        hl = { bold = true },
        {
          provider = function()
            return '['
          end,
          hl = { bold = false },
        },
        {
          provider = function(self)
            return self.errors > 0 and ' E:' .. self.errors
          end,
          hl = { fg = utils.get_highlight('DiagnosticError').fg },
        },
        {
          provider = function(self)
            return self.warnings > 0 and ' W:' .. self.warnings
          end,
          hl = { fg = utils.get_highlight('DiagnosticWarn').fg },
        },
        {
          provider = function(self)
            return self.info > 0 and ' I:' .. self.info
          end,
          hl = { fg = utils.get_highlight('DiagnosticInfo').fg },
        },
        {
          provider = function(self)
            return self.hints > 0 and ' H:' .. self.hints
          end,
          hl = { fg = utils.get_highlight('DiagnosticHint').fg },
        },
        {
          provider = function()
            return ' ]'
          end,
          hl = { bold = false },
        },
      },
    }

    local Ruler = {
      provider = '[%3l:%2c]',
    }

    require('heirline').setup({
      statusline = {
        ViMode,
        SPACE,
        Git,
        SPRING,
        FileNameBlock,
        SPRING,
        LSP,
        Ruler,
        hl = { bg = 'bg' },
      },
      opts = {
        colors = colors,
      },
    })
  end,
}
