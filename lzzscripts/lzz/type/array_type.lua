-----------------------------------------------------------------------------
-- array type
-----------------------------------------------------------------------------

local ArrayType = class ()
function ArrayType:__init (to_tp, arg)
   self.to_tp = to_tp
   self.arg = arg
end

-- accept visitor
function ArrayType:accept (visitor)
   return visitor:onArrayType (self)
end

return ArrayType
