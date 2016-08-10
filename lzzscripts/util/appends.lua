-----------------------------------------------------------------------------
-- append string with space
-----------------------------------------------------------------------------

local function appends (str1, str2)
   type_str1 = type (str1)
   if type_str1 == 'nil' or type_str1 == 'string' and #str1 == 0 then
      return str2
   end
   type_str2 = type (str2)
   if type_str2 == 'nil' or type_str2 == 'string' and #str2 == 0 then
      return str1
   end
   return str1 .. ' ' .. str2
end

return appends
