-- lzz.namespace_scope
--

local class = {}

-- class table
local Class = {}
Class.__index = Class

-- accept visitor
function Class:accept(visitor)
   return visitor:on_namespace_scope(self)
end

-- new scope
function class.new(namespace)
   return setmetatable({namespace=namespace}, Class)
end

return class
