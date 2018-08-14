-- lzz.declare_object
--

local _ftor_spec_seq = require('lzz.ftor_spec_seq')

local INLINE   = _ftor_spec_seq.INLINE
local VIRTUAL  = _ftor_spec_seq.VIRTUAL
local EXPLICIT = _ftor_spec_seq.EXPLICIT
local STATIC   = _ftor_spec_seq.STATIC
local EXTERN   = _ftor_spec_seq.EXTERN
local MUTABLE  = _ftor_spec_seq.MUTABLE
local AUTO     = _ftor_spec_seq.AUTO
local REGISTER = _ftor_spec_seq.REGISTER

-- validate obj.ftor_spec_seq, raise errors if any flags invalid, replace with obj.specs flags
local function set_specs(obj)
   local spec_seq = obj.ftor_spec_seq
   if spec_seq then
      local function error_any1(loc, name)
         lzz.error(loc, string.format("specifier invalid on object declaration '%s': %s", obj.name:to_string(), name))
      end
      local function error_any2(loc, name1, name2)
         lzz.error(loc, string.format("specifiers incompatible on object declaration '%s': %s and %s", obj.name:to_string(), name1, name2))
      end
      if spec_seq:error_if_any1(INLINE|VIRTUAL|EXPLICIT, error_any1) or spec_seq:error_if_any2(STATIC|EXTERN, error_any2) then
         return false
      end
      obj.is_static   = spec_seq:has(STATIC)
      obj.is_extern   = spec_seq:has(EXTERN)
      obj.is_mutable  = spec_seq:has(MUTABLE)
      obj.is_auto     = spec_seq:has(AUTO)
      obj.is_register = spec_seq:has(REGISTER)
      obj.ftor_spec_seq = nil
   end
   return true
end

-- scope visitor
local Visitor = {}
Visitor.__index = Visitor

-- declare namespace object
function Visitor.on_namespace_scope(obj, scope)
   if set_specs(obj) then
      scope.namespace:add_object(obj)
   end
end   

-- declare object with lzz state and object
return function(scope, obj)
   scope:accept(setmetatable(obj, Visitor))
end
