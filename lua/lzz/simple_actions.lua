-- lzz.actions.on_simple_actions
--

local _fsm = require('lzz.parser_fsm')
local _visit_decl_spec_seq = require('lzz.visit_decl_spec_seq')
local _visit_dcl = require('lzz.visit_dcl')
local _param = require('lzz.param')

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

--
-- ptr-oper
--
-- ptr-oper -> TIMES cv-spec-seq-opt
function _fsm.PtrOper1:onNode()
   return {oper='*', cv=_visit_decl_spec_seq.get_cv(self[2])}
end
-- ptr-oper -> BITAND
function _fsm.PtrOper2:onNode()
   return {oper='&'}
end
-- ptr-oper -> obj-name DCOLON TIMES cv-spec-seq-opt
function _fsm.PtrOper3:onNode()
   return {oper=self[1]:to_string() .. '::*', cv=_visit_decl_spec_seq.get_cv(self[4])}
end
-- ptr-oper -> AND
function _fsm.PtrOper4:onNode()
   return {oper='&&'}
end

--
-- param decl
--
-- get type and template params
local GetParams = {}
GetParams.__index = GetParams
-- param-decl-1-list <* -> LPAREN param-init-decl
function GetParams:onParamDeclList1(node)
   table.insert(self, node[2])
end
-- param-decl-1-list -> param-decl-1-list COMMA param-init-decl
function GetParams:onParamDeclList2(node)
   node[1]:accept(self)
   table.insert(self, node[3])
end
-- tmpl-param-list -> tmpl-param
function GetParams:onTmplParamList1(node)
   table.insert(self, node[1])
end
-- tmpl-param-list -> tmpl-param-list COMMA tmpl-param
function GetParams:onTmplParamList2(node)
   node[1]:accept(self)
   table.insert(self, node[3])
end
-- collect params from param decl list
local function get_params(node)
   local params = {}
   node:accept(setmetatable(params, GetParams))
   return setmetatable(params, nil)
end

-- param-init-decl <* -> param-decl
function _fsm.ParamDecl1:onNode()
   local decl_spec, dcl = table.unpack(self[1])
   return _param.new_non_type_param(dcl)
end
-- param-init-decl <* -> param-decl ASSIGN block 4
function _fsm.ParamDecl2:onNode()
   local decl_spec, dcl = table.unpack(self[1])
   dcl.default_arg = self[3].lexeme
   return _param.new_non_type_param(dcl)
end

-- param-decl-1-body -> param-decl-1-list ellipse-opt
function _fsm.ParamDeclBody1:onNode()
   local params = get_params(self[1])
   params.has_ellipse = self[2] ~= nil
   return params
end
-- param-decl-1-body -> param-decl-1-list COMMA ELLIPSE
function _fsm.ParamDeclBody2:onNode()
   local params = get_params(self[1])
   params.has_ellipse = true
   return params
end
-- param-decl-1-body -> LPAREN ellipse-opt
function _fsm.ParamDeclBody3:onNode()
   local params = {}
   params.has_ellipse = self[2] ~= nil
   return params
end
-- param-decl-1-body -> LPAREN VOID
function _fsm.ParamDeclBody4:onNode()
   local params = {}
   params.has_ellipse = false
   return params
end

-- nested-obj-decl -> simple-b-decl COMMA obj-dcl
function _fsm.NestedDecl:onNode()
   return _visit_dcl.on_dcl(self[1], self[3])
end
-- simple-b-decl -> nested-obj-decl obj-init-opt
function _fsm.SimpleDecl1:onNode(state)
   local decl_spec, dcl = table.unpack(self[1])
   dcl.init = self[2]
   state:get_current_scope():declare_object(dcl)
   return decl_spec
end
-- simple-b-decl -> nested-fun-decl
function _fsm.SimpleDecl2:onNode(state)
   local decl_spec, dcl = table.unpack(self[1])
   if decl_spec.typedef then
      -- TODO: declare typedef
   else
      state:get_current_scope():declare_function(dcl)
   end
end

-- fun-def -> fun-decl try-opt ctor-init-opt LBRACE block-opt RBRACE handler-seq-opt
function _fsm.FunDef:onNode(state)
   local decl_spec, dcl = table.unpack(self[1])
   dcl.is_defn = true
   dcl.body = self[5]
   --dcl.ctor_init = self[3]
   --dcl.handlers = self[7]
   state:get_current_scope():declare_function(dcl)
end

-- obj-init -> ASSIGN block 3
function _fsm.ObjInit1:onNode()
   return {'= %s', self[2].lexeme}
end
-- obj-init -> DINIT LPAREN block 2 RPAREN
function _fsm.ObjInit2:onNode()
   return {'(%s)', self[3].lexeme}
end
-- obj-init -> LBRACE block 7 RBRACE
function _fsm.ObjInit3:onNode()
   return {'{%s}', self[2].lexeme}
end

--
-- namespace
--

-- open-namespace -> NAMESPACE obj-name LBRACE
function _fsm.OpenNamespace1:onNode(state)
   state:push_scope(state:get_current_scope():open_namespace{name=self[2]})
end
-- open-namespace -> NAMESPACE LBRACE
function _fsm.OpenNamespace2:onNode(state)
   state:push_scope(state:get_current_scope():open_namespace{loc=self[1].loc})
end
-- namespace * -> open-namespace decl-seq-opt RBRACE
function _fsm.Namespace:onNode(state)
   state:pop_scope()
end
