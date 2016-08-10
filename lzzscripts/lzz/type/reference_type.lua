-----------------------------------------------------------------------------
-- reference type
-----------------------------------------------------------------------------

local ReferenceType = class ()
function ReferenceType:__init (to_tp)
   self.to_tp = to_tp
end

-- accept visitor
function ReferenceType:accept (visitor)
   return visitor:onReferenceType (self)
end

return ReferenceType
