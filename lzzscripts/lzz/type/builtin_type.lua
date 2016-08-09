-----------------------------------------------------------------------------
-- builtin type
-----------------------------------------------------------------------------

local BuiltinType = class ()
function BuiltinType:__init (cv, builtin)
   self.cv = cv
   self.builtin = builtin
end

-- accept visitor
function BuiltinType:accept (visitor)
   return visitor:onBuiltinType (self)
end

return BuiltinType
