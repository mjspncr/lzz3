-----------------------------------------------------------------------------
-- declare function
-----------------------------------------------------------------------------
local FuncDeclEntity      = require 'lzz/entity/func_decl_entity'
local addEntity           = require 'lzz/misc/add_entity'
-----------------------------------------------------------------------------

local DeclareFunc = class ()
function DeclareFunc:__init (func_decl)
   self.func_decl = func_decl
end

-- declare function
local function declareFunc (scope, func_decl)
   return scope:accept (DeclareFunc (func_decl))
end

-- in namespace
function DeclareFunc:onNs (ns)
   local friend = self.func_decl.friend
   if friend then
      lzz.error (friend, 'friend specifier on namespace function declaration')
   end
   return addEntity (ns, self:buildEntity ())
end

-- in class
function DeclareFunc:onClassDefn (cls_defn)
   return addEntity (cls_defn, self:buildEntity ())
end

-- in explicit template instantiation
function DeclareFunc:onTmplInst (parent)
   self.func_decl.is_inst = true
   return parent:accept (self)
end

-- build entity
function DeclareFunc:buildEntity ()
   return setmetatable (self.func_decl, FuncDeclEntity)
end

return declareFunc
