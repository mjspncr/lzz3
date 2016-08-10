-----------------------------------------------------------------------------
-- print namespace open
-----------------------------------------------------------------------------
local PrintNsOpen = class()
function PrintNsOpen:__init(file)
   self.file = file
end

-- print namespace open, return depth
local function printNsOpen(ns, file)
   if not (ns and ns.encl_ns) then
      return 0
   end
   local n = printNsOpen(ns.encl_ns, file)
   if ns.name then
      -- named
      n = n + ns.name:accept(PrintNsOpen (file))
   else
      -- unnamed
      file:print(ns.loc, 'namespace')
      file:printOpenBrace()
      n = n + 1 
   end
   return n
end

-- on qualified name
function PrintNsOpen:onQualifiedName(name)
   local n = name.nested_name:accept(self)
   return n + name.name:accept(self)
end

-- on simple name
function PrintNsOpen:onSimpleName(name)
   self.file:print(name.loc, 'namespace'..' '..name.ident)
   self.file:printOpenBrace()
   return 1
end

return printNsOpen
