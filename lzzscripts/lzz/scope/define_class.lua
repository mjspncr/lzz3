-----------------------------------------------------------------------------
-- define class in scope
-----------------------------------------------------------------------------
local ClassDefnEntity     = require 'lzz/entity/class_defn_entity'
local ClassScope          = require 'lzz/scope/class_scope'
local addEntity           = require 'lzz/misc/add_entity'
-----------------------------------------------------------------------------

local DefineClass = class ()
function DefineClass:__init (cls_defn)
   self.cls_defn = cls_defn
end

-- define class, return class scope
local function defineClass (scope, cls_def)
   return ClassScope (scope:accept (DefineClass (cls_def)))
end

-- in namespace
function DefineClass:onNs (ns)
   return addEntity (ns, self:buildEntity ())
end

-- in class
function DefineClass:onClassDefn (cls_defn)
   return addEntity (cls_defn, self:buildEntity ())
end

-- tmpl spec
function DefineClass:onTmplSpec (parent, tmpl_spec)
   tmpl_specs = self.tmpl_specs or {}
   table.insert (tmpl_specs, tmpl_spec)
   self.tmpl_specs = tmpl_specs
   return parent:accept (self)
end

-- build entity
function DefineClass:buildEntity ()
   local cls_defn = self.cls_defn
   if self.tmpl_specs then
      cls_defn.tmpl_specs = self.tmpl_specs
   end
   return setmetatable (cls_defn, ClassDefnEntity)
end

return defineClass
