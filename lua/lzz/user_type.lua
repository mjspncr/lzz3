-- lzz.user_type
-- 
-- user type

-- class table
local Type = {}
Type.__index = Type

-- module
local module = {}

-- new user type
function module.new(name)
   return setmetatable({name=name}, Type)
end
 
return module
