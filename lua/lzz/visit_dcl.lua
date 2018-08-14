-- lzz.visit_dcl
--
-- visit declarator
--

local _fsm = require('lzz.parser_fsm')
local _type = require('lzz.type')
local _visit_decl_spec_seq = require('lzz.visit_decl_spec_seq')

-- return array of param types, is_vararg=true if variable number of arguments
local function get_param_types(params)
   local types = {}
   for _, param in ipairs(params) do
      table.insert(types, param.type)
   end
   types.is_vararg = params.has_ellipse
   return types
end

-- dcl visitor
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
-- obj-a-dcl -> ptr-oper obj-a-dcl
function Visitor:onPtrDcl(node)
   local ptr_type_args = node[1]
   ptr_type_args.to_type = self.type
   self.type = _type.new_ptr_type(ptr_type_args)
   if node[2] then
      node[2]:accept(self)
   end
end
-- obj-b-direct-dcl -> obj-b-direct-dcl param-decl-1-body > RPAREN cv-spec-seq-opt throw-spec-opt
function Visitor:onDirectDcl1(node)
   -- object
   local param_types = get_param_types(node[2])
   local cv = _visit_decl_spec_seq.get_cv(self[4])
   -- TODO: throw spec
   self.type = _type.new_function_type{param_types=param_types, cv=cv, to_type=self.type}
   if node[1] then
      node[1]:accept(self)
   end
end
-- obj-b-direct-dcl -> obj-a-direct-dcl LBRACK block-opt 5 RBRACK
function Visitor:onDirectDcl2(node)
   self.type = _type.new_array_type{element_type=self.type, arg=node[3].lexeme}
   if node[1] then
      node[1]:accept(self)
   end
end
-- obj-b-direct-dcl -> LPAREN obj-b-dcl RPAREN
function Visitor:onDirectDcl3(node)
   if node[2] then
      node[2]:accept(self)
   end
end
-- fun-a-direct-dcl -> obj-dcl-id param-decl-1-body RPAREN cv-spec-seq-opt throw-spec-opt
function Visitor:onDirectDcl4(node)
   -- function
   self.params = node[2]
   self.cv = _visit_decl_spec_seq.get_cv(self[4])
   -- TODO: throw spec 
   if node[1] then
      node[1]:accept(self)
   end
end

-- visit dcl, return dcl table
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
   return {decl_spec, dcl}
end

return module
