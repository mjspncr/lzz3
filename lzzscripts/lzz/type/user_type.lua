-----------------------------------------------------------------------------
-- user type
-----------------------------------------------------------------------------

local UserType = class ()
function UserType:__init (name)
   self.name = name
end

-- accept visitor
function UserType:accept (visitor)
   return visitor:onUserType (self)
end

return UserType
