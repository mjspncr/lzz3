-----------------------------------------------------------------------------
-- using namespace entity
-----------------------------------------------------------------------------
local Entity              = require 'lzz/entity/entity'
local getNameLoc          = require 'lzz/name/get_name_loc'
local nameToString        = require 'lzz/name/name_to_string'
local printNsClose        = require 'lzz/namespace/print_ns_close'
local printNsOpen         = require 'lzz/namespace/print_ns_open'
-----------------------------------------------------------------------------
local UsingNsEntity = class (Entity)

-- print using obj to file
local function printUsingNs (file, name, ns)
   local n = printNsOpen (ns, file) 
   local str = 'using namespace' .. ' ' .. nameToString (name)
   file:print (getNameLoc (name), str .. ';')
   printNsClose (file, n)
end

-- print in ns
function UsingNsEntity.printNsDefn (using, ns)
   return printUsingNs (lzz.srcFile ('DECL'), using.name, ns)
end

return UsingNsEntity
