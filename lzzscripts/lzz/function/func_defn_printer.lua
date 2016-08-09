-----------------------------------------------------------------------------
-- function definition printer
-----------------------------------------------------------------------------
local FuncDeclPrinter     = require 'lzz/function/func_decl_printer'
local getNameLoc          = require 'lzz/name/get_name_loc'
local nameToString        = require 'lzz/name/name_to_string'
local printNsClose        = require 'lzz/namespace/print_ns_close'
local printNsOpen         = require 'lzz/namespace/print_ns_open'
local printTmplSpecs      = require 'lzz/template/print_tmpl_specs'
-----------------------------------------------------------------------------

local FuncDefnPrinter = class(FuncDeclPrinter)

-- print ctor member init
local function printCtorInit(file, inits)
   local strs = {}
   for _, init in ipairs(inits) do
      local kind, name, block = table.unpack(init)
      local str = nameToString(name)
      if kind == 'brace' then
         -- brace enclosed init
         str = str .. ' {' .. block .. '}'
      else
         -- otherwise assign or paren
         str = str .. ' (' .. block .. ')'
      end
      table.insert(strs, str)
   end
   file:print(inits.loc, ': ' .. table.concat(strs, ', '), 1)
end

-- print func definition with optional template specs and namespace
function FuncDefnPrinter:print(file, func, tmpl_specs, ns)
   local n = printNsOpen(ns, file)
   -- template specs
   if tmpl_specs then
      printTmplSpecs(file, tmpl_specs)
   end
   if func.tmpl_specs then
      printTmplSpecs(file, func.tmpl_specs, self.is_decl)
   end
   -- decl
   file:print(getNameLoc(func.name), self:declToString(func))
   -- try
   if func.handlers then
      file:print(getNameLoc(func.name), 'try')
   end
   -- ctor member init
   local ctor_init = func.ctor_init
   if ctor_init and #ctor_init > 0 then
      printCtorInit(file, ctor_init)
   end
   -- body
   file:printEnclosedBlock(func.body.loc, func.body.lexeme)
   -- try catch handlers
   if func.handlers then
      for _, handler in ipairs(func.handlers) do
         local loc, param, block = table.unpack(handler)
         local param_str
         -- if no param then catch all
         if param then
            param_str = param:toString()
         else
            param_str = '...'
         end
         file:print(loc, 'catch (' .. param_str .. ')')
         file:printEnclosedBlock(block.loc, block.lexeme)
      end
   end
   printNsClose(file, n)
end

return FuncDefnPrinter
