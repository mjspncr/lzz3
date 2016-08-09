-----------------------------------------------------------------------------
-- function definition entity
-----------------------------------------------------------------------------
local Entity              = require 'lzz/entity/entity'
local FuncDeclPrinter     = require 'lzz/function/func_decl_printer'
local FuncDefnPrinter     = require 'lzz/function/func_defn_printer'
local isExplicitTmplSpec  = require 'lzz/template/is_explicit_tmpl_spec'
local isNameQualified     = require 'lzz/name/is_name_qualified'
-----------------------------------------------------------------------------
local FuncDefnEntity = class(Entity)

-- namespace definition
function FuncDefnEntity.printNsDefn(func, ns)
   -- get decl and defn files
   local decl_file, defn_file
   local specs = func.specs
   if specs:isStatic() or ns.unnamed then
      decl_file = lzz.srcFile('DECL')
      defn_file = lzz.srcFile('BODY')
   else
      local is_tmpl = func.tmpl_specs ~= nil
      local is_expl_spec = is_tmpl and isExplicitTmplSpec(func.tmpl_specs)
      local is_inline = specs:isInline()
      if not isNameQualified(func.name) then
         decl_file = lzz.hdrFile(false, false, 'DECL')
      end
      if not is_tmpl or is_expl_spec then
         if is_inline then
            defn_file = lzz.hdrFile(true, false, 'BODY')
         else
            defn_file = lzz.srcFile('BODY')
         end
      else
         defn_file = lzz.hdrFile(is_inline, true, 'BODY')
      end      
   end
   if decl_file then
      local printer = FuncDeclPrinter()
      printer.is_decl = true
      printer.no_inline = true
      printer:print(decl_file, func, ns)
   end
   -- always have definition
   local printer = FuncDefnPrinter()
   printer.is_decl = not decl_file
   printer:print(defn_file, func, nil, ns)
end

-- member declaration
function FuncDefnEntity.printMbrDecl(func, file)
   local printer
   -- definition only if friend
   if func.friend then
      printer = FuncDefnPrinter()
   else
      printer = FuncDeclPrinter()
   end
   printer.is_decl = true
   printer.no_inline = true
   printer:print(file, func)
end

-- member definition in namespace
function FuncDefnEntity.printMbrDefn(func, tmpl_specs, ns, nested_name)
   -- if friend definition in class
   if func.friend then
      return
   end
   local file
   local is_tmpl = tmpl_specs or func.tmpl_specs ~= nil
   local is_expl_spec = is_tmpl and not tmpl_specs and isExplicitTmplSpec(func.tmpl_specs)
   local is_inline = func.specs:isInline()
   if ns.unnamed or not is_inline and (not is_tmpl or is_expl_spec) then
      file = lzz.srcFile('BODY')
   else
      file = lzz.hdrFile(is_inline, is_tmpl and not is_expl_spec, 'BODY')
   end
   local printer = FuncDefnPrinter(nested_name)
   printer.no_static = true
   printer.no_explicit = true
   printer.no_virtual = true
   printer.no_pure = true
   printer:print(file, func, tmpl_specs, ns)
end

return FuncDefnEntity
