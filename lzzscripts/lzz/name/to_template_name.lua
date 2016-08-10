-----------------------------------------------------------------------------
-- to template name
-----------------------------------------------------------------------------
local TemplateName        = require 'lzz/name/template_name'
local QualifiedName       = require 'lzz/name/qualified_name'
-----------------------------------------------------------------------------

local ToTemplateName = class ()
function ToTemplateName:__init (args)
   self.args = args
end

-- convert name to template name with args
local function toTemplateName (name, args)
   return name:accept (ToTemplateName (args))
end

-- on template name
function ToTemplateName:onTemplateName (name)
   -- do nothing, just return name
   return name
end

-- on qualified name
function ToTemplateName:onQualifiedName (name)
   return QualifiedName (name:getNestedName (), name.name:accept (self))
end

-- on base name
local function onBaseName (self, name)
   return TemplateName (false, name, self.args)
end
ToTemplateName.onSimpleName = onBaseName
ToTemplateName.onDtorName   = onBaseName
ToTemplateName.onOperName   = onBaseName

return toTemplateName
