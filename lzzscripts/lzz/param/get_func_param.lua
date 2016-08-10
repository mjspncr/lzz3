-----------------------------------------------------------------------------
-- get function (non type) parameter
-----------------------------------------------------------------------------
local NonTypeParam        = require 'lzz/param/non_type_param'
-----------------------------------------------------------------------------

local function getFuncParam (param)
   -- todo: check specs and name
   return setmetatable (param, NonTypeParam)
end

return getFuncParam
