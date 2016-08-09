-----------------------------------------------------------------------------
-- is name qualified?
-----------------------------------------------------------------------------

-- return true if name qualified
local function isNameQualified (name)
   -- just check if has nested name, no need for visitor
   return name.nested_name ~= nil
end

return isNameQualified
