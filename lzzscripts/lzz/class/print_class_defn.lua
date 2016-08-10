-----------------------------------------------------------------------------
-- print class definition
-----------------------------------------------------------------------------
local appends             = require 'util/appends'
local baseSpecsToString   = require 'lzz/class/base_specs_to_string'
local getNameLoc          = require 'lzz/name/get_name_loc'
local nameToString        = require 'lzz/name/name_to_string'
local printMbrDecl        = require 'lzz/class/print_mbr_decl'
local printNsClose        = require 'lzz/namespace/print_ns_close'
local printNsOpen         = require 'lzz/namespace/print_ns_open'
local printTmplSpecs      = require 'lzz/template/print_tmpl_specs'
-----------------------------------------------------------------------------

-- print class head, class name and base specs
local function printHead (cls_defn, file)
   local str = appends (cls_defn.cls_key, nameToString (cls_defn.name))
   local base_specs = cls_defn.base_specs
   if base_specs and #base_specs > 0 then
      str = appends (str, ':')
      str = appends (str, baseSpecsToString (base_specs))
   end
   file:print (getNameLoc (cls_defn.name), str)
end

-- print class definition
local function printClassDefn (file, cls_defn, ns)
   local n = printNsOpen (ns, file)
   if cls_defn.tmpl_specs then
      printTmplSpecs (file, cls_defn.tmpl_specs, true)
   end
   printHead (cls_defn, file)
   file:printOpenBrace ()
   printMbrDecl (cls_defn, file)
   file:printCloseBrace (true)
   printNsClose (file, n)
end

return printClassDefn
