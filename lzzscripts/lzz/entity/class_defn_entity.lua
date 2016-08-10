-----------------------------------------------------------------------------
-- class definition entity
-----------------------------------------------------------------------------
local Entity              = require 'lzz/entity/entity'
local QualifiedName       = require 'lzz/name/qualified_name'
local appendArray         = require 'util/append_array'
local copyArray           = require 'util/copy_array'
local isExplicitTmplSpec  = require 'lzz/template/is_explicit_tmpl_spec'
local printClassDefn      = require 'lzz/class/print_class_defn'
local printMbrDefn        = require 'lzz/class/print_mbr_defn'
local tmplSpecToArg       = require 'lzz/template/tmpl_spec_to_arg'
local toTemplateName      = require 'lzz/name/to_template_name' 
-----------------------------------------------------------------------------
local ClassDefnEntity = class(Entity)

-- return class name as template name and template specs, if not template just return name
local function getClassName(cls_defn)
   local name = cls_defn.name
   local tmpl_specs = cls_defn.tmpl_specs
   if tmpl_specs and not isExplicitTmplSpec(tmpl_specs) then
      name = toTemplateName(name, tmplSpecToArg(tmpl_specs[1]))
   else
      tmpl_specs = nil
   end
   return name, tmpl_specs
end

-- namespace definition
function ClassDefnEntity.printNsDefn(cls_defn, ns)
   -- print class definition and member declarations
   local file
   if ns.unnamed then
      file = lzz.srcFile('DECL')
   else
      file = lzz.hdrFile(false, false, 'DECL')
   end
   printClassDefn(file, cls_defn, ns)
   local name, tmpl_specs = getClassName(cls_defn) 
   printMbrDefn(cls_defn, tmpl_specs, ns, name)
end

-- member definition
function ClassDefnEntity.printMbrDecl(cls_defn, file)
   printClassDefn(file, cls_defn)
end

-- member definition in namespace
function ClassDefnEntity.printMbrDefn(cls_defn, tmpl_specs, ns, nested_name)
   local name, cls_tmpl_specs = getClassName(cls_defn)
   if tmpl_specs and cls_tmpl_specs then
      tmpl_specs = appendArray(copyArray(tmpl_specs), cls_tmpl_specs)
   elseif cls_tmpl_specs then
      tmpl_specs = cls_tmpl_specs
   end
   name = QualifiedName(nested_name, name)
   return printMbrDefn(cls_defn, tmpl_specs, ns, name)
end

return ClassDefnEntity
