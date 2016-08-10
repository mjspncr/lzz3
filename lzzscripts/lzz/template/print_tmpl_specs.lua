-----------------------------------------------------------------------------
-- print template specs to file
-----------------------------------------------------------------------------
local printTmplSpec       = require 'lzz/template/print_tmpl_spec'
-----------------------------------------------------------------------------

-- with default args if is_decl true
local function printTmplSpecs(file, specs, is_decl)
   for _, spec in ipairs(specs) do
      printTmplSpec(file, spec, is_decl)
   end
end

return printTmplSpecs
