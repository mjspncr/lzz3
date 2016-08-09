-----------------------------------------------------------------------------
-- base spec array to string
-----------------------------------------------------------------------------

local function baseSpecsToString (base_specs)
   local strs = {} 
   for _, base_spec in ipairs (base_specs) do
      table.insert (strs, base_spec:toString ())
   end
   return table.concat (strs, ', ')
end

return baseSpecsToString
