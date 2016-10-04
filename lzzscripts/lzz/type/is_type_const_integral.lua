-----------------------------------------------------------------------------
-- is type const integral?
-----------------------------------------------------------------------------

local integral_types = {
   ['int'] = true,
   ['long int'] = true,
}

local IsTypeConstIntegral = {}

local function isTypeConstIntegral (tp)
   return tp:accept (IsTypeConstIntegral)
end

-- on builtin
function IsTypeConstIntegral:onBuiltinType (tp)
   return tp.cv == 'const' and integral_types [tp.builtin]
end

-- on other types
local function no ()
   return false
end
IsTypeConstIntegral.onPointerType = no
IsTypeConstIntegral.onPointerToMemberType = no
IsTypeConstIntegral.onReferenceType = no
IsTypeConstIntegral.onRvalueReferenceType = no
IsTypeConstIntegral.onFunctionType = no
IsTypeConstIntegral.onElabType = no
IsTypeConstIntegral.onUserType = no

return isTypeConstIntegral
