-----------------------------------------------------------------------------
-- add entity to container
-----------------------------------------------------------------------------

-- and return entity
local function addEntity(array, entity)
   table.insert(array, entity)
   return entity
end

return addEntity
