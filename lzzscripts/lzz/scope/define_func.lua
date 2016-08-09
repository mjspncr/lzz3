-----------------------------------------------------------------------------
-- define function
-----------------------------------------------------------------------------
local addFuncDefn         = require 'lzz/misc/add_func_defn'
local append              = require 'util/append'
-----------------------------------------------------------------------------

local DefineFunc = class ()
function DefineFunc:__init (func_defn)
   self.func_defn = func_defn
end

-- define function
local function defineFunc (scope, func_defn)
   return scope:accept (DefineFunc (func_defn))
end

-- in namespace
function DefineFunc:onNs (ns)
   return self:addEntity (ns)
end

-- in class
function DefineFunc:onClassDefn (cls_defn)
   return self:addEntity (cls_defn)
end

-- in tmpl spec
function DefineFunc:onTmplSpec (parent, tmpl_spec)
   self.tmpl_specs = append (self.tmpl_specs or {}, tmpl_spec)
   return parent:accept (self)
end

-- add entity to object
function DefineFunc:addEntity (array)
   local func_defn = self.func_defn
   func_defn.tmpl_specs = self.tmpl_specs
   return addFuncDefn (array, func_defn)
end

return defineFunc
