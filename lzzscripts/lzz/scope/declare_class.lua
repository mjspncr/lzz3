-----------------------------------------------------------------------------
-- declare class
-----------------------------------------------------------------------------
local ClassDeclEntity     = require 'lzz/entity/class_decl_entity'
local addEntity           = require 'lzz/misc/add_entity'
-----------------------------------------------------------------------------

local DeclareClass = class()
function DeclareClass:__init(cls_decl)
   self.cls_decl = cls_decl
end

-- declare class
local function declareClass(scope, cls_decl)
   return scope:accept(DeclareClass(cls_decl))
end

-- in namespace
function DeclareClass:onNs(ns)
   return addEntity(ns, self:buildEntity())
end

-- in class
function DeclareClass:onClassDefn(cls_defn)
   return addEntity(cls_defn, self:buildEntity())
end

-- in explicit template instantiation
function DeclareClass:onTmplInst(scope)
   self.cls_decl.is_inst = true
   return scope:accept(self)
end

-- build entity
function DeclareClass:buildEntity()
   return setmetatable(self.cls_decl, ClassDeclEntity)
end

return declareClass
