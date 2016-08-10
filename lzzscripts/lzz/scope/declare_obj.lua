-----------------------------------------------------------------------------
-- declare object
-----------------------------------------------------------------------------
local Spec                = require 'lzz/misc/ftor_spec'
local addObj              = require 'lzz/misc/add_obj'
-----------------------------------------------------------------------------

local DeclareObj = class ()
function DeclareObj:__init (obj)
   self.obj = obj
end

-- declare object
local function declareObj (scope, obj)
   return scope:accept (DeclareObj (obj))
end

-- check obj specs
local function checkSpecs (specs)
   specs:checkSpecs1 (Spec.INLINE|Spec.VIRTUAL|Spec.EXPLICIT, 'invalid specifier on object: %s')
end

-- in namespace
function DeclareObj:onNs (ns)
   local specs = self.obj.specs
   checkSpecs (specs)
   specs:checkSpecs1 (Spec.MUTABLE|Spec.AUTO|Spec.REGISTER, 'invalid specifier on namespace object: %s')
   specs:checkSpecs2 (Spec.EXTERN|Spec.STATIC, 'conflicting specifiers on namespace object: %s and %s')
   return self:addEntity (ns)
end

-- in class
function DeclareObj:onClassDefn (cls_defn)
   local specs = self.obj.specs
   checkSpecs (specs)
   local init = self.obj.init
   if not specs:isStatic () and cls_defn.ctor_init and init then
      local type, expr = table.unpack (init)
      table.insert (cls_defn.ctor_init, {type, self.obj.name, expr})
   end
   return self:addEntity (cls_defn)
end

-- add entity
function DeclareObj:addEntity (array)
   return addObj (array, self.obj)
end

return declareObj
