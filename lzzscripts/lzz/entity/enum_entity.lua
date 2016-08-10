-----------------------------------------------------------------------------
-- enum entity
-----------------------------------------------------------------------------
local Entity              = require 'lzz/entity/entity'
local printEnum           = require 'lzz/enum/print_enum'
-----------------------------------------------------------------------------
local EnumEntity = class (Entity)

-- print in ns
function EnumEntity.printNsDefn (enum, ns)
   local file
   if ns.unnamed then
      file = lzz.srcFile ('DECL')
   else
      file = lzz.hdrFile (false, false, 'DECL')
   end
   return printEnum (file, enum, ns)
end

-- print in class
function EnumEntity.printMbrDecl (enum, file)
   return printEnum (file, enum, ns)
end

return EnumEntity
