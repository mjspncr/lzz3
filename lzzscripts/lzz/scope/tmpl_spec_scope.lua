-----------------------------------------------------------------------------
-- template spec scope
-----------------------------------------------------------------------------

local TmplSpecScope = class ()
function TmplSpecScope:__init (parent, tmpl_spec)
   self.parent = parent
   self.tmpl_spec = tmpl_spec
end

-- accept visitor
function TmplSpecScope:accept (visitor)
   return visitor:onTmplSpec (self.parent, self.tmpl_spec)
end

return TmplSpecScope
