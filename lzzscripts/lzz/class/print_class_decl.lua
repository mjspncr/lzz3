-----------------------------------------------------------------------------
-- print class declaration
-----------------------------------------------------------------------------
local appends             = require 'util/appends'
local getNameLoc          = require 'lzz/name/get_name_loc'
local nameToString        = require 'lzz/name/name_to_string'
local printNsClose        = require 'lzz/namespace/print_ns_close'
local printNsOpen         = require 'lzz/namespace/print_ns_open'
-----------------------------------------------------------------------------

-- print class definition
local function printClassDecl (file, cls_decl, ns)
   local n = printNsOpen (ns, file)
   local str
   if cls_decl.is_inst then
      str = 'template'
   elseif cls_decl.is_frnd then
      str = 'friend'
   end
   str = appends (str, appends (cls_decl.cls_key, nameToString (cls_decl.name)))
   file:print (getNameLoc (cls_decl.name), str .. ';')
   printNsClose (file, n)
end

return printClassDecl
