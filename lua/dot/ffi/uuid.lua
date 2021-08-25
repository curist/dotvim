-- https://stackoverflow.com/a/51068240/3282323
local ffi = require 'ffi'

ffi.cdef [[
typedef unsigned char uuid_t[16];
void uuid_generate_random(uuid_t);
void uuid_unparse_upper(const uuid_t uu, char *out);
]]
local libuuid = ffi.load 'libuuid'

local M = {}
M.uuid = function()
  local uuidbin = ffi.new('uuid_t')
  local uuid = ffi.new('char[?]', 37)
  libuuid.uuid_generate_random(uuidbin)
  libuuid.uuid_unparse_upper(uuidbin, uuid)
  return ffi.string(uuid)
end

return M
