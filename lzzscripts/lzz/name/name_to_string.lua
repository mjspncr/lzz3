-----------------------------------------------------------------------------
-- get name as string
-----------------------------------------------------------------------------

local NameToString = {}

-- return name as string
local function nameToString(name)
   return name:accept(NameToString)
end

-- on qualified name
function NameToString:onQualifiedName(name)
   local s = '::' .. name.name:accept(self)
   if name.nested_name then
      return name.nested_name:accept(self) .. s
   end
   return s
end

-- on template name
function NameToString:onTemplateName(name)
   -- avoid >>
   local args = name.args
   if string.sub(args, -1) == '>' then
      return string.format('%s <%s >', name.base_name:accept(self), name.args)
   else
      return string.format('%s <%s>',  name.base_name:accept(self), name.args)
   end
end

-- on simple name
function NameToString:onSimpleName(name)
   return name.ident
end

-- on dtor name
function NameToString:onDtorName(name)
   return '~ ' .. name.ident
end

-- on oper name
function NameToString:onOperName(name)
   return 'operator ' .. name.oper
end

return nameToString
