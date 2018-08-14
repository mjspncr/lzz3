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
      lzz.warning(token.loc, 'duplicate function or storage specifier: ' .. token.lexeme)
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

-- true if has any flags set
function Class:has(flags)
   return self.flags & flags ~= 0
end
--[=[ 
-- true if has all flags set
function Class:has_all(flags)
   return self.flags & flags == flags
end
--]=]
function Class:which(flags)
   return self.flags & flags
end

-- call error function if any flag set
function Class:error_if_any1(flags, on_error)
   local has_error = false
   if self:has(flags) then
      local i = 1
      while i <= flags do
         if self:has(i) then
            on_error(self[i], names[i])
            has_error = true
         end
         i = i << 1
      end
   end
   return has_error
end

-- call error function if any two flags set
function Class:error_if_any2(flags, on_error)
   local has_error = false
   if self:has(flags) then
      flags = self.flags & flags
      local i = 1
      while i <= flags do
         if flags & i > 0 then
            local j = i << 1
            while j <= flags do
               if flags & j > 0 then
                  on_error(self[i], names[i], names[j])
                  has_error = true
               end
               j = j << 1
            end
         end
         i = i << 1
      end
   end
   return has_error
end

-- class module
local module = {}

-- expose flags
module.INLINE = INLINE
module.VIRTUAL = VIRTUAL
module.EXPLICIT = EXPLICIT
module.STATIC = STATIC
module.EXTERN = EXTERN
module.MUTABLE = MUTABLE
module.AUTO = AUTO
module.REGISTER = REGISTER
module.DLLAPI = DLLAPI

-- return new class instance
function module.new()
   local self = {
      flags = 0,
   }
   return setmetatable(self, Class)
end

-- return ftor flags as string
function module.to_string(flags)
   local strings = {}
   local i = 1
   while i <= flags do
      if flags & i > 0 then
         table.insert(strings, names[i])
      end
   end
   return table.concat(strings, ' ')
end

return module
       