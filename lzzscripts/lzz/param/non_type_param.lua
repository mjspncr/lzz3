-----------------------------------------------------------------------------
-- non-type parameter
-----------------------------------------------------------------------------
local appendWithSpace     = require 'util/append_with_space'
local nameToString        = require 'lzz/name/name_to_string'
local typeToString        = require 'lzz/type/type_to_string'
-----------------------------------------------------------------------------

local NonTypeParam = {}
NonTypeParam.__index = NonTypeParam

-- to string
function NonTypeParam:toString (is_decl)
   local str
   local specs = self.specs
   -- specs 
   -- ...
   str = appendWithSpace (str, typeToString (self.tp, nameToString (self.name)))
   if is_decl and self.default then
      str = appendWithSpace (str, '= ' .. self.default)
   end
   return str
end

return NonTypeParam
