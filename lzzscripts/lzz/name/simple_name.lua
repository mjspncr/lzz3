-----------------------------------------------------------------------------
-- simple name
-----------------------------------------------------------------------------

local SimpleName = class ()
function SimpleName:__init (loc, ident)
   self.loc = loc
   self.ident = ident
end

-- accept visitor
function SimpleName:accept (visitor)
   return visitor:onSimpleName (self)
end

return SimpleName
