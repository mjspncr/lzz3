-----------------------------------------------------------------------------
-- function declaration
-----------------------------------------------------------------------------
local Entity              = require 'lzz/entity/entity'
local FuncDeclPrinter     = require 'lzz/function/func_decl_printer'
-----------------------------------------------------------------------------
local FuncDeclEntity = class (Entity)

-- print ns decl
function FuncDeclEntity.printNsDefn (func_decl, ns)
   local printer = FuncDeclPrinter ()
   printer.is_decl = true
   if func_decl.specs:isStatic () or ns.unnamed or func_decl.is_inst then
      printer:print (lzz.srcFile ('DECL'), func_decl, ns)
   else
      printer:print (lzz.hdrFile (false, false, 'DECL'), func_decl, ns)
   end
end

-- print mbr decl
function FuncDeclEntity.printMbrDecl (func_decl, file)
   local printer = FuncDeclPrinter ()
   printer.is_decl = true
   printer.no_inline = true
   printer:print (file, func_decl)
end

return FuncDeclEntity
