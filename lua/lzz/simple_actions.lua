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
