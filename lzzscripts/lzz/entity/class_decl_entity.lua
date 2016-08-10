-----------------------------------------------------------------------------
-- class decl entity
-----------------------------------------------------------------------------
local Entity              = require 'lzz/entity/entity'
local printClassDecl      = require 'lzz/class/print_class_decl'
-----------------------------------------------------------------------------

local ClassDeclEntity = class (Entity)

-- print ns definition
function ClassDeclEntity.printNsDefn (cls_decl, ns)
   local file
   if ns.unnamed or cls_decl.is_inst then
      file = lzz.srcFile ('DECL')
   else
      file = lzz.hdrFile (false, false, 'DECL')
   end
   printClassDecl (file, cls_decl, ns)
end

-- print member declaration
function ClassDeclEntity.printMbrDecl (cls_decl, file)
   printClassDecl (file, cls_decl)
end

return ClassDeclEntity
