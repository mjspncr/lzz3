-----------------------------------------------------------------------------
-- pointer type
-----------------------------------------------------------------------------

local PointerType = class ()
function PointerType:__init (cv, to_tp)
   self.cv = cv
   self.to_tp = to_tp
end

-- accept visitor
function PointerType:accept (visitor)
   return visitor:onPointerType (self)
end

return PointerType
