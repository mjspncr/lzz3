-----------------------------------------------------------------------------
-- names
-----------------------------------------------------------------------------
local DtorName            = require 'lzz/name/dtor_name'
local OperName            = require 'lzz/name/oper_name'
local QualifiedName       = require 'lzz/name/qualified_name'
local SimpleName          = require 'lzz/name/simple_name'
local TemplateName        = require 'lzz/name/template_name'
local nodes               = require 'lzz_nodes'
local typeToString        = require 'lzz/type/type_to_string'
-----------------------------------------------------------------------------

-- helper function, if nested_name is not nil create NestedName, otherwise return name
local function onObjName(nested_name, name)
   if nested_name then
      -- nested name visitor, return nested name
      visitor = {}
      -- nested-name -> DCOLON
      function visitor:onNestedName1(node)
         return nil
      end
      -- nested-name -> obj-name DCOLON >!
      function visitor:onNestedName2(node)
         return node[1]
      end
      return QualifiedName(nested_name:accept(visitor), name)
   else
      return name
   end
end

-- obj-name -> nested-name-opt obj-base-name
function nodes.Name1:onNode()
   return onObjName(self[1], self[2])
end

-- obj-name -> nested-name-opt obj-base-name LT >! block-opt 1 GT
function nodes.Name2:onNode()
   -- is block_opt ever nil?
   return onObjName(self[1], TemplateName(false, self[2], self[4].lexeme))
end

-- obj-name -> nested-name TEMPLATE obj-base-name LT >! block-opt 1 GT
function nodes.Name3:onNode()
   -- is block_opt ever nil?
   return onObjName(self[1], TemplateName(true,  self[3], self[5].lexeme))
end

--
-- base name
--

-- obj-base-name -> IDENT
function nodes.BaseName1:onNode()
   local ident = self[1]
   return SimpleName(ident.loc, ident.lexeme)
end

-- fun-base-name -> BITNOT IDENT
function nodes.BaseName2:onNode()
   local ident = self[2]
   return DtorName(ident.loc, ident.lexeme)
end

-- fun-base-name -> OPERATOR oper
function nodes.BaseName3:onNode()
   return OperName(self[1].loc, self[2])
end

-- fun-base-name -> OPERATOR abstract-decl
function nodes.BaseName4:onNode()
   local decl_spec, dcl = table.unpack(self[2])
   return OperName(self[1].loc, typeToString(dcl.tp, nil))
end

--
-- operator
--

-- oper -> LPAREN RPAREN
function nodes.Oper1:onNode()
   return '()'
end
-- oper -> LBRACK RBRACK
function nodes.Oper2:onNode()
   return '[]'
end
-- oper -> NEW LBRACK RBRACK
function nodes.Oper3:onNode()
   return 'new []'
end
-- oper -> DELETE LBRACK RBRACK
function nodes.Oper4:onNode()
   return 'delete []'
end
-- oper -> token-oper
function nodes.Oper5:onNode()
   return self[1].lexeme
end
