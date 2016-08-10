-----------------------------------------------------------------------------
-- get function (non type) parameter types
-----------------------------------------------------------------------------

local function getFuncParamTypes (params)
   local types = {}
   for _, param in ipairs (params) do
      table.insert (types, param.tp)
   end
   types.is_vararg = params.has_ellipse
   return types
end

return getFuncParamTypes
