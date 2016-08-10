-----------------------------------------------------------------------------
-- namespace entity
-----------------------------------------------------------------------------
local Entity              = require 'lzz/entity/entity'
local printNs             = require 'lzz/namespace/print_ns'
-----------------------------------------------------------------------------
local NsEntity = class (Entity)

-- print in ns
function NsEntity.printNsDefn (ns)
   printNs (ns)
end

return NsEntity
