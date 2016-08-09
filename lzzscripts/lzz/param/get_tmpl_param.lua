-----------------------------------------------------------------------------
-- get tmpl parameter
-----------------------------------------------------------------------------
local TmplParam           = require 'lzz/param/tmpl_param'
-----------------------------------------------------------------------------

local function getTmplParam (param)
   -- todo: check name
   return setmetatable (param, TmplParam)
end

return getTmplParam
