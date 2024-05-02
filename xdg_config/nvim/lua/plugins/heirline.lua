return {
  'rebelot/heirline.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    vim.o.showmode = false

    local devicons = require('nvim-web-devicons')
    local conditions = require('heirline.conditions')

    local config = vim.fn['gruvbox_material#get_configuration']()
    local gruvbox_material_palette = vim.fn['gruvbox_material#get_palette'](config.background, config.foreground, config.colors_override)
    local palette = function(name)
      return gruvbox_material_palette[name][1]
    end

    local Mode = {
      init = function(self)
        self.mode = vim.fn.mode(1):sub(1, 1):lower()
      end,

      update = {
        'ModeChanged',
        pattern = '*:*',
        callback = vim.schedule_wrap(function()
          vim.cmd('redrawstatus')
        end),
      },

      static = {
        modes = {
          n = { name = 'N', color = palette('green') },
          i = { name = 'I', color = palette('yellow') },
          v = { name = 'V', color = palette('blue') },
          ['\22'] = { name = 'V', color = palette('blue') },
          c = { name = 'C', color = palette('purple') },
        },
      },

      hl = function(self)
        local mode = self.modes[self.mode]
        if mode then
          return { fg = palette('bg1'), bg = mode.color, bold = true }
        else
          return { fg = palette('fg0'), bg = palette('bg_dim'), bold = true }
        end
      end,

      provider = function(self)
        local mode = self.modes[self.mode]
        if mode then
          return ' ' .. mode.name .. ' '
        else
          return ' ?' .. self.mode .. '? '
        end
      end,
    }

    local FileBlock = {
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
        self.extension = vim.fn.fnamemodify(self.filename, ':e')
        self.icon, self.icon_color = devicons.get_icon_color(self.filename, self.extension, { default = true })
      end,

      {
        hl = function(self)
          return { fg = self.icon_color }
        end,
        provider = function(self)
          return self.icon and (self.icon .. ' ')
        end,
      },
      {
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
      },
      {
        hl = { fg = palette('green') },
        {
          condition = function()
            return vim.bo.modified
          end,
          provider = ' [+]',
        },
        {
          condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
          end,
          provider = ' [ro]',
        },
      },
    }

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

      hl = { fg = palette('orange'), bold = true },

      {
        provider = function(self)
          if self.head_exists then
            return ' ' .. self.status_dict.head
          else
            return ' [No HEAD]'
          end
        end,
      },
      {
        condition = function(self)
          return self.has_changes
        end,
        provider = '[',
      },
      {
        condition = function(self)
          return self.untracked
        end,
        hl = { fg = palette('red') },
        provider = 'untracked',
      },
      {
        hl = { fg = palette('green'), bold = false },
        provider = function(self)
          local count = self.status_dict.added or 0
          return count > 0 and ('+' .. count)
        end,
      },
      {
        hl = { fg = palette('red'), bold = false },
        provider = function(self)
          local count = self.status_dict.removed or 0
          return count > 0 and ('-' .. count)
        end,
      },
      {
        hl = { fg = palette('blue'), bold = false },
        provider = function(self)
          local count = self.status_dict.changed or 0
          return count > 0 and ('~' .. count)
        end,
      },
      {
        condition = function(self)
          return self.has_changes
        end,
        provider = ']',
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
        hl = { fg = palette('green') },
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
      },
      {
        condition = conditions.has_diagnostics,
        hl = { bold = true },
        {
          hl = { bold = false },
          provider = function()
            return '['
          end,
        },
        {
          hl = { fg = palette('red') },
          provider = function(self)
            return self.errors > 0 and ' E:' .. self.errors
          end,
        },
        {
          hl = { fg = palette('yellow') },
          provider = function(self)
            return self.warnings > 0 and ' W:' .. self.warnings
          end,
        },
        {
          hl = { fg = palette('blue') },
          provider = function(self)
            return self.info > 0 and ' I:' .. self.info
          end,
        },
        {
          hl = { fg = palette('green') },
          provider = function(self)
            return self.hints > 0 and ' H:' .. self.hints
          end,
        },
        {
          hl = { bold = false },
          provider = function()
            return ' ]'
          end,
        },
      },
    }

    local Ruler = {
      provider = '[%3l:%2c]',
    }

    require('heirline').setup({
      statusline = {
        Mode,
        { provider = ' ' },
        Git,
        { provider = '%=' },
        FileBlock,
        { provider = '%=' },
        LSP,
        Ruler,
        hl = { bg = palette('bg1'), fg = palette('fg0') },
      },
    })
  end,
}
