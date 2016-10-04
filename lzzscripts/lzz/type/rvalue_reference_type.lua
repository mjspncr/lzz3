-----------------------------------------------------------------------------
-- rvalue reference type
-----------------------------------------------------------------------------

local RvalueReferenceType = class()
function RvalueReferenceType:__init(to_type)
   self.to_type = to_type
end

-- accept visitor
function RvalueReferenceType:accept(visitor)
   return visitor:onRvalueReferenceType(self)
end

return RvalueReferenceType
