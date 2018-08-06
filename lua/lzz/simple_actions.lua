-- lzz.actions.on_simple_actions
--

local fsm = require('lzz.parser_fsm')
local visit_decl_spec_seq = require('lzz.visit_decl_spec_seq')
-- 

-- obj-decl -> xBVx-decl-spec-seq obj-dcl
function fsm.Decl:onNode()
   print 'Decl:onNode'
   local decl_spec = visit_decl_spec_seq.get_decl_spec(self[1])
   --[=[
   local decl_spec
   if self[1] then
      decl_spec = getDeclSpec(self[1])
   else
      decl_spec = DeclSpecSel():getDeclSpec()
   end
   return onDcl(decl_spec, self[2])
   --]=]
end
