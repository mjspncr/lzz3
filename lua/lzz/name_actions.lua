-- lzz.name_actions
--

local _fsm = require('lzz.parser_fsm')
local _name = require('lzz.name')

-- helper function, if nested_name is not nil return QualifiedName, otherwise return name
local function on_name(nested_name, name)
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
      return _name.new_qualified_name(nested_name:accept(visitor), name)
   else
      return name
   end
end

-- obj-name -> nested-name-opt obj-base-name
function _fsm.Name1:onNode()
   return on_name(self[1], self[2])
end

-- obj-name -> nested-name-opt obj-base-name LT block-opt GT
function _fsm.Name2:onNode()
   -- is block_opt ever nil?
   return on_name(self[1], _name.new_template_name(false, self[2], self[4].lexeme))
end

-- obj-name -> nested-name TEMPLATE obj-base-name LT block-opt GT
function _fsm.Name3:onNode()
   -- is block_opt ever nil?
   return on_name(self[1], _name.new_template_name(true,  self[3], self[5].lexeme))
end

-- obj-base-name -> IDENT
function _fsm.BaseName1:onNode()
   local token = self[1]
   return _name.new_simple_name(token.loc, token.lexeme)
end

-- fun-base-name -> BITNOT IDENT
function _fsm.BaseName2:onNode()
   local token = self[2]
   return _name.new_dtor_name(token.loc, token.lexeme)
end

-- fun-base-name -> OPERATOR oper
function _fsm.BaseName3:onNode()
   return _name.get_oper_name(self[1].loc, self[2])
end

-- fun-base-name -> OPERATOR abstract-decl
function _fsm.BaseName4:onNode()
   local decl_spec, dcl = table.unpack(self[2])
   print 'TODO - conversion name'
   -- return _name.get_oper_name(self[1].loc, typeToString(dcl.tp, nil))
end

--
-- oper is a string, name of the operator
--

-- oper -> LPAREN RPAREN
function _fsm.Oper1:onNode()
   return '()'
end
-- oper -> LBRACK RBRACK
function _fsm.Oper2:onNode()
   return '[]'
end
-- oper -> NEW LBRACK RBRACK
function _fsm.Oper3:onNode()
   return 'new[]'
end
-- oper -> DELETE LBRACK RBRACK
function _fsm.Oper4:onNode()
   return 'delete[]'
end
-- oper -> token-oper
function _fsm.Oper5:onNode()
   return self[1].lexeme
end
