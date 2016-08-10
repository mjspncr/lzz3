-----------------------------------------------------------------------------
-- access specifier entity
-----------------------------------------------------------------------------
local Entity              = require 'lzz/entity/entity'
-----------------------------------------------------------------------------

local AccessSpecEntity = class (Entity)

-- print member declaration
function AccessSpecEntity.printMbrDecl (spec, file)
   file:print (spec [1], spec [2] .. ':', -1) 
end

return AccessSpecEntity
