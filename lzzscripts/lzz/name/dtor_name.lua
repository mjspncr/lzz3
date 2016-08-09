-----------------------------------------------------------------------------
-- dtor name
-----------------------------------------------------------------------------

local DtorName = class ()
function DtorName:__init (loc, ident)
   self.loc = loc
   self.ident = ident
end

-- accept visitor
function DtorName:accept (visitor)
   return visitor:onDtorName (self)
end

return DtorName
