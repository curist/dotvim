return {
  'itchyny/lightline.vim',
  init = function()
    vim.g.lightline = {
      colorscheme = 'one',
      mode_map = {
        n = 'N',
        i = 'I',
        R = 'R',
        v = 'V',
        V = 'V',
        c = 'C',
        t = 'T',
        [''] = 'V',
      },
      active = {
        left = {
          { 'mode' }, { 'fileencoding' }, { 'filename' },
        },
        right = {
          { 'lineinfo' }, { 'githead' }, { 'filetype' }, { 'fileformat' },
          { 'macro' },
        },
      },
      inactive = {
        left = { { 'filename' } },
        right = {},
      },
      component = {
        fileencoding = "%{&fenc=='utf-8'?'':&fenc}",
        fileformat = "%{&ff=='unix'?'':&ff}",
        lineinfo = '%3l:%-2c',
      },
      component_function = {
        filename = 'v:lua.LightlineFilename',
        githead = 'v:lua.LightlineGitHead',
        filetype = 'v:lua.LightlineFileType',
        macro = 'v:lua.LightlineMacro',
      },
    }

    --- smartPath shortens the path to the current file, when it's too long
    --- @param path string
    --- @param width number, optional, ratio of the window width
    local function smartPath(path, width)
      width = width or 0.4
      local len = #path
      local winwidth = vim.fn.winwidth(0)
      local maxwidth = math.floor(winwidth * width)
      -- if path is short enough, don't do anything
      if len < maxwidth then
        return path
      end
      local parts = vim.fn.split(path, '/')
      -- now, we want to add as much as parts as we can,
      -- while still keeping the path not exceeding the maxwidth

      -- we always want last part to be not shortened
      local base = parts[#parts]
      local current_len = #base
      local result = {base}
      local busted = false

      for i = #parts - 1, 1, -1 do
        local part = parts[i]
        local part_len = #part
        if busted then
          local ch = part:sub(1, 1)
          table.insert(result, 1, ch)
        else
          if current_len + part_len + 1 > maxwidth then
            local ch = part:sub(1, 1)
            table.insert(result, 1, ch)
            busted = true
            -- no need to count anymore, we're busted
          else
            current_len = current_len + part_len + 1
            table.insert(result, 1, part)
          end
        end
      end
      return table.concat(result, '/')
    end

    local function Mod()
      if vim.bo.readonly then
        return ' -'
      elseif vim.bo.modified then
        return ' +'
      end
      return ''
    end

    function LightlineFilename()
      local filename = vim.fn.expand('%:~:.'):gsub("^oil://", "")
      local name = smartPath(filename, 0.45) .. Mod()
      return name
    end

    function LightlineGitHead()
      local githead = vim.g.gitsigns_head or ''
      if #githead < 20 then
        return githead
      end
      -- trim githead if it's too long
      return githead:sub(1, 18) .. '…'
    end

    function LightlineFileType()
      if vim.bo.buftype == 'terminal' then
        return 'terminal'
      end
      local filetype = vim.bo.filetype
      return filetype
    end

    function LightlineMacro()
      local reg = vim.fn.reg_recording()
      if reg ~= "" then
        return "@" .. reg
      end
      return ""
    end
  end,
}
