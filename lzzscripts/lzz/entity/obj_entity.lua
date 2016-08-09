-----------------------------------------------------------------------------
-- object entity
-----------------------------------------------------------------------------
local Entity              = require 'lzz/entity/entity'
local ObjPrinter          = require 'lzz/object/obj_printer'
local isNameQualified     = require 'lzz/name/is_name_qualified'
local isTypeConst         = require 'lzz/type/is_type_const'
local isTypeConstIntegral = require 'lzz/type/is_type_const_integral'
-----------------------------------------------------------------------------

local ObjEntity = class (Entity)

-- print in ns
function ObjEntity.printNsDefn (obj, ns)
   -- assume will have declaraion in header, definition in source
   local has_dcl, has_def = true, true
   local specs = obj.specs
   local is_qual = isNameQualified (obj.name)
   if specs:isStatic () or ns.unnamed then
      -- no declaration in header
      has_dcl = false
   elseif specs:isExtern () or obj.linkage then
      -- something like 'extern int i' or 'extern "C" int i', definition only if object has intializer
      has_def = obj.init ~= nil
      -- has declaration in header unless qualified definition
      has_dcl = not (has_def and is_qual)
   else
      -- if const or qualified then no declaration in header, definition in source only
      has_dcl = not (isTypeConst (obj.tp) or is_qual)
   end
   -- declaration
   if has_dcl then
      local printer = ObjPrinter ()
      printer.is_extern = true
      printer:print (lzz.hdrFile (false, false, 'DECL'), obj, nil, ns)
   end
   -- definition
   if has_def then
      local printer = ObjPrinter ()
      printer.with_init = true 
      -- if has declaration then no extern and can go in definition section
      printer.no_extern = has_dcl
      local section = has_dcl and 'BODY' or 'DECL'
      printer:print (lzz.srcFile (section), obj, nil, ns)
   end
end

-- print member in class
function ObjEntity.printMbrDecl (obj, file)
   local printer = ObjPrinter ()
   -- print initializer if static const integral object
   if obj.specs:isStatic () and isTypeConstIntegral (obj.tp) then
      printer.with_init = true
   end
   printer:print (file, obj, nil, nil)
end

-- print member in ns
function ObjEntity.printMbrDefn (obj, tmpl_specs, ns, qual_name)
   -- only if static 
   if not obj.specs:isStatic () then
      return
   end
   -- header if template
   local file
   if tmpl_specs then
      file = lzz.hdrFile (false, true, 'BODY')
   else
      file = lzz.srcFile ('BODY')
   end
   local printer = ObjPrinter (qual_name)
   printer.no_static = true
   -- if const integral then init with declaration in class definition
   if not isTypeConstIntegral (obj.tp) then
      printer.with_init = true
   end
   printer:print (file, obj, tmpl_specs, ns)
end

return ObjEntity
