-----------------------------------------------------------------------------
-- typedef entity
-----------------------------------------------------------------------------
local Entity              = require 'lzz/entity/entity'
local printTdef           = require 'lzz/typedef/print_tdef'
-----------------------------------------------------------------------------
local TdefEntity = class(Entity)

-- print in ns
function TdefEntity.printNsDefn(tdef, ns)
   local file
   if ns.unnamed then
      file = lzz.srcFile('DECL')
   else
      file = lzz.hdrFile(false, false, 'DECL')
   end
   printTdef(file, tdef, ns)
end

-- print member in class
function TdefEntity.printMbrDecl(tdef, file)
   printTdef(file, tdef)
end

return TdefEntity
