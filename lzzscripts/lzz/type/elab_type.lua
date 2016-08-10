-----------------------------------------------------------------------------
-- elaborated type
-----------------------------------------------------------------------------

local ElabType = class ()
function ElabType:__init (cls_key, name)
   self.cls_key = cls_key
   self.name = name
end

-- accept visitor
function ElabType:accept (visitor)
   return visitor:onElabType (self)
end

return ElabType
