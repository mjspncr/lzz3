-- lzz.namespace_entity
--

-- class table
local Entity = {}
Entity.__index = Entity

-- add entity to namespace
function Entity:add_entity(entity)
   -- append to array
   table.insert(self, entity)
end

local module = {}
 
-- return new namespace entity 
function module.new(args)
   return setmetatable(args, Entity)
end

return module
