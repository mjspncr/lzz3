-----------------------------------------------------------------------------
-- throw spec to string
-----------------------------------------------------------------------------
local typeToString        = require 'lzz/type/type_to_string'
-----------------------------------------------------------------------------

local function throwSpecToString(throw_spec)
   -- throw spec just a list of types
   if throw_spec then
      local strs = {}
      for _, v in ipairs(throw_spec) do
         table.insert(strs, typeToString(v))
      end
      return 'throw (' .. table.concat(strs, ', ') .. ')'
   else
      return nil
   end
end

return throwSpecToString
