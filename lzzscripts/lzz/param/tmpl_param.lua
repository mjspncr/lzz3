-----------------------------------------------------------------------------
-- template param
-----------------------------------------------------------------------------
local nameToString        = require 'lzz/name/name_to_string'
local paramsToString      = require 'lzz/param/params_to_string'
-----------------------------------------------------------------------------

local TmplParam = {}
TmplParam.__index = TmplParam

-- to string
function TmplParam:toString (is_decl)
   local strs = table.pack ('template', paramsToString (self.params, false, 'tmpl'), 'class', nameToString (self.name))
   if is_decl and self.default then
      table.insert (strs, '=')
      table.insert (strs, nameToString (self.default))
   end
   return table.concat (strs, ' ')
end

return TmplParam
