-----------------------------------------------------------------------------
-- print namespace contents
-----------------------------------------------------------------------------
local function printNs(ns)
   for _, entity in ipairs (ns) do
      entity:printNsDefn (ns)
   end
end

return printNs
