-----------------------------------------------------------------------------
-- is explicit template spec?
-----------------------------------------------------------------------------

local function isExplicitTmplSpec(specs)
   if specs then
      -- true if all specs empty
      for _, spec in ipairs(specs) do
         if #spec > 0 then
            return false
         end
      end
      return true
   end
   -- not a template
   return false
end

return isExplicitTmplSpec
