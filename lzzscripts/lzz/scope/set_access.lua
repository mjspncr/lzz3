-----------------------------------------------------------------------------
-- set access
-----------------------------------------------------------------------------
local addAccessSpec       = require 'lzz/misc/add_access_spec'
-----------------------------------------------------------------------------

function setAccess (scope, loc, access)
   -- can only be in class def
   addAccessSpec (scope.cls_defn, {loc, access}) 
end

return setAccess
