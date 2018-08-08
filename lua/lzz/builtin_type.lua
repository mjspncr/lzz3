-- lzz.builtin_type
--

local _cv_spec_seq = require('lzz.cv_spec_seq')
local _builtin_spec_seq = require('lzz.builtin_spec_seq')

-- class table
local Type = {}
Type.__index = Type

-- to string
function Type:to_string()
   local builtin_string = _builtin_spec_seq.to_string(self.builtin)
   if self.cv then
      return string.format('%s %s', builtin_string, _cv_spec_seq.to_string(self.cv))
   else
      return builtin_string
   end
end

-- class module
local module = {}

-- return new builtin instance with args
--   cv
--   builtin
function module.new(args)
   return setmetatable(args, Type)
end

return module