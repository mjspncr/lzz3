-----------------------------------------------------------------------------
-- builtin specifiers
-----------------------------------------------------------------------------

local Spec = {}

-- flags
Spec.BOOL      = 1 << 0
Spec.CHAR      = 1 << 1
Spec.DOUBLE    = 1 << 2
Spec.FLOAT     = 1 << 3
Spec.INT       = 1 << 4
Spec.LONG      = 1 << 5
Spec.SHORT     = 1 << 6
Spec.SIGNED    = 1 << 7
Spec.UNSIGNED  = 1 << 8
Spec.VOID      = 1 << 9
Spec.WCHAR     = 1 << 10

-- specs by name
Spec.specs =
   {
      ['bool']     = Spec.BOOL,
      ['char']     = Spec.CHAR,
      ['double']   = Spec.DOUBLE,
      ['float']    = Spec.FLOAT,
      ['int']      = Spec.INT,
      ['long']     = Spec.LONG,
      ['short']    = Spec.SHORT,
      ['signed']   = Spec.SIGNED,
      ['unsigned'] = Spec.UNSIGNED,
      ['void']     = Spec.VOID,
      ['wchar']    = Spec.WCHAR,
   }

-- names by spec
Spec.names =
   {
      [Spec.BOOL]     = 'bool',
      [Spec.CHAR]     = 'char',
      [Spec.DOUBLE]   = 'double',
      [Spec.FLOAT]    = 'float',
      [Spec.INT]      = 'int',
      [Spec.LONG]     = 'long',
      [Spec.SHORT]    = 'short',
      [Spec.SIGNED]   = 'signed',
      [Spec.UNSIGNED] = 'unsigned',
      [Spec.VOID]     = 'void',
      [Spec.WCHAR]    = 'wchar',
   }

return Spec
