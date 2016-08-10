-----------------------------------------------------------------------------
-- pointer to member type
-----------------------------------------------------------------------------

local PointerToMemberType = class ()
function PointerToMemberType:__init (cv, to_tp, name)
   self.cv = cv
   self.to_tp = to_tp
   self.name = name
end

-- accept visitor
function PointerToMemberType:accept (visitor)
   return visitor:onPointerToMemberType (self)
end

return PointerToMemberType
