-- lzz.type
--
-- type definitions
--

local _cv_spec_seq = require('lzz.cv_spec_seq')
local _builtin_spec_seq = require('lzz.builtin_spec_seq')

-- to string helper functions
--
-- for builtin and user types
local function to_string_helper1(dcl_string, type_string, cv)
   if cv then
      type_string = string.format('%s %s', type_string, _cv_spec_seq.to_string(cv))
   end
   if dcl_string then
      type_string = string.format('%s %s', type_string, dcl_string);
   end
   return type_string
end

-- for pointer types
local function to_string_helper2(dcl_string, type_string, cv, to_type)
   return to_type:to_string(to_string_helper1(dcl_string, type_string, cv))
end

-- builtin type
local BuiltinType = {}
BuiltinType.__index = BuiltinType

-- to string
function BuiltinType:to_string(dcl_string)
   return to_string_helper1(dcl_string, _builtin_spec_seq.to_string(self.builtin), self.cv)
end

-- user type
local UserType = {}
UserType.__index = UserType

-- to string
function UserType:to_string(dcl_string)
   return to_string_helper1(dcl_string, self.name:to_string(), self.cv)
end

-- pointer type
local PtrType = {}
PtrType.__index = PtrType

-- to string
function PtrType:to_string(dcl_string)
   return to_string_helper2(dcl_string, self.oper, self.cv, self.to_type)
end

-- pointer to member type
local PtrToMbrType = {}
PtrToMbrType.__index = PtrToMbrType

-- to string
function PtrToMbrType:to_string(dcl_string)
   return to_string_helper2(dcl_string, self.name:to_string() .. '::*', self.cv, self.to_type)
end

-- class module
local module = {}

-- return new builtin type instance, takes builtin and cv (optional)
function module.new_builtin(args)
   return setmetatable(args, BuiltinType)
end

-- return new user type instance, takes name cv 
function module.new_user(args)
   return setmetatable(args, UserType)
end

-- return new pointer type instance, args is oper, to_type and optional cv
function module.new_ptr(args)
   return setmetatable(args, PtrType)
end

-- return new pointer to member type instance, args is name, to_type and optional cv
function module.new_ptr_to_mbr(args)
   return setmetatable(args, PtrToMbrType)
end

return module
