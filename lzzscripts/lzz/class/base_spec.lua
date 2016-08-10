-----------------------------------------------------------------------------
-- base spec
-----------------------------------------------------------------------------
local appendWithSpace     = require 'util/append_with_space'
local nameToString        = require 'lzz/name/name_to_string'
-----------------------------------------------------------------------------

-- base class name with optional virtual and access specifiers 
local BaseSpec = class ()
function BaseSpec:__init (access, is_virtual, name)
   self.access = access
   self.is_virtual = is_virtual 
   self.name = name
end

-- to string
function BaseSpec:toString ()
   local str
   if self.is_virtual then
      str = appendWithSpace (str, 'virtual')
   end
   if self.access then
      str = appendWithSpace (str, self.access)
   end
   return appendWithSpace (str, nameToString (self.name))
end

return BaseSpec
