-----------------------------------------------------------------------------
-- print namespace close, depth n 
-----------------------------------------------------------------------------
local function printNsClose(file, n)
   for i = 1, n do
      file:printCloseBrace()
   end
end

return printNsClose
