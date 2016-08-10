-----------------------------------------------------------------------------
-- add function definition as entity to container
-----------------------------------------------------------------------------
local FuncDefnEntity      = require 'lzz/entity/func_defn_entity'
local addEntity           = require 'lzz/misc/add_entity'
-----------------------------------------------------------------------------

function addFuncDefn (array, func_defn)
   return addEntity (array, setmetatable (func_defn, FuncDefnEntity))
end

return addFuncDefn
