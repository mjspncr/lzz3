-----------------------------------------------------------------------------
-- function and storage specifiers
-----------------------------------------------------------------------------

local Spec = {}

-- flags
Spec.INLINE   = 1 << 0
Spec.VIRTUAL  = 1 << 1
Spec.EXPLICIT = 1 << 2
Spec.STATIC   = 1 << 3
Spec.EXTERN   = 1 << 4
Spec.MUTABLE  = 1 << 5
Spec.AUTO     = 1 << 6
Spec.REGISTER = 1 << 7
Spec.DLLAPI   = 1 << 8

-- specs by name
Spec.specs =
   {
      ['inline']   = Spec.INLINE,
      ['virtual']  = Spec.VIRTUAL,
      ['explicit'] = Spec.EXPLICIT,
      ['static']   = Spec.STATIC,
      ['extern']   = Spec.EXTERN,
      ['mutable']  = Spec.MUTABLE,
      ['auto']     = Spec.AUTO,
      ['register'] = Spec.REGISTER,
      ['_dll_api'] = Spec.DLLAPI,
   }

-- names by spec
Spec.names =
   {
      [Spec.INLINE]   = 'inline',
      [Spec.VIRTUAL]  = 'virtual',
      [Spec.EXPLICIT] = 'explicit',
      [Spec.STATIC]   = 'static',
      [Spec.EXTERN]   = 'extern',
      [Spec.MUTABLE]  = 'mutable',
      [Spec.AUTO]     = 'auto',
      [Spec.REGISTER] = 'register',
      [Spec.DLLAPI]   = '_dll_api',
   }

return Spec
