-----------------------------------------------------------------------------
-- define enum
-----------------------------------------------------------------------------
local EnumEntity          = require 'lzz/entity/enum_entity'
local addEntity           = require 'lzz/misc/add_entity'
-----------------------------------------------------------------------------

local DefineEnum = class ()
function DefineEnum:__init (enum)
   self.enum = enum
end

-- define entity
local function defineEnum (scope, loc, name, body)
   body.loc  = loc
   body.name = name
   return scope:accept (DefineEnum (body))
end

-- in namespace
function DefineEnum:onNs (ns)
   return addEntity (ns, self:buildEntity ())
end

-- in class definition
function DefineEnum:onClassDefn (cls_defn)
   return addEntity (cls_defn, self:buildEntity ())
end

-- build entity
function DefineEnum:buildEntity ()
   return setmetatable (self.enum, EnumEntity)
end

return defineEnum
