-- lzz.type
--
-- type definitions
--

local _cv_spec_seq = require('lzz.cv_spec_seq')
local _builtin_spec_seq = require('lzz.builtin_spec_seq')

-- to string helpers
-- for builtin and user types
local function to_string_helper1(dcl_str, type_string, cv)
   if cv then
      type_string = string.format('%s %s', type_string, _cv_spec_seq.to_string(cv))
   end
   if dcl_str then
      type_string = string.format('%s %s', type_string, dcl_str);
   end
   return type_string
end
-- for pointer types
local function to_string_helper2(dcl_str, type_string, cv, to_type)
   return to_type:to_string(to_string_helper1(dcl_str, type_string, cv))
end
-- for function and array type
function to_string_helper3(dcl_str, type_str, to_type)
   if dcl_str then
      dcl_str = '(' .. dcl_str .. ') ' .. type_str
   else
      dcl_str = type_str
   end
   return to_type:to_string(dcl_str)
end

local function is_const(type)
   return type.cv and _cv_spec_seq.is_const(type.cv)
end
local function is_const_default()
   return false
end

-- builtin type
local BuiltinType = {
   is_const = is_const
}
BuiltinType.__index = BuiltinType

-- to string
function BuiltinType:to_string(dcl_str)
   return to_string_helper1(dcl_str, _builtin_spec_seq.to_string(self.builtin), self.cv)
end

-- user type
local UserType = {
   is_const = is_const
}
UserType.__index = UserType
-- to string
function UserType:to_string(dcl_str)
   return to_string_helper1(dcl_str, self.name:to_string(), self.cv)
end

-- pointer type
local PtrType = {
   is_const = is_const
}
PtrType.__index = PtrType
-- to string
function PtrType:to_string(dcl_str)
   return to_string_helper2(dcl_str, self.oper, self.cv, self.to_type)
end

-- array type
local ArrayType = {
   is_const = is_const_default
}
ArrayType.__index = ArrayType
function ArrayType:to_string(dcl_str)
   return to_string_helper3(dcl_str, '[' .. self.arg .. ']', self.element_type)
end

-- function type
local FunctionType = {
   is_const = is_const_default
}
FunctionType.__index = FunctionType
-- return param types as string
local function param_types_to_string(param_types)
   local strs = {}
   for _, param_type in ipairs(param_types) do
      table.insert(strs, param_type:to_string())
   end
   if param_types.is_vararg then
      table.insert(strs, '...')
   end
   return table.concat(strs, ', ')
end
-- to string
function FunctionType:to_string(dcl_str)
   local type_str = '(' .. param_types_to_string(self.param_types) .. ')'
   return to_string_helper3(dcl_str, type_str, self.to_type)
end

local module = {}

-- return new builtin type, takes builtin and cv
function module.new_builtin_type(args)
   return setmetatable(args, BuiltinType)
end
-- return new user type, takes name and cv
function module.new_user_type(args)
   return setmetatable(args, UserType)
end
-- return new pointer type, takes oper, cv and to_type
function module.new_ptr_type(args)
   return setmetatable(args, PtrType)
end
-- return new array type, takes arg and element_type
function module.new_array_type(args)
   return setmetatable(args, ArrayType)
end
-- return new function type
function module.new_function_type(args)
   return setmetatable(args, FunctionType)
end

return module
