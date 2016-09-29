-----------------------------------------------------------------------------
-- on declaration nodes
-----------------------------------------------------------------------------
local ArrayType           = require 'lzz/type/array_type'
local DeclSpecSel         = require 'lzz/misc/decl_spec_sel'
local ElabType            = require 'lzz/type/elab_type'
local FunctionType        = require 'lzz/type/function_type'
local PointerToMemberType = require 'lzz/type/pointer_to_member_type'
local PointerType         = require 'lzz/type/pointer_type'
local ReferenceType       = require 'lzz/type/reference_type'
local UserType            = require 'lzz/type/user_type'
local append              = require 'util/append'
local getFuncParamTypes   = require 'lzz/param/get_func_param_types'
local nodes               = require 'lzz_nodes'
-----------------------------------------------------------------------------

-- elab-type -> class-key obj-name
function nodes.ElabType:onNode()
   -- return key, name tuple
   return {self[1].lexeme, self[2]}
end

-----------------------------------------------------------------------------
-- get decl spec
-----------------------------------------------------------------------------
local GetDeclSpec = {}

-- xxVx-decl-spec-seq -> cv-spec
function GetDeclSpec:onVDeclSpecSeq1(node)
   return DeclSpecSel():addCv(node[1])
end   
-- xxVx-decl-spec-seq -> xxVx-decl-spec-seq cv-spec
function GetDeclSpec:onVDeclSpecSeq2(node)
   return node[1]:accept(self):addCv(node[2])
end   

-- xxxS-decl-spec-seq -> ftor-spec
function GetDeclSpec:onSDeclSpecSeq1(node)
   return DeclSpecSel():addFtor(node[1])
end   
-- xxxS-decl-spec-seq -> xxxS-decl-spec-seq ftor-spec
function GetDeclSpec:onSDeclSpecSeq2(node)
   return node[1]:accept(self):addFtor(node[2])
end   
-- xxxS-decl-spec-seq -> 
function GetDeclSpec:onSDeclSpecSeq3(node)
   return DeclSpecSel()
end   

-- xBxx-decl-spec-seq -> builtin-type
function GetDeclSpec:onBDeclSpecSeq1(node)
   return DeclSpecSel():addBuiltin(node[1])
end
-- xBxx-decl-spec-seq -> xBxx-decl-spec-seq builtin-type
function GetDeclSpec:onBDeclSpecSeq2 (node)
   return node[1]:accept(self):addBuiltin(node[2])
end

-- xUVx-decl-spec-seq -> obj-name
function GetDeclSpec:onUDeclSpecSeq1(node)
   return DeclSpecSel():setType(UserType(node[1]))
end
-- xUVx-decl-spec-seq -> xxVx-decl-spec-seq obj-name
function GetDeclSpec:onUDeclSpecSeq2(node)
   return node[1]:accept(self):setType(UserType(node[2]))
end

-- xEVS-decl-spec-seq -> elab-type >!
function GetDeclSpec:onEDeclSpecSeq1(node)
   local key, name = table.unpack(node[1])
   return DeclSpecSel():setType(ElabType(key, name))
end
-- xEVS-decl-spec-seq -> xxVS-decl-spec-seq elab-type
function GetDeclSpec:onEDeclSpecSeq2(node)
   local key, name = table.unpack(node[2])
   return node[1]:accept(self):setType(ElabType(key, name))
end

-- Txxx-decl-spec-seq -> typedef-spec
function GetDeclSpec:onTDeclSpecSeq1(node)
   return DeclSpecSel():setTypedef(node[1])
end
-- TxVx-decl-spec-seq -> xxVx-decl-spec-seq typedef-spec
function GetDeclSpec:onTDeclSpecSeq2(node)
   return node[1]:accept(self):setTypedef(node[2])
end

-- FxVS-decl-spec-seq -> FRIEND >!
function GetDeclSpec:onFDeclSpecSeq1(node)
   return DeclSpecSel():setFriend(node[1])
end
-- FxVS-decl-spec-seq -> xxVS-decl-spec-seq FRIEND
function GetDeclSpec:onFDeclSpecSeq2(node)
   return node[1]:accept(self):setFriend(node[2])
end

-- get decl spec from decl spec seq
local function getDeclSpec(node)
   return node:accept(GetDeclSpec):getDeclSpec()
end

-- get cv from cv decl spec, nil if node nil
local function getCv(node)
   if node then 
      return node:accept(GetDeclSpec):getCv()
   else
      return nil
   end
end

-----------------------------------------------------------------------------
-- get ptr type
-----------------------------------------------------------------------------
local GetPtrType = class ()
function GetPtrType:__init (to_tp)
   self.to_tp = to_tp
end

-- ptr-oper -> TIMES cv-spec-seq-opt
function GetPtrType:onPtrOper1(node)
   local cv = getCv(node[2])
   return PointerType(cv, self.to_tp)
end

-- ptr-oper -> BITAND
function GetPtrType:onPtrOper2(node)
   return ReferenceType(self.to_tp)
end

-- ptr-oper -> obj-name DCOLON TIMES cv-spec-seq-opt
function GetPtrType:onPtrOper3(node)
   local cv = getCv(node[4])
   return PointerToMemberType(cv, self.to_tp, node[1])
end

-- get ptr type
local function getPtrType(node, to_tp)
   return node:accept(GetPtrType(to_tp))
end

-----------------------------------------------------------------------------
-- get dcl type
-----------------------------------------------------------------------------
local GetDcl = class ()
function GetDcl:__init (to_tp)
   self.tp = to_tp
end

-- get dcl from node
local function getDcl (node, to_tp)
   local dcl = GetDcl (to_tp)
   dcl:onDclOpt (node)
   return setmetatable (dcl, nil)
end

-- on dcl, if nil (if abstract dcl) return dcl obj
function GetDcl:onDclOpt (node)
   if node then
      node:accept (self)
   end
end

-- fun-dcl -> fun-ptr-dcl pure-opt
function GetDcl:onFunDcl(node)
   self.pure = node[2] ~= nil
   node[1]:accept(self)
end

-- obj-a-dcl -> ptr-oper obj-a-dcl
function GetDcl:onPtrDcl(node)
   self.tp = getPtrType(node[1], self.tp)
   self:onDclOpt(node[2])
end

-- obj-b-direct-dcl -> obj-b-direct-dcl param-decl-1-body > RPAREN cv-spec-seq-opt throw-spec-opt
function GetDcl:onDirectDcl1(node)
   -- object dcl
   local cv = getCv(node[4])
   local throw_spec = node[5]
   self.tp = FunctionType(cv, self.tp, getFuncParamTypes(node[2]), throw_spec)
   self:onDclOpt(node[1])
end

-- obj-b-direct-dcl -> obj-a-direct-dcl LBRACK block-opt 5 RBRACK
function GetDcl:onDirectDcl2(node)
   self.tp = ArrayType(self.tp, node[3].lexeme)
   self:onDclOpt (node[1])
end

-- obj-b-direct-dcl -> LPAREN obj-b-dcl RPAREN
function GetDcl:onDirectDcl3(node)
    self:onDclOpt(node[2])
end

-- fun-a-direct-dcl -> obj-dcl-id param-decl-1-body RPAREN cv-spec-seq-opt throw-spec-opt
function GetDcl:onDirectDcl4(node)
   -- function dcl
   self.params = node[2]
   self.cv = getCv(node[4])
   self.throw_spec = node[5]
   self:onDclOpt(node[1])
end

-- functor-direct-dcl -> obj-dcl-id param-decl-1-body param-decl-2-body RPAREN cv-spec-seq-opt throw-spec-opt
function GetDcl:onDirectDcl5(node)
   -- functor dcl
   self.ctor_params = node[2]
   self.params = node[3]
   self.cv = getCv(node[5])
   self.throw_spec = node[6]
   self:onDclOpt(node[1])
end

-- obj-id -> obj-name
function GetDcl:onId(node)
   self.name = node[1]
end

-----------------------------------------------------------------------------
-- on nodes
-----------------------------------------------------------------------------
-- on dcl node
local function onDcl(decl_spec, node)
   local dcl = getDcl(node, decl_spec.tp)
   dcl.friend = decl_spec.friend
   dcl.specs = decl_spec.specs
   return {decl_spec, dcl}
end

-- fun-decl -> xBVS-decl-spec-seq fun-dcl
function nodes.Decl:onNode()
   local decl_spec
   if self[1] then
      decl_spec = getDeclSpec(self[1])
   else
      decl_spec = DeclSpecSel():getDeclSpec()
   end
   return onDcl(decl_spec, self[2])
end

-- nested-obj-decl -> complete-decl COMMA obj-dcl
function nodes.NestedDecl:onNode()
   return onDcl(self[1], self[3])
end

-- type-id -> abstract-decl
function nodes.TypeId:onNode()
   local dcl = self[1][2]
   return dcl.tp
end

--
-- throw spec
--

-- get type ID list 
local GetTypeIdList = {}
-- type-id-list -> type-id
function GetTypeIdList:onTypeIdList1(node)
   return {node[1]}
end
-- TypeIdList2: type-id-list -> type-id-list COMMA type-id
function GetTypeIdList:onTypeIdList2(node)
   return append(node[1]:accept(self), node[3])
end
-- get type id list, list of types
local function getTypeIdList(node)
   return node:accept(GetTypeIdList)
end

-- throw-spec -> THROW LPAREN type-id-list-opt RPAREN
function nodes.ThrowSpec:onNode()
   if self[3] then
      return getTypeIdList(self[3])
   else
      return {}
   end
end
