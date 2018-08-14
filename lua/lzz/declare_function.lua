-- lzz.declare_function
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

-- validate fun.ftor_spec_seq, raise errors if any flags invalid, replace with fun.specs flags
local function set_specs(fun)
   local spec_seq = fun.ftor_spec_seq
   if spec_seq then
      local function error_any1(loc, name)
         lzz.error(loc, string.format("specifier invalid on function declaration '%s': %s", fun.name:to_string(), name))
      end
      local function error_any2(loc, name1, name2)
         lzz.error(loc, string.format("specifiers incompatible on function declaration '%s': %s and %s", fun.name:to_string(), name1, name2))
      end
      if spec_seq:error_if_any1(MUTABLE|AUTO|REGISTER, error_any1) then
         return false
      end
      if spec_seq:error_if_any2(STATIC|EXTERN, error_any2) then
         return false
      end
      fun.is_static   = spec_seq:has(STATIC)
      fun.is_extern   = spec_seq:has(EXTERN)
      fun.is_virtual  = spec_seq:has(VIRTUAL)
      fun.is_inline   = spec_seq:has(INLINE)
      fun.ftor_spec_seq = nil
   end
   return true
end

-- scope visitor
local Visitor = {}
Visitor.__index = Visitor

-- namespace function
function Visitor.on_namespace_scope(fun, scope)
   if set_specs(fun) then
      scope.namespace:add_function(fun)
   end
end   

-- declare function in scope
return function(scope, fun)
   scope:accept(setmetatable(fun, Visitor))
end

