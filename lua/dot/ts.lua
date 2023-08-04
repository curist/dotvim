-- treesitter related stuff
local ts_utils = require 'nvim-treesitter.ts_utils'
local M = {}

function M.get_top_node_at_cursor()
  local node = ts_utils.get_node_at_cursor()
  local function is_root(node)
    local node_string = tostring(node)
    return node_string == '<node program>' or
      node_string == '<node source_file>' or
      node_string == '<node chunk>'
  end
  while node do
    local parent = node:parent()
    if not parent or is_root(parent) then
      break
    end
    node = parent
  end
  return not is_root(node) and node or nil
end

function M.get_top_node_text_at_cursor()
  local node = M.get_top_node_at_cursor()
  local text = ts_utils.get_node_text(node)
  local joined_text = table.concat(text, '\n')
  local globalfied_text = joined_text:gsub('^local ', '')
  return globalfied_text
end

function M.swap_nodes(node, direction)
  direction = direction or 'next'
  local ts = ts_utils
  if not node then return end
  local fn = direction == 'next' and ts.get_next_node or ts.get_previous_node
  local sibling_node = fn(node)
  if not sibling_node then return end
  ts.swap_nodes(node, sibling_node, 0, true)
end

function M.swap_nodes_at_cursor(direction)
  local node = ts_utils.get_node_at_cursor()
  M.swap_nodes(node, direction)
end

function M.swap_top_nodes_at_cursor(direction)
  local node = M.get_top_node_at_cursor()
  M.swap_nodes(node, direction)
end

function M.print_node_at_cursor()
  local node = ts_utils.get_node_at_cursor()
  print(node, ts_utils.get_node_range(node))
  ts_utils.update_selection(0, node)
  vim.schedule(function()
    vim.cmd('silent normal! "py')
  end)
end

local function get_sibling_noncomment_node(node, direction)
  local delta = direction == 'prev' and -1 or 1
  local function is_comment(node)
    return vim.fn.stridx(tostring(node), 'comment') >= 0
  end
  if not node then return nil end
  local parent = node:parent()
  if not parent then return nil end
  local good_node_indexes = {}
  local count = parent:named_child_count()
  local found_pos = -1
  for i = 0, count - 1 do
    local current_node = parent:named_child(i)
    if not is_comment(current_node) then
      table.insert(good_node_indexes, i)
    end
    if current_node == node then
      found_pos = #good_node_indexes
    end
  end
  if found_pos < 0 then return nil end
  local target_index = good_node_indexes[(found_pos + delta + count - 1) % count + 1]
  if not target_index then return nil end
  return parent:named_child(target_index)
end

local function get_next_noncomment_node(node)
  return get_sibling_noncomment_node(node, 'next')
end

local function get_prev_noncomment_node(node)
  return get_sibling_noncomment_node(node, 'prev')
end

function M.goto_top_node_at_cursor()
  local node = M.get_top_node_at_cursor()
  ts_utils.goto_node(node)
end

function M.goto_next_top_node()
  local node = M.get_top_node_at_cursor()
  local target = get_next_noncomment_node(node)
  ts_utils.goto_node(target)
end

function M.goto_prev_top_node()
  local node = M.get_top_node_at_cursor()
  local target = get_prev_noncomment_node(node)
  ts_utils.goto_node(target)
end

function M.goto_next_node()
  local node = ts_utils.get_node_at_cursor()
  local target = get_next_noncomment_node(node)
  ts_utils.goto_node(target)
end

function M.goto_prev_node()
  local node = ts_utils.get_node_at_cursor()
  local target = get_prev_noncomment_node(node)
  ts_utils.goto_node(target)
end

local function find_first_parent_with_different_range(node)
  local function has_same_range(node1, node2)
    local range1 = ts_utils.node_to_lsp_range(node1)
    local range2 = ts_utils.node_to_lsp_range(node2)
    return ((
      range1.start.line == range2.start.line and
      range1.start.character == range2.start.character
    ) or (
      range1['end'].line == range2['end'].line and
      range1['end'].character == range2['end'].character
    ))
  end
  if not node then return nil end
  local parent = node:parent()
  while parent do
    if not has_same_range(parent, node) then
      break
    end
    parent = parent:parent()
  end
  return parent
end

function M.goto_parent_node()
  local node = ts_utils.get_node_at_cursor()
  ts_utils.goto_node(find_first_parent_with_different_range(node))
end

function M.goto_child_node()
  local node = ts_utils.get_node_at_cursor()
  ts_utils.goto_node(node:named_child(0))
end

function M.fix_ts()
  local ts = vim.treesitter
  local api = vim.api

  local fixit = {}

  local default_map = {
    ["annotation"] = "TSAnnotation",

    ["attribute"] = "TSAttribute",

    ["boolean"] = "TSBoolean",

    ["character"] = "TSCharacter",
    ["character.special"] = "TSCharacterSpecial",

    ["comment"] = "TSComment",

    ["conditional"] = "TSConditional",

    ["constant"] = "TSConstant",
    ["constant.builtin"] = "TSConstBuiltin",
    ["constant.macro"] = "TSConstMacro",

    ["constructor"] = "TSConstructor",

    ["debug"] = "TSDebug",
    ["define"] = "TSDefine",

    ["error"] = "TSError",
    ["exception"] = "TSException",

    ["field"] = "TSField",

    ["float"] = "TSFloat",

    ["function"] = "TSFunction",
    ["function.call"] = "TSFunctionCall",
    ["function.builtin"] = "TSFuncBuiltin",
    ["function.macro"] = "TSFuncMacro",

    ["include"] = "TSInclude",

    ["keyword"] = "TSKeyword",
    ["keyword.function"] = "TSKeywordFunction",
    ["keyword.operator"] = "TSKeywordOperator",
    ["keyword.return"] = "TSKeywordReturn",

    ["label"] = "TSLabel",

    ["method"] = "TSMethod",
    ["method.call"] = "TSMethodCall",

    ["namespace"] = "TSNamespace",

    ["none"] = "TSNone",
    ["number"] = "TSNumber",

    ["operator"] = "TSOperator",

    ["parameter"] = "TSParameter",
    ["parameter.reference"] = "TSParameterReference",

    ["preproc"] = "TSPreProc",

    ["property"] = "TSProperty",

    ["punctuation.delimiter"] = "TSPunctDelimiter",
    ["punctuation.bracket"] = "TSPunctBracket",
    ["punctuation.special"] = "TSPunctSpecial",

    ["repeat"] = "TSRepeat",

    ["storageclass"] = "TSStorageClass",

    ["string"] = "TSString",
    ["string.regex"] = "TSStringRegex",
    ["string.escape"] = "TSStringEscape",
    ["string.special"] = "TSStringSpecial",

    ["symbol"] = "TSSymbol",

    ["tag"] = "TSTag",
    ["tag.attribute"] = "TSTagAttribute",
    ["tag.delimiter"] = "TSTagDelimiter",

    ["text"] = "TSText",
    ["text.strong"] = "TSStrong",
    ["text.emphasis"] = "TSEmphasis",
    ["text.underline"] = "TSUnderline",
    ["text.strike"] = "TSStrike",
    ["text.title"] = "TSTitle",
    ["text.literal"] = "TSLiteral",
    ["text.uri"] = "TSURI",
    ["text.math"] = "TSMath",
    ["text.reference"] = "TSTextReference",
    ["text.environment"] = "TSEnvironment",
    ["text.environment.name"] = "TSEnvironmentName",

    ["text.note"] = "TSNote",
    ["text.warning"] = "TSWarning",
    ["text.danger"] = "TSDanger",

    ["todo"] = "TSTodo",

    ["type"] = "TSType",
    ["type.builtin"] = "TSTypeBuiltin",
    ["type.qualifier"] = "TSTypeQualifier",
    ["type.definition"] = "TSTypeDefinition",

    ["variable"] = "TSVariable",
    ["variable.builtin"] = "TSVariableBuiltin",
  }

  -- compatibility shim
  local link_captures
  if ts.highlighter.hl_map then
    link_captures = function(capture, hlgroup)
      ts.highlighter.hl_map[capture] = hlgroup
    end
  elseif not vim.g.skip_ts_default_groups then
    link_captures = function(capture, hlgroup)
      api.nvim_set_hl(0, "@" .. capture, { link = hlgroup, default = true })
    end
  end

  local function link_all_captures()
    if link_captures then
      for capture, hlgroup in pairs(default_map) do
        link_captures(capture, hlgroup)
      end
    end
  end

  link_all_captures()

  function set_default_hlgroups()
    if not ts.highlighter.hl_map and not vim.g.skip_ts_default_groups then
      link_all_captures()
    end
    local highlights = {
      TSNone = { default = true },
      TSPunctDelimiter = { link = "Delimiter", default = true },
      TSPunctBracket = { link = "Delimiter", default = true },
      TSPunctSpecial = { link = "Delimiter", default = true },

      TSConstant = { link = "Constant", default = true },
      TSConstBuiltin = { link = "Special", default = true },
      TSConstMacro = { link = "Define", default = true },
      TSString = { link = "String", default = true },
      TSStringRegex = { link = "String", default = true },
      TSStringEscape = { link = "SpecialChar", default = true },
      TSStringSpecial = { link = "SpecialChar", default = true },
      TSCharacter = { link = "Character", default = true },
      TSCharacterSpecial = { link = "SpecialChar", default = true },
      TSNumber = { link = "Number", default = true },
      TSBoolean = { link = "Boolean", default = true },
      TSFloat = { link = "Float", default = true },

      TSFunction = { link = "Function", default = true },
      TSFunctionCall = { link = "TSFunction", default = true },
      TSFuncBuiltin = { link = "Special", default = true },
      TSFuncMacro = { link = "Macro", default = true },
      TSParameter = { link = "Identifier", default = true },
      TSParameterReference = { link = "TSParameter", default = true },
      TSMethod = { link = "Function", default = true },
      TSMethodCall = { link = "TSMethod", default = true },
      TSField = { link = "Identifier", default = true },
      TSProperty = { link = "Identifier", default = true },
      TSConstructor = { link = "Special", default = true },
      TSAnnotation = { link = "PreProc", default = true },
      TSAttribute = { link = "PreProc", default = true },
      TSNamespace = { link = "Include", default = true },
      TSSymbol = { link = "Identifier", default = true },

      TSConditional = { link = "Conditional", default = true },
      TSRepeat = { link = "Repeat", default = true },
      TSLabel = { link = "Label", default = true },
      TSOperator = { link = "Operator", default = true },
      TSKeyword = { link = "Keyword", default = true },
      TSKeywordFunction = { link = "Keyword", default = true },
      TSKeywordOperator = { link = "TSOperator", default = true },
      TSKeywordReturn = { link = "TSKeyword", default = true },
      TSException = { link = "Exception", default = true },
      TSDebug = { link = "Debug", default = true },
      TSDefine = { link = "Define", default = true },
      TSPreProc = { link = "PreProc", default = true },
      TSStorageClass = { link = "StorageClass", default = true },

      TSTodo = { link = "Todo", default = true },

      TSType = { link = "Type", default = true },
      TSTypeBuiltin = { link = "Type", default = true },
      TSTypeQualifier = { link = "Type", default = true },
      TSTypeDefinition = { link = "Typedef", default = true },

      TSInclude = { link = "Include", default = true },

      TSVariableBuiltin = { link = "Special", default = true },

      TSText = { link = "TSNone", default = true },
      TSStrong = { bold = true, default = true },
      TSEmphasis = { italic = true, default = true },
      TSUnderline = { underline = true },
      TSStrike = { strikethrough = true },

      TSMath = { link = "Special", default = true },
      TSTextReference = { link = "Constant", default = true },
      TSEnvironment = { link = "Macro", default = true },
      TSEnvironmentName = { link = "Type", default = true },
      TSTitle = { link = "Title", default = true },
      TSLiteral = { link = "String", default = true },
      TSURI = { link = "Underlined", default = true },

      TSComment = { link = "Comment", default = true },
      TSNote = { link = "SpecialComment", default = true },
      TSWarning = { link = "Todo", default = true },
      TSDanger = { link = "WarningMsg", default = true },

      TSTag = { link = "Label", default = true },
      TSTagDelimiter = { link = "Delimiter", default = true },
      TSTagAttribute = { link = "TSProperty", default = true },
    }

    for k, v in pairs(highlights) do
      api.nvim_set_hl(0, k, v)
    end
  end

  local augroup = api.nvim_create_augroup("NvimTreesitter", {})
  api.nvim_create_autocmd("ColorScheme", {
    group = augroup,
    callback = set_default_hlgroups,
    desc = "Set default highlights",
  })

  -- define highlights
  set_default_hlgroups()
end

return M
