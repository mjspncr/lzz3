-----------------------------------------------------------------------------
-- using namespace
-----------------------------------------------------------------------------
local UsingNsEntity       = require 'lzz/entity/using_ns_entity'
local addEntity           = require 'lzz/misc/add_entity'
-----------------------------------------------------------------------------

local UsingNs = class ()
function UsingNs:__init (name)
   self.name = name
end

-- using namespace
local function usingNs (scope, name)
   return scope:accept (UsingNs (name))
end

-- in namespace
function UsingNs:onNs (ns)
   return self:addEntity (ns)
end

-- add entity
function UsingNs:addEntity (array)
   return addEntity (array, setmetatable ({name=self.name}, UsingNsEntity))
end

return usingNs
