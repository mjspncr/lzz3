-----------------------------------------------------------------------------
-- explicit template instantiation scope
-----------------------------------------------------------------------------

local TmplInstScope = class ()
function TmplInstScope:__init (parent)
   self.parent = parent
end

function TmplInstScope:accept (visitor)
   return visitor:onTmplInst (self.parent)
end

return TmplInstScope
