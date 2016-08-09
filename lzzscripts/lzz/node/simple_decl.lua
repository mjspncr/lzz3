-----------------------------------------------------------------------------
-- simple declaration
-----------------------------------------------------------------------------
local TmplInstScope       = require 'lzz/scope/tmpl_inst_scope'
local TmplSpecScope       = require 'lzz/scope/tmpl_spec_scope'
local append              = require 'util/append'
local declareFunc         = require 'lzz/scope/declare_func'
local declareObj          = require 'lzz/scope/declare_obj'
local declareTdef         = require 'lzz/scope/declare_tdef'
local defineEnum          = require 'lzz/scope/define_enum'
local defineFunc          = require 'lzz/scope/define_func'
local getFuncParam        = require 'lzz/param/get_func_param'
local nodes               = require 'lzz_nodes'
local reverse             = require 'util/reverse'
local usingNs             = require 'lzz/scope/using_ns' 
local usingObj            = require 'lzz/scope/using_obj' 
-----------------------------------------------------------------------------

-- obj-init -> ASSIGN block 3
function nodes.ObjInit1:onNode ()
   return {'assign', self [2].lexeme}
end

-- obj-init -> DINIT LPAREN block 2 RPAREN
function nodes.ObjInit2:onNode ()
   return {'paren', self [3].lexeme}
end

-- obj-init -> LBRACE block 7 RBRACE
function nodes.ObjInit3:onNode ()
   return {'brace', self [2].lexeme}
end

-- obj-init -> LPAREN block 2 RPAREN 
-- function nodes.ObjInit3:onNode ()
--    return {type='direct', str=self [2].lexeme}
-- end

local ExprList = class ()
-- expr-list -> block 4
function ExprList:onExprList1 (node)
   return append (self, node [1].lexeme)
end
-- expr-list -> expr-list COMMA block 4
function ExprList:onExprList2 (node)
   return node [1]:accept (append (self, node [3].lexeme))
end
-- expr-list-opt -> expr-list
function nodes.ExprListOpt:onNode ()
   return reverse (self [1]:accept (ExprList ()))
end

-- simple-b-decl -> nested-obj-decl obj-init-opt
function nodes.SimpleDecl1:onNode (app)
   local decl_spec, dcl = table.unpack (self:getNestedObjDecl ())
   dcl.init = self [2]
   declareObj (app:getCurrentScope (), dcl)
   return decl_spec
end

-- simple-b-decl -> nested-fun-decl
function nodes.SimpleDecl2:onNode (app)
   local scope = app:getCurrentScope ()
   local decl_spec, dcl = table.unpack (self [1])
   if decl_spec.typedef then
      declareTdef (app:getCurrentScope (), dcl)
   else
      declareFunc (scope, dcl)
   end
   return decl_spec
end

-- fun_def= fun-def * -> fun-decl try-opt ctor-init-opt LBRACE block-opt 7 RBRACE handler-seq-opt
function nodes.FunDef:onNode(app)
   local scope = app:getScope()
   local decl_spec, fun_def = table.unpack(self:getFunDecl())
   fun_def.body = self:getBlockOpt()
   fun_def.ctor_init = self[3]
   fun_def.handlers = self[7]
   defineFunc(scope, fun_def)
end

-- tmpl_spec= tmpl-spec * -> TEMPLATE LT tmpl-params GT
function nodes.TmplSpec:onNode (app)
   local tmpl_spec = self:getTmplParams ()
   tmpl_spec.loc = self:getTEMPLATE ().loc
   app:pushScope (TmplSpecScope (app:getCurrentScope (), tmpl_spec))
end

-- tmpl_decl= tmpl-decl * -> tmpl-spec tmpl-spec-decl
function nodes.TmplDecl:onNode (app)
   app:popScope ()
end

-- enumtors
-- enumtor < * -> obj-name
function nodes.Enumtor1:onNode ()
   return {self[1]}
end
-- enumtor < * -> obj-name ASSIGN BLOCK 9
function nodes.Enumtor2:onNode ()
   return {self[1], self[3].lexeme}
end

-- enum
local GetEnumtors = class ()
-- enumtor-list -> enumtor-list COMMA enumtor
function GetEnumtors:onEnumtorList1 (node)
   append (self, node [3])
   return node [1]:accept (self)
end
-- enumtor-list -> enumtor
function GetEnumtors:onEnumtorList2 (node)
   return setmetatable (reverse (append (self, node [1])), nil)
end

-- enum-body -> enumtor-list comma-opt
function nodes.EnumBody:onNode ()
   return self [1]:accept (GetEnumtors ())
end

-- enum-def -> ENUM obj-name-opt LBRACE enum-body-opt RBRACE semi-opt
function nodes.EnumDef:onNode (app)
   defineEnum (app:getCurrentScope (), self [1].loc, self [2], self [4])
end

--
-- explicit template instantiation
--

-- tmpl-inst -> tmpl-inst-begin tmpl-inst-decl
function nodes.TmplInst:onNode (app)
   app:popScope ()
end

-- tmpl-inst-begin <* -> TEMPLATE
function nodes.TmplInstBegin:onNode (app)
   app:pushScope (TmplInstScope (app:getCurrentScope ()))
end

-- using declaration

-- using-decl -> USING obj-name SEMI
function nodes.UsingDecl:onNode (app)
   usingObj (app:getScope (), self[2])
end

-- using directive

-- using-dir -> USING NAMESPACE obj-name SEMI
function nodes.UsingDir:onNode (app)
   usingNs (app:getScope (), self[3])
end

-- handler

--handler * -> CATCH LPAREN catch-decl RPAREN LBRACE block-opt 7 RBRACE
function nodes.Handler:onNode ()
   return {self[1].loc, self[3], self[6]}
end

-- Seq

local Seq = class () 
-- handler-seq -> handler
function Seq:onSeq1 (node)
   return append (self, node[1])
end
-- handler-seq -> handler-seq handler
function Seq:onSeq2 (node)
   return node[1]:accept (append (self, node[2]))
end
-- get seq
local function getSeq (node)
   if node then
      return reverse (node:accept (Seq ()))
   else
      return nil
   end
end

-- handler-seq-opt -> handler-seq
function nodes.Seq:onNode ()
   return getSeq (self[1])
end

-- catch decl

-- catch-decl -> param-decl
function nodes.CatchDecl1:onNode ()
   local decl_spec, dcl = table.unpack (self [1])
   return getFuncParam (dcl)
end

-- catch-decl -> ELLIPSE
function nodes.CatchDecl2:onNode ()
   -- is ellipse
   return nil
end
