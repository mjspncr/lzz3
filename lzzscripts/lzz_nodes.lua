local nodes = {}

-- xxVS-decl-spec-seq -> cv-spec >!
local VDeclSpecSeq1 = node ("VDeclSpecSeq1")
function VDeclSpecSeq1:getCvSpec ()
   return self [1]
end
function VDeclSpecSeq1:accept (visitor)
   return visitor:onVDeclSpecSeq1 (self)
end
nodes.VDeclSpecSeq1 = VDeclSpecSeq1

-- xxVS-decl-spec-seq -> xxVS-decl-spec-seq cv-spec
local VDeclSpecSeq2 = node ("VDeclSpecSeq2")
function VDeclSpecSeq2:getXxVSDeclSpecSeq ()
   return self [1]
end
function VDeclSpecSeq2:getCvSpec ()
   return self [2]
end
function VDeclSpecSeq2:accept (visitor)
   return visitor:onVDeclSpecSeq2 (self)
end
nodes.VDeclSpecSeq2 = VDeclSpecSeq2

-- elab-type -> class-key obj-name
local ElabType = node ("ElabType")
function ElabType:getClassKey ()
   return self [1]
end
function ElabType:getObjName ()
   return self [2]
end
function ElabType:accept (visitor)
   return visitor:onElabType (self)
end
nodes.ElabType = ElabType

-- xxxS-decl-spec-seq -> ftor-spec >!
local SDeclSpecSeq1 = node ("SDeclSpecSeq1")
function SDeclSpecSeq1:getFtorSpec ()
   return self [1]
end
function SDeclSpecSeq1:accept (visitor)
   return visitor:onSDeclSpecSeq1 (self)
end
nodes.SDeclSpecSeq1 = SDeclSpecSeq1

-- xxxS-decl-spec-seq -> xxxS-decl-spec-seq ftor-spec
local SDeclSpecSeq2 = node ("SDeclSpecSeq2")
function SDeclSpecSeq2:getXxxSDeclSpecSeq ()
   return self [1]
end
function SDeclSpecSeq2:getFtorSpec ()
   return self [2]
end
function SDeclSpecSeq2:accept (visitor)
   return visitor:onSDeclSpecSeq2 (self)
end
nodes.SDeclSpecSeq2 = SDeclSpecSeq2

-- xxxS-decl-spec-seq ->
local SDeclSpecSeq3 = node ("SDeclSpecSeq3")
function SDeclSpecSeq3:accept (visitor)
   return visitor:onSDeclSpecSeq3 (self)
end
nodes.SDeclSpecSeq3 = SDeclSpecSeq3

-- xBVS-decl-spec-seq -> builtin-type >!
local BDeclSpecSeq1 = node ("BDeclSpecSeq1")
function BDeclSpecSeq1:getBuiltinType ()
   return self [1]
end
function BDeclSpecSeq1:accept (visitor)
   return visitor:onBDeclSpecSeq1 (self)
end
nodes.BDeclSpecSeq1 = BDeclSpecSeq1

-- xBVS-decl-spec-seq -> xxVS-decl-spec-seq builtin-type
local BDeclSpecSeq2 = node ("BDeclSpecSeq2")
function BDeclSpecSeq2:getXxVSDeclSpecSeq ()
   return self [1]
end
function BDeclSpecSeq2:getBuiltinType ()
   return self [2]
end
function BDeclSpecSeq2:accept (visitor)
   return visitor:onBDeclSpecSeq2 (self)
end
nodes.BDeclSpecSeq2 = BDeclSpecSeq2

-- xUVS-decl-spec-seq -> xxxS-decl-spec-seq obj-name >!
local UDeclSpecSeq2 = node ("UDeclSpecSeq2")
function UDeclSpecSeq2:getXxxSDeclSpecSeq ()
   return self [1]
end
function UDeclSpecSeq2:getObjName ()
   return self [2]
end
function UDeclSpecSeq2:accept (visitor)
   return visitor:onUDeclSpecSeq2 (self)
end
nodes.UDeclSpecSeq2 = UDeclSpecSeq2

-- xEVS-decl-spec-seq -> elab-type >!
local EDeclSpecSeq1 = node ("EDeclSpecSeq1")
function EDeclSpecSeq1:getElabType ()
   return self [1]
end
function EDeclSpecSeq1:accept (visitor)
   return visitor:onEDeclSpecSeq1 (self)
end
nodes.EDeclSpecSeq1 = EDeclSpecSeq1

-- xEVS-decl-spec-seq -> xxVS-decl-spec-seq elab-type
local EDeclSpecSeq2 = node ("EDeclSpecSeq2")
function EDeclSpecSeq2:getXxVSDeclSpecSeq ()
   return self [1]
end
function EDeclSpecSeq2:getElabType ()
   return self [2]
end
function EDeclSpecSeq2:accept (visitor)
   return visitor:onEDeclSpecSeq2 (self)
end
nodes.EDeclSpecSeq2 = EDeclSpecSeq2

-- TxVS-decl-spec-seq -> typedef-spec >!
local TDeclSpecSeq1 = node ("TDeclSpecSeq1")
function TDeclSpecSeq1:getTypedefSpec ()
   return self [1]
end
function TDeclSpecSeq1:accept (visitor)
   return visitor:onTDeclSpecSeq1 (self)
end
nodes.TDeclSpecSeq1 = TDeclSpecSeq1

-- TxVS-decl-spec-seq -> xxVS-decl-spec-seq typedef-spec
local TDeclSpecSeq2 = node ("TDeclSpecSeq2")
function TDeclSpecSeq2:getXxVSDeclSpecSeq ()
   return self [1]
end
function TDeclSpecSeq2:getTypedefSpec ()
   return self [2]
end
function TDeclSpecSeq2:accept (visitor)
   return visitor:onTDeclSpecSeq2 (self)
end
nodes.TDeclSpecSeq2 = TDeclSpecSeq2

-- FxVS-decl-spec-seq -> FRIEND >!
local FDeclSpecSeq1 = node ("FDeclSpecSeq1")
function FDeclSpecSeq1:getFRIEND ()
   return self [1]
end
function FDeclSpecSeq1:accept (visitor)
   return visitor:onFDeclSpecSeq1 (self)
end
nodes.FDeclSpecSeq1 = FDeclSpecSeq1

-- FxVS-decl-spec-seq -> xxVS-decl-spec-seq FRIEND
local FDeclSpecSeq2 = node ("FDeclSpecSeq2")
function FDeclSpecSeq2:getXxVSDeclSpecSeq ()
   return self [1]
end
function FDeclSpecSeq2:getFRIEND ()
   return self [2]
end
function FDeclSpecSeq2:accept (visitor)
   return visitor:onFDeclSpecSeq2 (self)
end
nodes.FDeclSpecSeq2 = FDeclSpecSeq2

-- obj-decl -> xBVS-decl-spec-seq obj-dcl
local Decl = node ("Decl")
function Decl:getXBVSDeclSpecSeq ()
   return self [1]
end
function Decl:getObjDcl ()
   return self [2]
end
function Decl:accept (visitor)
   return visitor:onDecl (self)
end
nodes.Decl = Decl

-- obj-a-dcl -> ptr-oper obj-a-dcl
local PtrDcl = node ("PtrDcl")
function PtrDcl:getPtrOper ()
   return self [1]
end
function PtrDcl:getObjADcl ()
   return self [2]
end
function PtrDcl:accept (visitor)
   return visitor:onPtrDcl (self)
end
nodes.PtrDcl = PtrDcl

-- ptr-oper -> TIMES cv-spec-seq-opt
local PtrOper1 = node ("PtrOper1")
function PtrOper1:getTIMES ()
   return self [1]
end
function PtrOper1:getCvSpecSeqOpt ()
   return self [2]
end
function PtrOper1:accept (visitor)
   return visitor:onPtrOper1 (self)
end
nodes.PtrOper1 = PtrOper1

-- ptr-oper -> BITAND
local PtrOper2 = node ("PtrOper2")
function PtrOper2:getBITAND ()
   return self [1]
end
function PtrOper2:accept (visitor)
   return visitor:onPtrOper2 (self)
end
nodes.PtrOper2 = PtrOper2

-- ptr-oper -> obj-name DCOLON TIMES cv-spec-seq-opt
local PtrOper3 = node ("PtrOper3")
function PtrOper3:getObjName ()
   return self [1]
end
function PtrOper3:getDCOLON ()
   return self [2]
end
function PtrOper3:getTIMES ()
   return self [3]
end
function PtrOper3:getCvSpecSeqOpt ()
   return self [4]
end
function PtrOper3:accept (visitor)
   return visitor:onPtrOper3 (self)
end
nodes.PtrOper3 = PtrOper3

-- obj-b-direct-dcl -> obj-b-direct-dcl param-decl-1-body > RPAREN cv-spec-seq-opt throw-spec-opt
local DirectDcl1 = node ("DirectDcl1")
function DirectDcl1:getObjBDirectDcl ()
   return self [1]
end
function DirectDcl1:getParamDecl1Body ()
   return self [2]
end
function DirectDcl1:getRPAREN ()
   return self [3]
end
function DirectDcl1:getCvSpecSeqOpt ()
   return self [4]
end
function DirectDcl1:getThrowSpecOpt ()
   return self [5]
end
function DirectDcl1:accept (visitor)
   return visitor:onDirectDcl1 (self)
end
nodes.DirectDcl1 = DirectDcl1

-- obj-b-direct-dcl -> obj-a-direct-dcl LBRACK block-opt 5 RBRACK
local DirectDcl2 = node ("DirectDcl2")
function DirectDcl2:getObjADirectDcl ()
   return self [1]
end
function DirectDcl2:getLBRACK ()
   return self [2]
end
function DirectDcl2:getBlockOpt ()
   return self [3]
end
function DirectDcl2:getRBRACK ()
   return self [4]
end
function DirectDcl2:accept (visitor)
   return visitor:onDirectDcl2 (self)
end
nodes.DirectDcl2 = DirectDcl2

-- obj-b-direct-dcl -> LPAREN obj-b-dcl RPAREN
local DirectDcl3 = node ("DirectDcl3")
function DirectDcl3:getLPAREN ()
   return self [1]
end
function DirectDcl3:getObjBDcl ()
   return self [2]
end
function DirectDcl3:getRPAREN ()
   return self [3]
end
function DirectDcl3:accept (visitor)
   return visitor:onDirectDcl3 (self)
end
nodes.DirectDcl3 = DirectDcl3

-- obj-id -> obj-name
local Id = node ("Id")
function Id:getObjName ()
   return self [1]
end
function Id:accept (visitor)
   return visitor:onId (self)
end
nodes.Id = Id

--
local ThrowSpec = node ("ThrowSpec")
function ThrowSpec:accept (visitor)
   return visitor:onThrowSpec (self)
end
nodes.ThrowSpec = ThrowSpec

--
local TypeIdList1 = node ("TypeIdList1")
function TypeIdList1:accept (visitor)
   return visitor:onTypeIdList1 (self)
end
nodes.TypeIdList1 = TypeIdList1

--
local TypeIdList2 = node ("TypeIdList2")
function TypeIdList2:accept (visitor)
   return visitor:onTypeIdList2 (self)
end
nodes.TypeIdList2 = TypeIdList2

--
local TypeId = node ("TypeId")
function TypeId:accept (visitor)
   return visitor:onTypeId (self)
end
nodes.TypeId = TypeId

-- param-decl-1-body -> param-decl-1-list ellipse-opt
local ParamDeclBody1 = node ("ParamDeclBody1")
function ParamDeclBody1:getParamDecl1List ()
   return self [1]
end
function ParamDeclBody1:getEllipseOpt ()
   return self [2]
end
function ParamDeclBody1:accept (visitor)
   return visitor:onParamDeclBody1 (self)
end
nodes.ParamDeclBody1 = ParamDeclBody1

-- param-decl-1-body -> param-decl-1-list COMMA ELLIPSE
local ParamDeclBody2 = node ("ParamDeclBody2")
function ParamDeclBody2:getParamDecl1List ()
   return self [1]
end
function ParamDeclBody2:getCOMMA ()
   return self [2]
end
function ParamDeclBody2:getELLIPSE ()
   return self [3]
end
function ParamDeclBody2:accept (visitor)
   return visitor:onParamDeclBody2 (self)
end
nodes.ParamDeclBody2 = ParamDeclBody2

-- param-decl-1-body -> LPAREN ellipse-opt
local ParamDeclBody3 = node ("ParamDeclBody3")
function ParamDeclBody3:getLPAREN ()
   return self [1]
end
function ParamDeclBody3:getEllipseOpt ()
   return self [2]
end
function ParamDeclBody3:accept (visitor)
   return visitor:onParamDeclBody3 (self)
end
nodes.ParamDeclBody3 = ParamDeclBody3

-- param-decl-1-body -> LPAREN VOID
local ParamDeclBody4 = node ("ParamDeclBody4")
function ParamDeclBody4:getLPAREN ()
   return self [1]
end
function ParamDeclBody4:getVOID ()
   return self [2]
end
function ParamDeclBody4:accept (visitor)
   return visitor:onParamDeclBody4 (self)
end
nodes.ParamDeclBody4 = ParamDeclBody4

-- param-decl-1-list <* -> LPAREN > param-init-decl
local ParamDeclList1 = node ("ParamDeclList1")
function ParamDeclList1:getLPAREN ()
   return self [1]
end
function ParamDeclList1:getParamInitDecl ()
   return self [2]
end
function ParamDeclList1:accept (visitor)
   return visitor:onParamDeclList1 (self)
end
nodes.ParamDeclList1 = ParamDeclList1

-- param-decl-1-list -> param-decl-1-list COMMA param-init-decl
local ParamDeclList2 = node ("ParamDeclList2")
function ParamDeclList2:getParamDecl1List ()
   return self [1]
end
function ParamDeclList2:getCOMMA ()
   return self [2]
end
function ParamDeclList2:getParamInitDecl ()
   return self [3]
end
function ParamDeclList2:accept (visitor)
   return visitor:onParamDeclList2 (self)
end
nodes.ParamDeclList2 = ParamDeclList2

-- param-init-decl <* -> param-decl
local ParamDecl1 = node ("ParamDecl1")
function ParamDecl1:getParamDecl ()
   return self [1]
end
function ParamDecl1:accept (visitor)
   return visitor:onParamDecl1 (self)
end
nodes.ParamDecl1 = ParamDecl1

-- param-init-decl <* -> param-decl ASSIGN block 4
local ParamDecl2 = node ("ParamDecl2")
function ParamDecl2:getParamDecl ()
   return self [1]
end
function ParamDecl2:getASSIGN ()
   return self [2]
end
function ParamDecl2:getBlock ()
   return self [3]
end
function ParamDecl2:accept (visitor)
   return visitor:onParamDecl2 (self)
end
nodes.ParamDecl2 = ParamDecl2

-- nested-name -> DCOLON
local NestedName1 = node ("NestedName1")
function NestedName1:getDCOLON ()
   return self [1]
end
function NestedName1:accept (visitor)
   return visitor:onNestedName1 (self)
end
nodes.NestedName1 = NestedName1

-- nested-name -> obj-name DCOLON >!
local NestedName2 = node ("NestedName2")
function NestedName2:getObjName ()
   return self [1]
end
function NestedName2:getDCOLON ()
   return self [2]
end
function NestedName2:accept (visitor)
   return visitor:onNestedName2 (self)
end
nodes.NestedName2 = NestedName2

-- obj-name -> nested-name-opt obj-base-name
local Name1 = node ("Name1")
function Name1:getNestedNameOpt ()
   return self [1]
end
function Name1:getObjBaseName ()
   return self [2]
end
function Name1:accept (visitor)
   return visitor:onName1 (self)
end
nodes.Name1 = Name1

-- obj-name -> nested-name-opt obj-base-name LT >! block-opt 1 GT
local Name2 = node ("Name2")
function Name2:getNestedNameOpt ()
   return self [1]
end
function Name2:getObjBaseName ()
   return self [2]
end
function Name2:getLT ()
   return self [3]
end
function Name2:getBlockOpt ()
   return self [4]
end
function Name2:getGT ()
   return self [5]
end
function Name2:accept (visitor)
   return visitor:onName2 (self)
end
nodes.Name2 = Name2

-- obj-name -> nested-name TEMPLATE obj-base-name LT >! block-opt 1 GT
local Name3 = node ("Name3")
function Name3:getNestedName ()
   return self [1]
end
function Name3:getTEMPLATE ()
   return self [2]
end
function Name3:getObjBaseName ()
   return self [3]
end
function Name3:getLT ()
   return self [4]
end
function Name3:getBlockOpt ()
   return self [5]
end
function Name3:getGT ()
   return self [6]
end
function Name3:accept (visitor)
   return visitor:onName3 (self)
end
nodes.Name3 = Name3

-- obj-base-name -> IDENT
local BaseName1 = node ("BaseName1")
function BaseName1:getIDENT ()
   return self [1]
end
function BaseName1:accept (visitor)
   return visitor:onBaseName1 (self)
end
nodes.BaseName1 = BaseName1

-- fun-base-name -> BITNOT IDENT
local BaseName2 = node ("BaseName2")
function BaseName2:getBITNOT ()
   return self [1]
end
function BaseName2:getIDENT ()
   return self [2]
end
function BaseName2:accept (visitor)
   return visitor:onBaseName2 (self)
end
nodes.BaseName2 = BaseName2

-- fun-base-name -> OPERATOR oper
local BaseName3 = node ("BaseName3")
function BaseName3:getOPERATOR ()
   return self [1]
end
function BaseName3:getOper ()
   return self [2]
end
function BaseName3:accept (visitor)
   return visitor:onBaseName3 (self)
end
nodes.BaseName3 = BaseName3

-- fun-base-name -> OPERATOR abstract-decl >
local BaseName4 = node ("BaseName4")
function BaseName4:getOPERATOR ()
   return self [1]
end
function BaseName4:getAbstractDecl ()
   return self [2]
end
function BaseName4:accept (visitor)
   return visitor:onBaseName4 (self)
end
nodes.BaseName4 = BaseName4

-- oper -> LPAREN RPAREN
local Oper1 = node ("Oper1")
function Oper1:getLPAREN ()
   return self [1]
end
function Oper1:getRPAREN ()
   return self [2]
end
function Oper1:accept (visitor)
   return visitor:onOper1 (self)
end
nodes.Oper1 = Oper1

-- oper -> LBRACK RBRACK
local Oper2 = node ("Oper2")
function Oper2:getLBRACK ()
   return self [1]
end
function Oper2:getRBRACK ()
   return self [2]
end
function Oper2:accept (visitor)
   return visitor:onOper2 (self)
end
nodes.Oper2 = Oper2

-- oper -> NEW LBRACK RBRACK
local Oper3 = node ("Oper3")
function Oper3:getNEW ()
   return self [1]
end
function Oper3:getLBRACK ()
   return self [2]
end
function Oper3:getRBRACK ()
   return self [3]
end
function Oper3:accept (visitor)
   return visitor:onOper3 (self)
end
nodes.Oper3 = Oper3

-- oper -> DELETE LBRACK RBRACK
local Oper4 = node ("Oper4")
function Oper4:getDELETE ()
   return self [1]
end
function Oper4:getLBRACK ()
   return self [2]
end
function Oper4:getRBRACK ()
   return self [3]
end
function Oper4:accept (visitor)
   return visitor:onOper4 (self)
end
nodes.Oper4 = Oper4

-- oper -> token-oper
local Oper5 = node ("Oper5")
function Oper5:getTokenOper ()
   return self [1]
end
function Oper5:accept (visitor)
   return visitor:onOper5 (self)
end
nodes.Oper5 = Oper5

-- obj-init -> ASSIGN block 3
local ObjInit1 = node ("ObjInit1")
function ObjInit1:getASSIGN ()
   return self [1]
end
function ObjInit1:getBlock ()
   return self [2]
end
function ObjInit1:accept (visitor)
   return visitor:onObjInit1 (self)
end
nodes.ObjInit1 = ObjInit1

-- obj-init -> DINIT LPAREN block 2 RPAREN
local ObjInit2 = node ("ObjInit2")
function ObjInit2:getDINIT ()
   return self [1]
end
function ObjInit2:getLPAREN ()
   return self [2]
end
function ObjInit2:getBlock ()
   return self [3]
end
function ObjInit2:getRPAREN ()
   return self [4]
end
function ObjInit2:accept (visitor)
   return visitor:onObjInit2 (self)
end
nodes.ObjInit2 = ObjInit2

-- obj-init -> LBRACE block 7 RBRACE
local ObjInit3 = node ("ObjInit3")
function ObjInit3:getLBRACE ()
   return self [1]
end
function ObjInit3:getBlock ()
   return self [2]
end
function ObjInit3:getRBRACE ()
   return self [3]
end
function ObjInit3:accept (visitor)
   return visitor:onObjInit3 (self)
end
nodes.ObjInit3 = ObjInit3

-- expr-list -> block 4
local ExprList1 = node ("ExprList1")
function ExprList1:getBlock ()
   return self [1]
end
function ExprList1:accept (visitor)
   return visitor:onExprList1 (self)
end
nodes.ExprList1 = ExprList1

-- expr-list -> expr-list COMMA block 4
local ExprList2 = node ("ExprList2")
function ExprList2:getExprList ()
   return self [1]
end
function ExprList2:getCOMMA ()
   return self [2]
end
function ExprList2:getBlock ()
   return self [3]
end
function ExprList2:accept (visitor)
   return visitor:onExprList2 (self)
end
nodes.ExprList2 = ExprList2

-- expr-list-opt -> expr-list
local ExprListOpt = node ("ExprListOpt")
function ExprListOpt:getExprList ()
   return self [1]
end
function ExprListOpt:accept (visitor)
   return visitor:onExprListOpt (self)
end
nodes.ExprListOpt = ExprListOpt

-- fun-dcl -> fun-ptr-dcl pure-opt
local FunDcl = node ("FunDcl")
function FunDcl:getFunPtrDcl ()
   return self [1]
end
function FunDcl:getPureOpt ()
   return self [2]
end
function FunDcl:accept (visitor)
   return visitor:onFunDcl (self)
end
nodes.FunDcl = FunDcl

-- pure -> ASSIGN ZERO
local Pure = node ("Pure")
function Pure:getASSIGN ()
   return self [1]
end
function Pure:getZERO ()
   return self [2]
end
function Pure:accept (visitor)
   return visitor:onPure (self)
end
nodes.Pure = Pure

-- fun-a-direct-dcl -> obj-dcl-id param-decl-1-body RPAREN cv-spec-seq-opt throw-spec-opt
local DirectDcl4 = node ("DirectDcl4")
function DirectDcl4:getObjDclId ()
   return self [1]
end
function DirectDcl4:getParamDecl1Body ()
   return self [2]
end
function DirectDcl4:getRPAREN ()
   return self [3]
end
function DirectDcl4:getCvSpecSeqOpt ()
   return self [4]
end
function DirectDcl4:getThrowSpecOpt ()
   return self [5]
end
function DirectDcl4:accept (visitor)
   return visitor:onDirectDcl4 (self)
end
nodes.DirectDcl4 = DirectDcl4

-- functor-direct-dcl -> obj-dcl-id param-decl-1-body param-decl-2-body RPAREN cv-spec-seq-opt throw-spec-opt
local DirectDcl5 = node ("DirectDcl5")
function DirectDcl5:getObjDclId ()
   return self [1]
end
function DirectDcl5:getParamDecl1Body ()
   return self [2]
end
function DirectDcl5:getParamDecl2Body ()
   return self [3]
end
function DirectDcl5:getRPAREN ()
   return self [4]
end
function DirectDcl5:getCvSpecSeqOpt ()
   return self [5]
end
function DirectDcl5:getThrowSpecOpt ()
   return self [6]
end
function DirectDcl5:accept (visitor)
   return visitor:onDirectDcl5 (self)
end
nodes.DirectDcl5 = DirectDcl5

-- simple-b-decl -> nested-obj-decl obj-init-opt
local SimpleDecl1 = node ("SimpleDecl1")
function SimpleDecl1:getNestedObjDecl ()
   return self [1]
end
function SimpleDecl1:getObjInitOpt ()
   return self [2]
end
function SimpleDecl1:accept (visitor)
   return visitor:onSimpleDecl1 (self)
end
nodes.SimpleDecl1 = SimpleDecl1

-- simple-b-decl -> nested-fun-decl
local SimpleDecl2 = node ("SimpleDecl2")
function SimpleDecl2:getNestedFunDecl ()
   return self [1]
end
function SimpleDecl2:accept (visitor)
   return visitor:onSimpleDecl2 (self)
end
nodes.SimpleDecl2 = SimpleDecl2

-- nested-obj-decl -> simple-b-decl COMMA obj-dcl
local NestedDecl = node ("NestedDecl")
function NestedDecl:getSimpleBDecl ()
   return self [1]
end
function NestedDecl:getCOMMA ()
   return self [2]
end
function NestedDecl:getObjDcl ()
   return self [3]
end
function NestedDecl:accept (visitor)
   return visitor:onNestedDecl (self)
end
nodes.NestedDecl = NestedDecl

-- namespace * -> open-namespace decl-seq-opt RBRACE
local Namespace = node ("Namespace")
function Namespace:getOpenNamespace ()
   return self [1]
end
function Namespace:getDeclSeqOpt ()
   return self [2]
end
function Namespace:getRBRACE ()
   return self [3]
end
function Namespace:accept (visitor)
   return visitor:onNamespace (self)
end
nodes.Namespace = Namespace

-- open-namespace -> NAMESPACE obj-name LBRACE
local OpenNamespace1 = node ("OpenNamespace1")
function OpenNamespace1:getNAMESPACE ()
   return self [1]
end
function OpenNamespace1:getObjName ()
   return self [2]
end
function OpenNamespace1:getLBRACE ()
   return self [3]
end
function OpenNamespace1:accept (visitor)
   return visitor:onOpenNamespace1 (self)
end
nodes.OpenNamespace1 = OpenNamespace1

-- open-namespace -> NAMESPACE LBRACE
local OpenNamespace2 = node ("OpenNamespace2")
function OpenNamespace2:getNAMESPACE ()
   return self [1]
end
function OpenNamespace2:getLBRACE ()
   return self [2]
end
function OpenNamespace2:accept (visitor)
   return visitor:onOpenNamespace2 (self)
end
nodes.OpenNamespace2 = OpenNamespace2

-- fun-def * -> fun-decl * try-opt ctor-init-opt LBRACE block-opt 7 RBRACE handler-seq-opt
local FunDef = node ("FunDef")
function FunDef:getFunDecl ()
   return self [1]
end
function FunDef:getTryOpt ()
   return self [2]
end
function FunDef:getCtorInitOpt ()
   return self [3]
end
function FunDef:getLBRACE ()
   return self [4]
end
function FunDef:getBlockOpt ()
   return self [5]
end
function FunDef:getRBRACE ()
   return self [6]
end
function FunDef:getHandlerSeqOpt ()
   return self [7]
end
function FunDef:accept (visitor)
   return visitor:onFunDef (self)
end
nodes.FunDef = FunDef

-- ctor-init -> COLON mbr-init-list
local CtorInit = node ("CtorInit")
function CtorInit:getCOLON ()
   return self [1]
end
function CtorInit:getMbrInitList ()
   return self [2]
end
function CtorInit:accept (visitor)
   return visitor:onCtorInit (self)
end
nodes.CtorInit = CtorInit

-- mbr-init-list -> mbr-init
local MbrInitList1 = node ("MbrInitList1")
function MbrInitList1:getMbrInit ()
   return self [1]
end
function MbrInitList1:accept (visitor)
   return visitor:onMbrInitList1 (self)
end
nodes.MbrInitList1 = MbrInitList1

-- mbr-init-list -> mbr-init-list COMMA mbr-init
local MbrInitList2 = node ("MbrInitList2")
function MbrInitList2:getMbrInitList ()
   return self [1]
end
function MbrInitList2:getCOMMA ()
   return self [2]
end
function MbrInitList2:getMbrInit ()
   return self [3]
end
function MbrInitList2:accept (visitor)
   return visitor:onMbrInitList2 (self)
end
nodes.MbrInitList2 = MbrInitList2

-- mbr-init * -> obj-name LPAREN BLOCK 2 RPAREN
local MbrInit1 = node ("MbrInit1")
function MbrInit1:getObjName ()
   return self [1]
end
function MbrInit1:getLPAREN ()
   return self [2]
end
function MbrInit1:getBLOCK ()
   return self [3]
end
function MbrInit1:getRPAREN ()
   return self [4]
end
function MbrInit1:accept (visitor)
   return visitor:onMbrInit1 (self)
end
nodes.MbrInit1 = MbrInit1

-- mbr-init * -> obj-name LBRACE BLOCK 7 RBRACE
local MbrInit2 = node ("MbrInit2")
function MbrInit2:getObjName ()
   return self [1]
end
function MbrInit2:getLBRACE ()
   return self [2]
end
function MbrInit2:getBLOCK ()
   return self [3]
end
function MbrInit2:getRBRACE ()
   return self [4]
end
function MbrInit2:accept (visitor)
   return visitor:onMbrInit2 (self)
end
nodes.MbrInit2 = MbrInit2

-- handler-seq-opt -> handler-seq
local Seq = node ("Seq")
function Seq:getHandlerSeq ()
   return self [1]
end
function Seq:accept (visitor)
   return visitor:onSeq (self)
end
nodes.Seq = Seq

-- handler-seq -> handler
local Seq1 = node ("Seq1")
function Seq1:getHandler ()
   return self [1]
end
function Seq1:accept (visitor)
   return visitor:onSeq1 (self)
end
nodes.Seq1 = Seq1

-- handler-seq -> handler-seq handler
local Seq2 = node ("Seq2")
function Seq2:getHandlerSeq ()
   return self [1]
end
function Seq2:getHandler ()
   return self [2]
end
function Seq2:accept (visitor)
   return visitor:onSeq2 (self)
end
nodes.Seq2 = Seq2

-- handler * -> CATCH LPAREN catch-decl RPAREN LBRACE block-opt 7 RBRACE
local Handler = node ("Handler")
function Handler:getCATCH ()
   return self [1]
end
function Handler:getLPAREN ()
   return self [2]
end
function Handler:getCatchDecl ()
   return self [3]
end
function Handler:getRPAREN ()
   return self [4]
end
function Handler:getLBRACE ()
   return self [5]
end
function Handler:getBlockOpt ()
   return self [6]
end
function Handler:getRBRACE ()
   return self [7]
end
function Handler:accept (visitor)
   return visitor:onHandler (self)
end
nodes.Handler = Handler

-- catch-decl -> param-decl
local CatchDecl1 = node ("CatchDecl1")
function CatchDecl1:getParamDecl ()
   return self [1]
end
function CatchDecl1:accept (visitor)
   return visitor:onCatchDecl1 (self)
end
nodes.CatchDecl1 = CatchDecl1

-- catch-decl -> ELLIPSE
local CatchDecl2 = node ("CatchDecl2")
function CatchDecl2:getELLIPSE ()
   return self [1]
end
function CatchDecl2:accept (visitor)
   return visitor:onCatchDecl2 (self)
end
nodes.CatchDecl2 = CatchDecl2

-- class-decl -> xEVS-decl-spec-seq SEMI
local ClassDecl = node ("ClassDecl")
function ClassDecl:getXEVSDeclSpecSeq ()
   return self [1]
end
function ClassDecl:getSEMI ()
   return self [2]
end
function ClassDecl:accept (visitor)
   return visitor:onClassDecl (self)
end
nodes.ClassDecl = ClassDecl

-- friend-class-decl -> FEVS-decl-spec-seq SEMI
local FriendClassDecl = node ("FriendClassDecl")
function FriendClassDecl:getFEVSDeclSpecSeq ()
   return self [1]
end
function FriendClassDecl:getSEMI ()
   return self [2]
end
function FriendClassDecl:accept (visitor)
   return visitor:onFriendClassDecl (self)
end
nodes.FriendClassDecl = FriendClassDecl

-- class-def -> class-head <* LBRACE mbr-decl-seq-opt RBRACE semi-opt
local ClassDef = node ("ClassDef")
function ClassDef:getClassHead ()
   return self [1]
end
function ClassDef:getLBRACE ()
   return self [2]
end
function ClassDef:getMbrDeclSeqOpt ()
   return self [3]
end
function ClassDef:getRBRACE ()
   return self [4]
end
function ClassDef:getSemiOpt ()
   return self [5]
end
function ClassDef:accept (visitor)
   return visitor:onClassDef (self)
end
nodes.ClassDef = ClassDef

-- class-head -> class-key obj-name base-clause-opt
local ClassHead = node ("ClassHead")
function ClassHead:getClassKey ()
   return self [1]
end
function ClassHead:getObjName ()
   return self [2]
end
function ClassHead:getBaseClauseOpt ()
   return self [3]
end
function ClassHead:accept (visitor)
   return visitor:onClassHead (self)
end
nodes.ClassHead = ClassHead

-- base-clause -> COLON base-spec-list
local BaseClause = node ("BaseClause")
function BaseClause:getCOLON ()
   return self [1]
end
function BaseClause:getBaseSpecList ()
   return self [2]
end
function BaseClause:accept (visitor)
   return visitor:onBaseClause (self)
end
nodes.BaseClause = BaseClause

-- base-spec-list -> base-spec
local BaseSpecList1 = node ("BaseSpecList1")
function BaseSpecList1:getBaseSpec ()
   return self [1]
end
function BaseSpecList1:accept (visitor)
   return visitor:onBaseSpecList1 (self)
end
nodes.BaseSpecList1 = BaseSpecList1

-- base-spec-list -> base-spec-list COMMA base-spec
local BaseSpecList2 = node ("BaseSpecList2")
function BaseSpecList2:getBaseSpecList ()
   return self [1]
end
function BaseSpecList2:getCOMMA ()
   return self [2]
end
function BaseSpecList2:getBaseSpec ()
   return self [3]
end
function BaseSpecList2:accept (visitor)
   return visitor:onBaseSpecList2 (self)
end
nodes.BaseSpecList2 = BaseSpecList2

-- base-spec * -> obj-name
local BaseSpec1 = node ("BaseSpec1")
function BaseSpec1:getObjName ()
   return self [1]
end
function BaseSpec1:accept (visitor)
   return visitor:onBaseSpec1 (self)
end
nodes.BaseSpec1 = BaseSpec1

-- base-spec * -> VIRTUAL access-opt obj-name
local BaseSpec2 = node ("BaseSpec2")
function BaseSpec2:getVIRTUAL ()
   return self [1]
end
function BaseSpec2:getAccessOpt ()
   return self [2]
end
function BaseSpec2:getObjName ()
   return self [3]
end
function BaseSpec2:accept (visitor)
   return visitor:onBaseSpec2 (self)
end
nodes.BaseSpec2 = BaseSpec2

-- base-spec * -> access virtual-opt obj-name
local BaseSpec3 = node ("BaseSpec3")
function BaseSpec3:getAccess ()
   return self [1]
end
function BaseSpec3:getVirtualOpt ()
   return self [2]
end
function BaseSpec3:getObjName ()
   return self [3]
end
function BaseSpec3:accept (visitor)
   return visitor:onBaseSpec3 (self)
end
nodes.BaseSpec3 = BaseSpec3

-- access-spec * -> access COLON
local AccessSpec = node ("AccessSpec")
function AccessSpec:getAccess ()
   return self [1]
end
function AccessSpec:getCOLON ()
   return self [2]
end
function AccessSpec:accept (visitor)
   return visitor:onAccessSpec (self)
end
nodes.AccessSpec = AccessSpec

-- tmpl-decl * -> tmpl-spec tmpl-spec-decl
local TmplDecl = node ("TmplDecl")
function TmplDecl:getTmplSpec ()
   return self [1]
end
function TmplDecl:getTmplSpecDecl ()
   return self [2]
end
function TmplDecl:accept (visitor)
   return visitor:onTmplDecl (self)
end
nodes.TmplDecl = TmplDecl

-- tmpl-spec * -> TEMPLATE LT tmpl-params GT
local TmplSpec = node ("TmplSpec")
function TmplSpec:getTEMPLATE ()
   return self [1]
end
function TmplSpec:getLT ()
   return self [2]
end
function TmplSpec:getTmplParams ()
   return self [3]
end
function TmplSpec:getGT ()
   return self [4]
end
function TmplSpec:accept (visitor)
   return visitor:onTmplSpec (self)
end
nodes.TmplSpec = TmplSpec

-- tmpl-params -> tmpl-param-list-opt
local TmplParams = node ("TmplParams")
function TmplParams:getTmplParamListOpt ()
   return self [1]
end
function TmplParams:accept (visitor)
   return visitor:onTmplParams (self)
end
nodes.TmplParams = TmplParams

-- tmpl-param-list -> tmpl-param
local TmplParamList1 = node ("TmplParamList1")
function TmplParamList1:getTmplParam ()
   return self [1]
end
function TmplParamList1:accept (visitor)
   return visitor:onTmplParamList1 (self)
end
nodes.TmplParamList1 = TmplParamList1

-- tmpl-param-list -> tmpl-param-list COMMA tmpl-param
local TmplParamList2 = node ("TmplParamList2")
function TmplParamList2:getTmplParamList ()
   return self [1]
end
function TmplParamList2:getCOMMA ()
   return self [2]
end
function TmplParamList2:getTmplParam ()
   return self [3]
end
function TmplParamList2:accept (visitor)
   return visitor:onTmplParamList2 (self)
end
nodes.TmplParamList2 = TmplParamList2

-- type-param <* -> type-key ++ obj-name
local TypeParam1 = node ("TypeParam1")
function TypeParam1:getTypeKey ()
   return self [1]
end
function TypeParam1:getObjName ()
   return self [2]
end
function TypeParam1:accept (visitor)
   return visitor:onTypeParam1 (self)
end
nodes.TypeParam1 = TypeParam1

-- type-param <* -> type-key obj-name ASSIGN abstract-decl
local TypeParam2 = node ("TypeParam2")
function TypeParam2:getTypeKey ()
   return self [1]
end
function TypeParam2:getObjName ()
   return self [2]
end
function TypeParam2:getASSIGN ()
   return self [3]
end
function TypeParam2:getAbstractDecl ()
   return self [4]
end
function TypeParam2:accept (visitor)
   return visitor:onTypeParam2 (self)
end
nodes.TypeParam2 = TypeParam2

-- tmpl-tmpl-param <* -> TEMPLATE LT tmpl-params GT CLASS obj-name
local TmplTmplParam1 = node ("TmplTmplParam1")
function TmplTmplParam1:getTEMPLATE ()
   return self [1]
end
function TmplTmplParam1:getLT ()
   return self [2]
end
function TmplTmplParam1:getTmplParams ()
   return self [3]
end
function TmplTmplParam1:getGT ()
   return self [4]
end
function TmplTmplParam1:getCLASS ()
   return self [5]
end
function TmplTmplParam1:getObjName ()
   return self [6]
end
function TmplTmplParam1:accept (visitor)
   return visitor:onTmplTmplParam1 (self)
end
nodes.TmplTmplParam1 = TmplTmplParam1

-- tmpl-tmpl-param <* -> TEMPLATE LT tmpl-params GT CLASS obj-name ASSIGN obj-name
local TmplTmplParam2 = node ("TmplTmplParam2")
function TmplTmplParam2:getTEMPLATE ()
   return self [1]
end
function TmplTmplParam2:getLT ()
   return self [2]
end
function TmplTmplParam2:getTmplParams ()
   return self [3]
end
function TmplTmplParam2:getGT ()
   return self [4]
end
function TmplTmplParam2:getCLASS ()
   return self [5]
end
function TmplTmplParam2:getObjName1 ()
   return self [6]
end
function TmplTmplParam2:getASSIGN ()
   return self [7]
end
function TmplTmplParam2:getObjName2 ()
   return self [8]
end
function TmplTmplParam2:accept (visitor)
   return visitor:onTmplTmplParam2 (self)
end
nodes.TmplTmplParam2 = TmplTmplParam2

-- enum-def -> ENUM obj-name-opt LBRACE enum-body-opt RBRACE semi-opt
local EnumDef = node ("EnumDef")
function EnumDef:getENUM ()
   return self [1]
end
function EnumDef:getObjNameOpt ()
   return self [2]
end
function EnumDef:getLBRACE ()
   return self [3]
end
function EnumDef:getEnumBodyOpt ()
   return self [4]
end
function EnumDef:getRBRACE ()
   return self [5]
end
function EnumDef:getSemiOpt ()
   return self [6]
end
function EnumDef:accept (visitor)
   return visitor:onEnumDef (self)
end
nodes.EnumDef = EnumDef

-- enum-body -> enumtor-list comma-opt
local EnumBody = node ("EnumBody")
function EnumBody:getEnumtorList ()
   return self [1]
end
function EnumBody:getCommaOpt ()
   return self [2]
end
function EnumBody:accept (visitor)
   return visitor:onEnumBody (self)
end
nodes.EnumBody = EnumBody

-- enumtor-list -> enumtor-list COMMA enumtor
local EnumtorList1 = node ("EnumtorList1")
function EnumtorList1:getEnumtorList ()
   return self [1]
end
function EnumtorList1:getCOMMA ()
   return self [2]
end
function EnumtorList1:getEnumtor ()
   return self [3]
end
function EnumtorList1:accept (visitor)
   return visitor:onEnumtorList1 (self)
end
nodes.EnumtorList1 = EnumtorList1

-- enumtor-list -> enumtor
local EnumtorList2 = node ("EnumtorList2")
function EnumtorList2:getEnumtor ()
   return self [1]
end
function EnumtorList2:accept (visitor)
   return visitor:onEnumtorList2 (self)
end
nodes.EnumtorList2 = EnumtorList2

-- enumtor <* -> obj-name
local Enumtor1 = node ("Enumtor1")
function Enumtor1:getObjName ()
   return self [1]
end
function Enumtor1:accept (visitor)
   return visitor:onEnumtor1 (self)
end
nodes.Enumtor1 = Enumtor1

-- enumtor <* -> obj-name ASSIGN BLOCK 9
local Enumtor2 = node ("Enumtor2")
function Enumtor2:getObjName ()
   return self [1]
end
function Enumtor2:getASSIGN ()
   return self [2]
end
function Enumtor2:getBLOCK ()
   return self [3]
end
function Enumtor2:accept (visitor)
   return visitor:onEnumtor2 (self)
end
nodes.Enumtor2 = Enumtor2

-- lazy-class -> lazy-class-head LBRACE mbr-decl-seq-opt RBRACE semi-opt
local LazyClass = node ("LazyClass")
function LazyClass:getLazyClassHead ()
   return self [1]
end
function LazyClass:getLBRACE ()
   return self [2]
end
function LazyClass:getMbrDeclSeqOpt ()
   return self [3]
end
function LazyClass:getRBRACE ()
   return self [4]
end
function LazyClass:getSemiOpt ()
   return self [5]
end
function LazyClass:accept (visitor)
   return visitor:onLazyClass (self)
end
nodes.LazyClass = LazyClass

-- lazy-class-head -> class-key obj-name param-decl-1-body RPAREN lazy-base-clause-opt
local LazyClassHead = node ("LazyClassHead")
function LazyClassHead:getClassKey ()
   return self [1]
end
function LazyClassHead:getObjName ()
   return self [2]
end
function LazyClassHead:getParamDecl1Body ()
   return self [3]
end
function LazyClassHead:getRPAREN ()
   return self [4]
end
function LazyClassHead:getLazyBaseClauseOpt ()
   return self [5]
end
function LazyClassHead:accept (visitor)
   return visitor:onLazyClassHead (self)
end
nodes.LazyClassHead = LazyClassHead

--
local LazyBaseSpec = node ("LazyBaseSpec")
function LazyBaseSpec:accept (visitor)
   return visitor:onLazyBaseSpec (self)
end
nodes.LazyBaseSpec = LazyBaseSpec

--
local BaseInit = node ("BaseInit")
function BaseInit:accept (visitor)
   return visitor:onBaseInit (self)
end
nodes.BaseInit = BaseInit

-- functor-def -> functor-decl lazy-base-clause-opt try-opt LBRACE block-opt 7 RBRACE handler-seq-opt
local FunctorDef = node ("FunctorDef")
function FunctorDef:getFunctorDecl ()
   return self [1]
end
function FunctorDef:getLazyBaseClauseOpt ()
   return self [2]
end
function FunctorDef:getTryOpt ()
   return self [3]
end
function FunctorDef:getLBRACE ()
   return self [4]
end
function FunctorDef:getBlockOpt ()
   return self [5]
end
function FunctorDef:getRBRACE ()
   return self [6]
end
function FunctorDef:getHandlerSeqOpt ()
   return self [7]
end
function FunctorDef:accept (visitor)
   return visitor:onFunctorDef (self)
end
nodes.FunctorDef = FunctorDef

-- tmpl-inst -> tmpl-inst-begin tmpl-inst-decl
local TmplInst = node ("TmplInst")
function TmplInst:getTmplInstBegin ()
   return self [1]
end
function TmplInst:getTmplInstDecl ()
   return self [2]
end
function TmplInst:accept (visitor)
   return visitor:onTmplInst (self)
end
nodes.TmplInst = TmplInst

-- tmpl-inst-begin -> TEMPLATE
local TmplInstBegin = node ("TmplInstBegin")
function TmplInstBegin:getTEMPLATE ()
   return self [1]
end
function TmplInstBegin:accept (visitor)
   return visitor:onTmplInstBegin (self)
end
nodes.TmplInstBegin = TmplInstBegin

-- using-decl -> USING obj-name SEMI
local UsingDecl = node ("UsingDecl")
function UsingDecl:getUSING ()
   return self [1]
end
function UsingDecl:getObjName ()
   return self [2]
end
function UsingDecl:getSEMI ()
   return self [3]
end
function UsingDecl:accept (visitor)
   return visitor:onUsingDecl (self)
end
nodes.UsingDecl = UsingDecl

-- using-dir -> USING NAMESPACE obj-name SEMI
local UsingDir = node ("UsingDir")
function UsingDir:getUSING ()
   return self [1]
end
function UsingDir:getNAMESPACE ()
   return self [2]
end
function UsingDir:getObjName ()
   return self [3]
end
function UsingDir:getSEMI ()
   return self [4]
end
function UsingDir:accept (visitor)
   return visitor:onUsingDir (self)
end
nodes.UsingDir = UsingDir

return nodes
