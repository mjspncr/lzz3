-- lzz.visit_dcl
--
-- visit declarator
--

local _fsm = require('lzz.parser_fsm')
local _type = require('lzz.type')
local _visit_decl_spec_seq = require('lzz.visit_decl_spec_seq')

-- can use visitor to get ptr-oper types, but easier to just add class methods to do same
-- ptr-oper -> TIMES cv-spec-seq-opt
function _fsm.PtrOper1:get_type(to_type)
   return _type.new_ptr{oper='*',  to_type=to_type, cv=_visit_decl_spec_seq.get_cv(self[2])}
end

-- ptr-oper -> BITAND
function _fsm.PtrOper2:get_type(to_type)
   return _type.new_ptr{oper='&',  to_type=to_type}
end

-- ptr-oper -> AND
function _fsm.PtrOper3:get_type(to_type)
   return _type.new_ptr{oper='&&', to_type=to_type}
end

-- ptr-oper -> obj-name DCOLON TIMES cv-spec-seq-opt
function _fsm.PtrOper3:get_type(to_type)
   return _type.new_ptr_to_mbr{name=self[1], to_type=to_type, cv=_visit_decl_spec_seq.get_cv(self[4])}
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
   return {decl_spec, dcl}
end

return module
