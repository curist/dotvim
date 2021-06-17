local dot = require("dot.utils")

local M = {}

local state = {["active-list"] = ""}
local function active_list()
  return state["active-list"]
end
local function is_qf_open_3f()
  local function _1_(_241)
    return ("qf" == vim.fn.getwinvar(_241, "&ft"))
  end
  local function _2_(_241)
    return (0 == ((vim.fn.getwininfo(_241))[1]).loclist)
  end
  return (#dot.filter(dot.filter(vim.api.nvim_tabpage_list_wins(0), _1_), _2_) == 1)
end
local function has_loclist_3f()
  return (#vim.fn.getloclist(vim.fn.winnr()) > 0)
end
local function is_loclist_open_3f()
  local win_loc_info = vim.fn.getloclist(0, {winid = true})
  return (win_loc_info.winid > 0)
end
local function open_list()
  local cmd
  if (active_list() == "q") then
    cmd = "copen"
  else
    cmd = "lopen"
  end
  return vim.cmd((cmd .. 10))
end
local function close_list()
  local cmd
  if (active_list() == "q") then
    cmd = "cclose"
  else
    cmd = "lclose"
  end
  return vim.cmd(cmd)
end
local function set_alter_list()
  local kind
  if (active_list() == "q") then
    kind = "l"
  else
    kind = "q"
  end
  state["active-list"] = kind
  return nil
end

function M.set_list()
  local wininfo = vim.fn.getwininfo(vim.fn.win_getid())[1]
  local isloc = (1 == wininfo.loclist)
  local kind
  if isloc then
    kind = "l"
  else
    kind = "q"
  end
  state["active-list"] = kind
  return nil
end

function M.toggle_list()
  if is_loclist_open_3f() then
    state["active-list"] = "l"
    close_list()
    return
  end
  if ("q" == active_list()) then
    if is_qf_open_3f() then
      return close_list()
    else
      return open_list()
    end
  else
    if has_loclist_3f() then
      return open_list()
    else
      set_alter_list()
      return M.toggle_list()
    end
  end
end

local function safe_list_move(list_type, direction)
  local cmd = (list_type .. direction)
  local ok_3f, _ = pcall(vim.cmd, cmd)
  local wrap_cmd
  local function _1_()
    if (direction == "next") then
      return "first"
    else
      return "last"
    end
  end
  wrap_cmd = (list_type .. _1_())
  if not ok_3f then
    print("no more list items")
    return pcall(vim.cmd, wrap_cmd)
  end
end

function M.local_list_next()
  if (("q" == active_list()) or not has_loclist_3f()) then
    return safe_list_move("c", "next")
  else
    return safe_list_move("l", "next")
  end
end

function M.local_list_prev()
  if (("q" == active_list()) or not has_loclist_3f()) then
    return safe_list_move("c", "prev")
  else
    return safe_list_move("l", "prev")
  end
end

return M
