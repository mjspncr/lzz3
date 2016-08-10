-----------------------------------------------------------------------------
-- get template spec as template name arg
-----------------------------------------------------------------------------
local nameToString        = require 'lzz/name/name_to_string'
-----------------------------------------------------------------------------

-- just the param names joined by comma
local function tmplSpecToArg(spec)
   local strs = {} 
   for _, param in ipairs(spec) do
      table.insert(strs, nameToString(param.name))
   end
   return table.concat(strs, ', ')
end

return tmplSpecToArg