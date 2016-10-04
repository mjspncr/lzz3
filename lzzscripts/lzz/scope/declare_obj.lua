-----------------------------------------------------------------------------
-- declare object
-----------------------------------------------------------------------------
local ObjEntity           = require 'lzz/entity/obj_entity'
local Spec                = require 'lzz/misc/ftor_spec'
local addEntity           = require 'lzz/misc/add_entity'
local append              = require 'util/append'
local getNameLoc          = require 'lzz/name/get_name_loc'
-----------------------------------------------------------------------------

local DeclareObj = class()
function DeclareObj:__init(obj)
   self.obj = obj
end

-- declare object
local function declareObj(scope, obj)
   return scope:accept(DeclareObj(obj))
end

-- check obj specs
local function checkSpecs(specs)
   specs:checkSpecs1(Spec.INLINE|Spec.VIRTUAL|Spec.EXPLICIT, 'invalid specifier on object: %s')
end

-- in namespace
function DeclareObj:onNs(ns)
   local specs = self.obj.specs
   checkSpecs(specs)
   specs:checkSpecs1(Spec.MUTABLE|Spec.AUTO|Spec.REGISTER, 'invalid specifier on namespace object: %s')
   specs:checkSpecs2(Spec.EXTERN|Spec.STATIC, 'conflicting specifiers on namespace object: %s and %s')
   return self:addEntity(ns)
end

-- in class
function DeclareObj:onClassDefn(cls_defn)
   local specs = self.obj.specs
   checkSpecs(specs)
   local init = self.obj.init
   if init then
      local type, expr = table.unpack(init)
      -- if non-static member and class is functor then add init to member initilizer list
      if not specs:isStatic() and cls_defn.ctor_init then
         table.insert(cls_defn.ctor_init, {type, self.obj.name, expr})
         self.obj.init = nil
      -- otherwise must be brace or equal initilizer
      elseif type == 'paren' then
         lzz.error(getNameLoc(self.obj.name), 'non-static member can only have brace or equal initializer')
      end
   end
   return self:addEntity(cls_defn)
end

-- add obj as entity to array 
function DeclareObj:addEntity(array)
   return addEntity(array, setmetatable(self.obj, ObjEntity))
end

return declareObj
