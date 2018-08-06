-- lzz/init.lua
--

require('lzz.actions')
local namespace_scope_class  = require('lzz.namespace_scope')
local namespace_entity_class = require('lzz.namespace_entity')

-- application class to manage state
local App = basil.state()

-- initialize state
function App:init()
   print 'init'
   self._scope_stack = {}
   self:push_scope(namespace_scope_class.new(namespace_entity_class.new({})))
end

-- push scope on stack
function App:push_scope(scope)
   table.insert(self._scope_stack, scope)
end

-- pop scope off stack
function App:pop_scope()
   table.remove(self._scope_stack)
end

-- return current scope
function App:get_current_scope()
   return self._scope_stack[#self._scope_stack]
end

function App:close()

   --[=[
   if not lzz.any_error() then
      -- do nothing
   else
      -- generate code
   end
   --]=]

end
