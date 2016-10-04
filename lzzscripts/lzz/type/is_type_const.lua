-----------------------------------------------------------------------------
-- is type const?
-----------------------------------------------------------------------------

local IsTypeConst = {}
local function isTypeConst (tp)
   return tp:accept (IsTypeConst)
end

-- on builtin
function IsTypeConst:onBuiltinType (type)
   return type.cv == 'const' 
end
IsTypeConst.onPointerType = IsTypeConst.onBuiltinType
IsTypeConst.onPointerToMemberType = IsTypeConst.onBuiltinType
IsTypeConst.onElabType = IsTypeConst.onBuiltinType
IsTypeConst.onUserType = IsTypeConst.onBuiltinType

-- on reference
function IsTypeConst:onReferenceType (type)
   return false
end
IsTypeConst.onRvalueReferenceType = IsTypeConst.onReferenceType
IsTypeConst.onFunctionType = IsTypeConst.onReferenceType
IsTypeConst.onArrayType = IsTypeConst.onReferenceType

return isTypeConst
