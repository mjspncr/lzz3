-----------------------------------------------------------------------------
-- print template spec to file
-----------------------------------------------------------------------------
local paramsToString      = require 'lzz/param/params_to_string'
-----------------------------------------------------------------------------

-- with default args if is_decl true
local function printTmplSpec(file, params, is_decl)
   file:print(params.loc, 'template ' .. paramsToString(params, is_decl, 'tmpl'))
end

return printTmplSpec
