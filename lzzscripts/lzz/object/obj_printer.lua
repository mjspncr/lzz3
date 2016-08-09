-----------------------------------------------------------------------------
-- object printer
-----------------------------------------------------------------------------
local QualifiedName       = require 'lzz/name/qualified_name'
local appendWithSpace     = require 'util/append_with_space'
local getNameLoc          = require 'lzz/name/get_name_loc'
local nameToString        = require 'lzz/name/name_to_string'
local printNsClose        = require 'lzz/namespace/print_ns_close'
local printNsOpen         = require 'lzz/namespace/print_ns_open'
local printTmplSpecs      = require 'lzz/template/print_tmpl_specs'
local typeToString        = require 'lzz/type/type_to_string'
-----------------------------------------------------------------------------

local ObjPrinter = class ()
function ObjPrinter:__init (qual_name)
   self.qual_name = qual_name
end

-- return declaration as string, everything up to and including type
function ObjPrinter:declToString (obj)
   local specs = obj.specs
   local str
   if obj.linkage then
      str = appendWithSpace (appendWithSpace (str, 'extern'), obj.linkage)
   elseif not self.no_extern and (self.is_extern or specs:isExtern ()) then
      str = appendWithSpace (str, 'extern')
   end
   if not self.no_static and specs:isStatic () then
      str = appendWithSpace (str, 'static')
   end
   if specs:isMutable () then
      str = appendWithSpace (str, 'mutable')
   end
   local name = obj.name
   if self.qual_name then
      name = QualifiedName (self.qual_name, name)
   end
   return appendWithSpace (str, typeToString (obj.tp, nameToString (name)))
end

-- print object to file, namespace optional
function ObjPrinter:print (file, obj, tmpl_specs, ns)
   local n = printNsOpen (ns, file) 
   if tmpl_specs then
      printTmplSpecs (file, tmpl_specs)
   end
   local str = self:declToString (obj)
   if self.with_init and obj.init then
      local type, expr = table.unpack (obj.init)
      if type == 'assign' then
         init_str = ' = ' .. expr
      elseif type == 'paren' then
         init_str = ' (' .. expr .. ')'
      end
      str = str .. init_str
   end
   file:print (getNameLoc (obj.name), str .. ';')
   printNsClose (file, n)
end

return ObjPrinter
