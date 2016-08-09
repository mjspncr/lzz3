-----------------------------------------------------------------------------
-- get name location
-----------------------------------------------------------------------------

local GetNameLoc = {}

-- get name location
local function getNameLoc (name)
   return name:accept (GetNameLoc)
end

-- on qualified name
function GetNameLoc:onQualifiedName (name)
   return name.name:accept (self)
end

-- on template name
function GetNameLoc:onTemplateName (name)
   return name.base_name.loc
end

-- on base name
local function onBaseName (self, name)
   return name.loc
end
GetNameLoc.onSimpleName = onBaseName
GetNameLoc.onDtorName   = onBaseName
GetNameLoc.onOperName   = onBaseName

return getNameLoc
