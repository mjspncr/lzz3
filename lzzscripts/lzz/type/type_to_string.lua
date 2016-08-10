-----------------------------------------------------------------------------
-- type to string
-----------------------------------------------------------------------------
local appends             = require 'util/appends'
local nameToString        = require 'lzz/name/name_to_string'
local throwSpecToString   = nil
-----------------------------------------------------------------------------

local TypeToString = class ()
function TypeToString:__init (dcl_str)
   self.dcl_str = dcl_str
end

local function toString (tp, dcl_str)
   return tp:accept (TypeToString (dcl_str))
end

-- function parameter types to string, inside parens
local function funcParamTypesToString (args)
   local strs = {}
   for _, v in ipairs (args) do
      table.insert (strs, toString (v))
   end
   if args.is_vararg then
      table.insert (strs, '...')
   end
   return '(' .. table.concat (strs, ', ') .. ')'
end

-- helper for builtin and user types
function TypeToString:helper1 (tp_str, cv)
   if cv then
      tp_str = tp_str .. ' ' .. cv
   end
   local dcl_str = self.dcl_str
   if dcl_str then
      tp_str = tp_str .. ' ' .. dcl_str
   end
   return tp_str
end

-- helper for pointer types
function TypeToString:helper2 (to_tp, tp_str, cv)
   self.dcl_str = self:helper1 (tp_str, cv)
   return to_tp:accept (self)
end

-- helper for function and array type
function TypeToString:helper3 (to_tp, tp_str)
   if self.dcl_str then
      self.dcl_str = '(' .. self.dcl_str .. ') ' .. tp_str
   else
      self.dcl_str = tp_str
   end
   return to_tp:accept (self)
end

-- on builtin
function TypeToString:onBuiltinType (tp)
   return self:helper1 (tp.builtin, tp.cv)
end

-- on pointer
function TypeToString:onPointerType (tp)
   return self:helper2 (tp.to_tp, '*', tp.cv)
end

-- on pointer to member
function TypeToString:onPointerToMemberType (tp)
   return self:helper2 (tp.to_tp, nameToString (tp.name) .. '::*', tp.cv)
end

-- on reference
function TypeToString:onReferenceType (tp)
   return self:helper2 (tp.to_tp, '&')
end

-- on array
function TypeToString:onArrayType (tp)
   return self:helper3 (tp.to_tp, '['..tp.arg..']')
end

-- on function
function TypeToString:onFunctionType (tp)
   throwSpecToString = throwSpecToString or require 'lzz/type/throw_spec_to_string'
   local dcl_str = funcParamTypesToString(tp.param_tps)
   dcl_str = appends(dcl_str, tp.cv)
   dcl_str = appends(dcl_str, throwSpecToString(tp.throw_spec))
   return self:helper3 (tp.to_tp, dcl_str)
end

-- on user type
function TypeToString:onUserType (tp)
   return self:helper1 (nameToString (tp.name), tp.cv)
end

-- on elab type
function TypeToString:onElabType (tp)
   return self:helper1 (tp.cls_key .. ' ' .. nameToString (tp.name), tp.cv)
end

return toString
