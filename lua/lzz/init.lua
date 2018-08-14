-- lzz/init.lua
--

require('lzz.actions')
local _entity = require('lzz.entity')
local _scope = require('lzz.scope')

-- application class to manage state
local App = basil.state()

-- initialize state
function App:init()
   self.scope_stack = {}
   self.global_namespace = _entity.new_global_namespace{}
   self:push_scope(_scope.new_namespace(self.global_namespace))
end

function App:close()
   self.global_namespace:print_def()
   --[=[
   if not lzz.any_error() then
      -- do nothing
   else
      -- generate code
   end
   --]=]
end

-- push scope on stack
function App:push_scope(scope)
   table.insert(self.scope_stack, scope)
end

-- pop scope off stack
function App:pop_scope()
   table.remove(self.scope_stack)
end

-- return current scope
function App:get_current_scope()
   return self.scope_stack[#self.scope_stack]
end

-- other methods
-- App.declare_object = require('lzz.declare_object')
