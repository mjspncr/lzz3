-----------------------------------------------------------------------------
-- specs to string
-----------------------------------------------------------------------------

local function specsToString (Spec, specs)
   local strs = {}
   local i = 1
   while i <= specs do
      if i & specs ~= 0 then
         table.insert (strs, Spec.names [i])
      end
      i = i << 1
   end
   return table.concat (strs, ' ')
end

return specsToString
