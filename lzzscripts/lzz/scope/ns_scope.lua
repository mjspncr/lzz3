-----------------------------------------------------------------------------
-- namespace scope
-----------------------------------------------------------------------------

local NsScope = class ()
function NsScope:__init (ns)
   self.ns = ns
end

-- accept visitor
function NsScope:accept (visitor)
   return visitor:onNs (self.ns)
end

return NsScope
