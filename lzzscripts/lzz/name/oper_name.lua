-----------------------------------------------------------------------------
-- oper name
-----------------------------------------------------------------------------

local OperName = class ()
function OperName:__init (loc, oper)
   self.loc = loc
   self.oper = oper
end

-- accept visitor
function OperName:accept (visitor)
   return visitor:onOperName (self)
end

return OperName
