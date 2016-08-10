-----------------------------------------------------------------------------
-- using obj entity
-----------------------------------------------------------------------------
local Entity              = require 'lzz/entity/entity'
local getNameLoc          = require 'lzz/name/get_name_loc'
local nameToString        = require 'lzz/name/name_to_string'
local printNsClose        = require 'lzz/namespace/print_ns_close'
local printNsOpen         = require 'lzz/namespace/print_ns_open'
-----------------------------------------------------------------------------
local UsingObjEntity = class (Entity)

-- print using obj to file
local function printUsingObj (file, name, ns)
   local n = printNsOpen (ns, file) 
   local str = 'using' .. ' ' .. nameToString (name)
   file:print (getNameLoc (name), str .. ';')
   printNsClose (file, n)
end

-- print in ns
function UsingObjEntity.printNsDefn (using, ns)
   -- always in src file
   return printUsingObj (lzz.srcFile ('DECL'), using.name, ns)
end

-- print in class
function UsingObjEntity.printMbrDecl (using, file)
   return printUsingObj (file, using)
end

return UsingObjEntity
