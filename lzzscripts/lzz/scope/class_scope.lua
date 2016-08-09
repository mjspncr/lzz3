-----------------------------------------------------------------------------
-- class scope
-----------------------------------------------------------------------------

local ClassScope = class ()
function ClassScope:__init (cls_defn)
   self.cls_defn = cls_defn
end

-- accept visitor
function ClassScope:accept (visitor)
   return visitor:onClassDefn (self.cls_defn)
end

return ClassScope
