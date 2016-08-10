-----------------------------------------------------------------------------
-- type param
-----------------------------------------------------------------------------
local nameToString        = require 'lzz/name/name_to_string'
local typeToString        = require 'lzz/type/type_to_string'
-----------------------------------------------------------------------------

local TypeParam = {}
TypeParam.__index = TypeParam

-- to string
function TypeParam:toString (is_decl)
   local strs = table.pack ('class', nameToString (self.name))
   if is_decl and self.default then
      table.insert (strs, '=')
      table.insert (strs, typeToString (self.default))
   end
   return table.concat (strs, ' ')
end

return TypeParam
