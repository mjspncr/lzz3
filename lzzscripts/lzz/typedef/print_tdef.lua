-----------------------------------------------------------------------------
-- print typedef
-----------------------------------------------------------------------------
local appends             = require 'util/appends'
local getNameLoc          = require 'lzz/name/get_name_loc'
local nameToString        = require 'lzz/name/name_to_string'
local printNsClose        = require 'lzz/namespace/print_ns_close'
local printNsOpen         = require 'lzz/namespace/print_ns_open'
local typeToString        = require 'lzz/type/type_to_string'
-----------------------------------------------------------------------------

-- print typedef decl
local function printDecl (file, tdef)
   local str
   if tdef.linkage then
      str = appends ('extern', tdef.linkage)
   end
   local name = tdef.name
   str = appends (appends (str, 'typedef'), typeToString (tdef.tp, nameToString (name)))
   file:print (getNameLoc (name), str .. ';')
end

-- print typedef in optional namespace
local function printTdef (file, tdef, ns)
   local n = printNsOpen (ns, file)
   printDecl (file, tdef)
   printNsClose (file, n)
end

return printTdef
