-- lzz.open_namespace
--

local _scope = nil

local function name_error(visitor, name)
   lzz.error(name:get_loc(), 'invalid namespace name: ' .. name:to_string())
end
local Visitor = {
   on_template_name = name_error,
}
Visitor.__index = Visitor
function Visitor:on_simple_name(name)
   table.insert(self, name)
end
function Visitor:on_qualified_name(name)
   name.nested_name:accept(self)
   name.name:accept(self)
end

local function get_names(name)
   local names = {}
   name:accept(setmetatable(names, Visitor))
   return setmetatable(names, nil)
end

-- open namespace
return function(scope, ns)
   _scope = _scope or require('lzz.scope')
   -- scope can only be a namespace scope
   local encl_ns = scope.namespace
   ns.encl_ns = encl_ns
   name = ns.name
   ns.name = nil
   if encl_ns.is_unnamed or not name then
      ns.is_unnamed = true
   end
   if name then
      ns.names = get_names(name)
   end
   encl_ns:add_namespace(ns)
   return _scope.new_namespace(ns)
end
