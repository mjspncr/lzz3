-- lzz.ftor_spec_seq
--
-- function and storage specifier sequence
--

-- specifier flags
local INLINE = 1 << 0
local VIRTUAL = 1 << 1
local EXPLICIT = 1 << 2
local STATIC = 1 << 3
local EXTERN = 1 << 4
local MUTABLE = 1 << 5
local AUTO = 1 << 6
local REGISTER = 1 << 7
local DLLAPI = 1 << 8

-- flags indexed by name
local flags = 
{
   ['inline'] = INLINE,
   ['virtual'] = VIRTUAL,
   ['explicit'] = EXPLICIT,
   ['static'] = STATIC,
   ['extern'] = EXTERN,
   ['mutable'] = MUTABLE,
   ['auto'] = AUTO,
   ['register'] = REGISTER,
   ['_dll_api'] = DLLAPI,
} 

-- names indexed by flag
local names =
{
   [INLINE]   = 'inline',
   [VIRTUAL]  = 'virtual',
   [EXPLICIT] = 'explicit',
   [STATIC]   = 'static',
   [EXTERN]   = 'extern',
   [MUTABLE]  = 'mutable',
   [AUTO]     = 'auto',
   [REGISTER] = 'register',
   [DLLAPI]   = '_dll_api',
}

-- class table
local Class = {}
Class.__index = Class

-- add builtin specifier
function Class:add(token)
   local flag = flags[token.lexeme]
   if self.flags & flag ~= 0 then
      lzz.warning(token.loc, 'duplicate type specifier: ' .. token.lexeme)
   else
      self.flags = self.flags | flag
      self[flag] = token.loc
   end
end

-- true if any specifiers set
function Class:is_set()
   return self.flags > 0
end

-- true if has inline
for name, flag in pairs {
   inline   = INLINE,
   virtual  = VIRTUAL,
   explicit = EXPLICIT,
   static   = STATIC,
   extern   = EXTERN,
   mutable  = MUTABLE,
   auto     = AUTO,
   register = REGISTER,
   dllapi   = DLLAPI,
} do
   Class['has_' .. name] = function (self) return self.flags & flag ~= 0 end
end

-- class module
local module = {}

-- return new class instance
function module.new()
   local self = {
      flags = 0,
   }
   return setmetatable(self, Class)
end

return module
