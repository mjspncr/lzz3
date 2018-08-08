-- lzz.namespace_scope
--

-- class table
local Scope = {}
Scope.__index = Scope

-- accept visitor
function Scope:accept(visitor)
   return visitor:on_namespace_scope(self)
end

local module = {}

-- new scope
function module.new(namespace)
   return setmetatable({namespace=namespace}, Scope)
end

return module
