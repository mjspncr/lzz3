-- lzz.builtin_spec_seq
--

local class = {}

-- class table
local Class = {}
Class.__index = Class

-- flags
local BOOL     = 1 << 0
local CHAR     = 1 << 1
local DOUBLE   = 1 << 2
local FLOAT    = 1 << 3
local INT      = 1 << 4
local LONG     = 1 << 5
local SHORT    = 1 << 6
local SIGNED   = 1 << 7
local UNSIGNED = 1 << 8
local VOID     = 1 << 9
local WCHAR    = 1 << 10

-- spec flags
local flags =
{
   ['bool']     = BOOL,
   ['char']     = CHAR,
   ['double']   = DOUBLE,
   ['float']    = FLOAT,
   ['int']      = INT,
   ['long']     = LONG,
   ['short']    = SHORT,
   ['signed']   = SIGNED,
   ['unsigned'] = UNSIGNED,
   ['void']     = VOID,
   ['wchar']    = WCHAR,
}

-- compound flags
local SIGNED_INT        = SIGNED|INT
local UNSIGNED_INT      = UNSIGNED|INT
local LONG_INT          = LONG|INT
local SIGNED_LONG       = SIGNED|LONG
local SIGNED_LONG_INT   = SIGNED|LONG_INT
local UNSIGNED_LONG     = UNSIGNED|LONG
local UNSIGNED_LONG_INT = UNSIGNED|LONG_INT
local UNSIGNED_CHAR     = UNSIGNED|CHAR
local SIGNED_CHAR       = SIGNED|CHAR
local LONG_DOUBLE       = LONG|DOUBLE

-- normalized flags
local normalized =
{
   [INT]                = INT,
   [SIGNED]             = INT,
   [SIGNED_INT]         = INT,
   [UNSIGNED_INT]       = UNSIGNED_INT,
   [UNSIGNED]           = UNSIGNED_INT,
   [LONG]               = LONG_INT,
   [LONG_INT]           = LONG_INT,
   [SIGNED_LONG]        = LONG_INT,
   [SIGNED_LONG_INT]    = LONG_INT,
   [UNSIGNED_LONG]      = UNSIGNED_LONG_INT,
   [UNSIGNED_LONG_INT]  = UNSIGNED_LONG_INT,
   [CHAR]               = CHAR,
   [SIGNED_CHAR]        = SIGNED_CHAR,
   [UNSIGNED_CHAR]      = UNSIGNED_CHAR,
   [VOID]               = VOID,
   [BOOL]               = BOOL,
   [FLOAT]              = FLOAT,
   [DOUBLE]             = DOUBLE,
   [LONG_DOUBLE]        = LONG_DOUBLE,
}

-- normalized flags to name 
local names =
{
   [INT]                = 'int',
   [UNSIGNED_INT]       = 'unsigned int',
   [LONG_INT]           = 'long int',
   [UNSIGNED_LONG_INT]  = 'unsigned long int',
   [CHAR]               = 'char',
   [SIGNED_CHAR]        = 'signed char',
   [UNSIGNED_CHAR]      = 'unsigned char',
   [VOID]               = 'void',
   [BOOL]               = 'bool',
   [FLOAT]              = 'float',
   [DOUBLE]             = 'double',
   [LONG_DOUBLE]        = 'long double',
}   
   
-- add builtin specifier
function Class:add(token)
   local flag = flags[token.lexeme]
   if self.flags & flag ~= 0 then
      lzz.warning(token.loc, 'duplicate type specifier: ' .. token.lexeme)
   else
      local flags = self.flags | flag
      if not normalized[flags] then
         lzz.error(token.loc, 'type specifier invalid in this context: ' .. token.lexeme)
      else
         self.flags = flags
      end
   end
end

-- get builtin constant
function Class:get_builtin()
   if self.flags > 0 then
      return self.flags
   end
   return nil
end

-- return new object
function class.new()
   local self = {
      flags = 0,
   }
   return setmetatable(self, Class)
end

-- builtin constant to string
function class.to_string(builtin)
   return names[builtin]
end

return class
