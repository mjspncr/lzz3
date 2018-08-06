-- lzz.cv_spec_seq
--

local class = {}

-- class table
local Class = {}
Class.__index = Class

-- flags
local CONST = 1 << 0
local VOLATILE = 1 << 1
-- combinations
local CONST_VOLATILE = CONST|VOLATILE

-- spec flags
local flags =
{
   ['const'] = CONST,
   ['volatile'] = VOLATILE,
}

-- normalized flags
local normalized =
{
   [CONST] = CONST,
   [VOLATILE] = VOLATILE,
   [CONST_VOLATILE] = CONST_VOLATILE
}

-- normalized flags to name 
local names =
{
   [CONST] = 'const',
   [VOLATILE] = 'volatile',
   [CONST_VOLATILE] = 'const volatile',
}   
   
-- add specifier, return false if not valid
function Class:add(token)
   local flag = flags[token.lexeme]
   if self.flags & flag ~= 0 then
      lzz.warning(token.loc, 'duplicate specifier: '..token.lexeme)
   else
      self.flags = self.flags | flag
   end
end

-- get cv constant
function Class:get_cv()
   if self.flags > 0 then
      return self.flags
   else
      return nil
   end
end

-- return new object
function class.new()
   local self = {
      flags = 0,
   }
   return setmetatable(self, Class)
end

-- cv constant to string
function class.to_string(cv)
   return names[cv]
end

return class