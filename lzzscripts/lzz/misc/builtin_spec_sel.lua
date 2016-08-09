-----------------------------------------------------------------------------
-- builtin spec selection
-----------------------------------------------------------------------------
local BuiltinSpec         = require 'lzz/misc/builtin_spec'
local specSel             = require 'lzz/misc/spec_sel'
local specsToString       = require 'lzz/misc/specs_to_string'
-----------------------------------------------------------------------------

local BuiltinSpecSel = specSel (BuiltinSpec)

-- valid builtin specs
local valid_specs
do
   local BOOL              = BuiltinSpec.BOOL
   local CHAR              = BuiltinSpec.CHAR
   local SIGNED            = BuiltinSpec.SIGNED
   local UNSIGNED          = BuiltinSpec.UNSIGNED
   local INT               = BuiltinSpec.INT
   local LONG              = BuiltinSpec.LONG
   local FLOAT             = BuiltinSpec.FLOAT
   local DOUBLE            = BuiltinSpec.DOUBLE
   local VOID              = BuiltinSpec.VOID

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

   valid_specs = {
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
end

-- get builtin string from specs
function BuiltinSpecSel:getBuiltin ()
   local specs = valid_specs [self.flags]
   if not specs then
      print ('invalid builtin spec seq' .. self:toString ())
      return 'foo'
   else
      return specsToString (BuiltinSpec, specs)
   end
end

return BuiltinSpecSel
