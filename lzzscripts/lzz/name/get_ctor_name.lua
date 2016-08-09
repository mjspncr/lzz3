-----------------------------------------------------------------------------
-- get ctor name from object name
-----------------------------------------------------------------------------

local GetCtorName = {}

-- get ctor name
local function getCtorName (name)
   return name:accept (GetCtorName)
end

-- on qualified name
function GetCtorName:onQualifiedName (name)
   return name.name:accept (self)
end

-- on template name
function GetCtorName:onTemplateName (name)
   return name.base_name
end

-- on simple name
function GetCtorName:onSimpleName (name)
   return name
end

return getCtorName
