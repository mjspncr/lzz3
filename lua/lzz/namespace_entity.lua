-- lzz.namespace_entity
--

local _entity = {}
 
-- class table
local _Entity = {}
_Entity.__index = _Entity

-- add entity to namespace
function _Entity:add_entity(entity)
   -- append to array
   table.insert(self, entity)
end

-- return new namespace entity 
function _entity.new(args)
   return setmetatable(args, _Entity)
end

return _entity
