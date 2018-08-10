-- lzz.actions.on_simple_actions
--

local _fsm = require('lzz.parser_fsm')
local _visit_decl_spec_seq = require('lzz.visit_decl_spec_seq')
local _visit_dcl = require('lzz.visit_dcl')

-- obj-decl -> xBVx-decl-spec-seq obj-dcl
function _fsm.Decl:onNode()
   -- decl-spec-seq may be nil, is optional
   local decl_spec
   if self[1] then
      decl_spec = _visit_decl_spec_seq.get_decl_spec(self[1])
   else 
      decl_spec = {}
   end
   return _visit_dcl.on_dcl(decl_spec, self[2])
end

-- nested-obj-decl -> simple-b-decl COMMA obj-dcl
function _fsm.NestedDecl:onNode()
   return _visit_dcl.on_dcl(self[1], self[3])
end

-- simple-b-decl -> nested-obj-decl obj-init-opt
function _fsm.SimpleDecl1:onNode()
   local decl_spec, dcl = table.unpack(self[1])
   dcl.init = self[2]
   print('declare obj')
   print(dcl.type:to_string())
   --  declareObj(app:getCurrentScope(), dcl)
   return decl_spec
end
