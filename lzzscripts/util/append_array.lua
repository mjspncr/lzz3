
-- append array2 to array1 and return array1
local function appendArray (array1, array2)
   for _, x in ipairs (array2) do
      table.insert (array1, x)
   end
   return array1
end

return appendArray
