-----------------------------------------------------------------------------
-- CV specifiers
-----------------------------------------------------------------------------

local Spec = {}

-- flags
Spec.CONST     = 1 << 0
Spec.VOLATILE  = 1 << 1

-- specs by name
Spec.specs =
   {
      ['const']    = Spec.CONST,
      ['volatile'] = Spec.VOLATILE,
   }

-- names by spec
Spec.names =
   {
      [Spec.CONST]    = 'const',
      [Spec.VOLATILE] = 'volatile',
   }

return Spec
