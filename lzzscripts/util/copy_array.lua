local appendArray = require 'util/append_array'

-- append array2 to array1
local function copyArray (array)
   return appendArray ({}, array)
end
return copyArray
