-----------------------------------------------------------------------------
-- get type parameter
-----------------------------------------------------------------------------
local TypeParam           = require 'lzz/param/type_param'
-----------------------------------------------------------------------------

local function getTypeParam (param)
   -- todo: check name
   return setmetatable (param, TypeParam)
end

return getTypeParam
