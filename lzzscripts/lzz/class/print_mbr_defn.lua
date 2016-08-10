-----------------------------------------------------------------------------
-- print member definitions
-----------------------------------------------------------------------------

-- print class member definitions in namespace
local function printMbrDefn (cls_defn, tmpl_specs, ns, nested_name)
   for _, entity in ipairs (cls_defn) do
      entity:printMbrDefn (tmpl_specs, ns, nested_name)
   end
end

return printMbrDefn
