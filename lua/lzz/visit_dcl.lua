-- lzz.visit_dcl
--
-- visit declarator
--

local _fsm = require('lzz.parser_fsm')
local _type = require('lzz.type')

-- node visitor
local Visitor = {}
Visitor.__index = Visitor

-- obj-id -> obj-name
function Visitor:onId(node)
   self.name = node[1]
end

-- fun-dcl -> fun-ptr-dcl pure-opt
function Visitor:onFunDcl(node)
   self.pure = node[2] ~= nil
   node[1]:accept(self)
end

function _fsm.PtrOper1:get_type(to_type)
   return _type.new_ptr(to_type)
end
function _fsm.PtrOper2:get_type(to_type)
   return _type.new_ref(to_type)
end

-- obj-a-dcl -> ptr-oper obj-a-dcl
function Visitor:onPtrDcl(node)
   print('onPtrDcl')
   self.type = node[1]:get_type(self.type)
   if node[2] then
      node[2]:accept(self)
   end
end

-- visit dcl, return table
local function visit_dcl(node, type)
   local dcl = {type=type}
   node:accept(setmetatable(dcl, Visitor))
   return setmetatable(dcl, nil)
end

-- module table
local module = {}

-- on dcl node, visit node and return decl_spec, dcl pair
function module.on_dcl(decl_spec, node)
   local dcl = visit_dcl(node, decl_spec.type)
   dcl.typedef = decl_spec.typedef
   dcl.friend = decl_spec.friend
   dcl.ftor_spec_seq = decl_spec.ftor_spec_seq

   print (dcl.type:to_string())

   return {decl_spec, dcl}
end

return module
