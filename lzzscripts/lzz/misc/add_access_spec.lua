-----------------------------------------------------------------------------
-- add access spec as entity to container
-----------------------------------------------------------------------------
local AccessSpecEntity    = require 'lzz/entity/access_spec_entity'
local addEntity           = require 'lzz/misc/add_entity'
-----------------------------------------------------------------------------

function addAccessSpec (array, spec)
   addEntity (array, setmetatable (spec, AccessSpecEntity))
end

return addAccessSpec
