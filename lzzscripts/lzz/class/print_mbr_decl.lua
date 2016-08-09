-----------------------------------------------------------------------------
-- print member declarations
-----------------------------------------------------------------------------

-- print class member declarations
local function printMbrDecl (cls_defn, file)
   for _, entity in ipairs (cls_defn) do
      entity:printMbrDecl (file)
   end
end

return printMbrDecl
