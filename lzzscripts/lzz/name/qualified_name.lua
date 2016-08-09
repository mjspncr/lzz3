-----------------------------------------------------------------------------
-- qualified name
-----------------------------------------------------------------------------

local QualifiedName = class ()
function QualifiedName:__init (nested_name, name)
   -- if nested_name nil then name qualified in file scope
   self.nested_name = nested_name
   self.name = name
end

-- accept visitor
function QualifiedName:accept (visitor)
   return visitor:onQualifiedName (self)
end

return QualifiedName
