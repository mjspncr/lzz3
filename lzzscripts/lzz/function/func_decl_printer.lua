-----------------------------------------------------------------------------
-- function declaration printer
-----------------------------------------------------------------------------
local QualifiedName       = require 'lzz/name/qualified_name'
local appends             = require 'util/appends'
local getNameLoc          = require 'lzz/name/get_name_loc'
local nameToString        = require 'lzz/name/name_to_string'
local paramsToString      = require 'lzz/param/params_to_string'
local printNsClose        = require 'lzz/namespace/print_ns_close'
local printNsOpen         = require 'lzz/namespace/print_ns_open'
local printTmplSpecs      = require 'lzz/template/print_tmpl_specs'
local throwSpecToString   = require 'lzz/type/throw_spec_to_string'
local typeToString        = require 'lzz/type/type_to_string'
-----------------------------------------------------------------------------

local FuncDeclPrinter = class()
function FuncDeclPrinter:__init(qual_name)
   self.qual_name = qual_name
end

-- return declaration as string
function FuncDeclPrinter:declToString(func)
   local specs = func.specs
   local str = nil
   if func.is_inst then
      str = 'template'
   end
   if func.linkage then
      str = appends(str, appends('extern', func.linkage))
   elseif specs:isExtern() then
      str = appends(str, 'extern')
   end
   if func.friend then
      str = appends(str, 'friend')
   end
   if not self.no_inline and specs:isInline() then
      str = appends(str, 'LZZ_INLINE')
   end
   if not self.no_virtual and specs:isVirtual() then
      str = appends(str, 'virtual')
   end
   if not self.no_explicit and specs:isExplicit() then
      str = appends(str, 'explicit')
   end
   if not self.no_static and specs:isStatic() then
      str = appends(str, 'static')
   end
   local name = func.name
   if self.qual_name then
      name = QualifiedName(self.qual_name, name)
   end
   local dcl_str = appends(nameToString(name), paramsToString(func.params, self.is_decl, 'func'))
   dcl_str = appends(dcl_str, func.cv)
   if not self.no_pure and func.pure then
      dcl_str = appends(dcl_str, '= 0') 
   end
   if func.throw_spec then
      dcl_str = appends(dcl_str, throwSpecToString(func.throw_spec))
   end
   -- return type will be nil on ctor/dtor
   local t = func.tp
   if t then
      dcl_str = typeToString(t, dcl_str)
   end
   return appends(str, dcl_str)
end

-- print func decl to file, namespace optional
function FuncDeclPrinter:print(file, func, ns)
   local n = printNsOpen(ns, file) 
   -- template specs if template function
   if func.tmpl_specs then
      printTmplSpecs(file, func.tmpl_specs, self.is_decl)
   end
   file:print(getNameLoc(func.name), self:declToString(func) .. ';')
   printNsClose(file, n)
end

return FuncDeclPrinter
