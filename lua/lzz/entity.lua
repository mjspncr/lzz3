-- lzz.entity
--

local _ftor_spec_seq = require('lzz.ftor_spec_seq')
local _print_object = require('lzz.print_object')
local _print_function = require('lzz.print_function')

-- object
local ObjectEntity = {
   print_def = _print_object.print_def
}
ObjectEntity.__index = ObjectEntity

-- function
local FunctionEntity = {
   print_def = _print_function.print_def
}
FunctionEntity.__index = FunctionEntity

-- entity add methods
local function add_object(self, obj)
   table.insert(self, setmetatable(obj, ObjectEntity))
end
local function add_function(self, fun)
   table.insert(self, setmetatable(fun, FunctionEntity))
end

-- namespace
local NamespaceEntity = {
   add_object = add_object,
   add_function = add_function, 
}
NamespaceEntity.__index = NamespaceEntity
-- add namespace
function NamespaceEntity:add_namespace(ns)
   table.insert(self, setmetatable(ns, NamespaceEntity))
end   
-- print definition
function NamespaceEntity:print_def()
   for _, entity in ipairs(self) do
      entity:print_def(self)
   end
end
-- print open 
function NamespaceEntity:print_open(file)
   if self.encl_ns then
      self.encl_ns:print_open(file)
   end
   local names = self.names
   if names then
      for _, name in ipairs(names) do
         file:print(name.loc, 'namespace ' .. name.ident)
         file:print_open_brace()
      end
   elseif self.loc then
      -- unnamed
      file:print(self.loc, 'namespace')
      file:print_open_brace()
   end -- otherwise global namespace
end
-- print close 
function NamespaceEntity:print_close(file)
   if self.encl_ns then
      self.encl_ns:print_close(file)
   end
   local names = self.names
   if names then
      for _, name in ipairs(names) do
         file:print_close_brace()
      end
   elseif self.loc then
      file:print_close_brace()
   end
end

local module = {}
 
-- new namespace entity
function module.new_namespace(args)
   args.is_unnamed = args.encl_ns.is_unnamed or not args.name
   return setmetatable(args, NamespaceEntity)
end
function module.new_global_namespace()
   return setmetatable({}, NamespaceEntity)
end

return module
