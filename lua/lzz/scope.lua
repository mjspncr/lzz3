-- lzz.scope
--

_declare_object = require('lzz.declare_object')
_declare_function = require('lzz.declare_function')
_open_namespace = require('lzz.open_namespace')

-- namespace class
local NamespaceScope = {
   declare_object = _declare_object,
   declare_function = _declare_function,
   open_namespace = _open_namespace
}
NamespaceScope.__index = NamespaceScope
-- accept visitor
function NamespaceScope:accept(visitor)
   return visitor:on_namespace_scope(self)
end

local module = {}

-- new namespace scope
function module.new_namespace(namespace)
   return setmetatable({namespace=namespace}, NamespaceScope)
end

return module
