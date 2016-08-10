-----------------------------------------------------------------------------
-- using object
-----------------------------------------------------------------------------
local UsingObjEntity      = require 'lzz/entity/using_obj_entity'
local addEntity           = require 'lzz/misc/add_entity'
-----------------------------------------------------------------------------

local UsingObj = class ()
function UsingObj:__init (name)
   self.name = name
end

-- using object
local function usingObj (scope, name)
   return scope:accept (UsingObj (name))
end

-- in namespace
function UsingObj:onNs (ns)
   return self:addEntity (ns)
end

-- in class
function UsingObj:onClassDefn (cls_defn)
   return self:addEntity (cls_defn)
end

-- add entity
function UsingObj:addEntity (array)
   return addEntity (array, setmetatable ({name=self.name}, UsingObjEntity))
end

return usingObj
