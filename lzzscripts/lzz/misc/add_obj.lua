-----------------------------------------------------------------------------
-- add object as entity to array
-----------------------------------------------------------------------------
local ObjEntity           = require 'lzz/entity/obj_entity'
local addEntity           = require 'lzz/misc/add_entity'
-----------------------------------------------------------------------------

function addObj (array, obj)
   return addEntity (array, setmetatable (obj, ObjEntity))
end

return addObj
