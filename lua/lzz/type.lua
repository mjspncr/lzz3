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
   return to_string_helper1(_builtin_spec_seq.to_string(self.builtin), self.cv, dcl_string)
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
   return to_string_helper2(dcl_string, '*', self.cv, self.to_type)
end

-- reference type
local RefType = {}
RefType.__index = RefType

-- to string
function RefType:to_string(dcl_string)
   return to_string_helper2(dcl_string, '&', self.cv, self.to_type)
end

-- class module
local module = {}

-- return new builtin type instance
function module.new_builtin(builtin)
   return setmetatable({builtin=builtin}, BuiltinType)
end

-- return new user type instance
function module.new_user(name)
   return setmetatable({name=name}, UserType)
end

-- return new pointer type instance
function module.new_ptr(to_type)
   return setmetatable({to_type=to_type}, PtrType)
end

-- return new refrence type instance
function module.new_ref(to_type)
   return setmetatable({to_type=to_type}, RefType)
end

return module
