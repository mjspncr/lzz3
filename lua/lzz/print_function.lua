-- lzz.print_function
--

local _cv_spec_seq = require('lzz.cv_spec_seq')
local _name = require('lzz.name')
local _param = require('lzz.param')

local Printer = {}
Printer.__index = Printer

-- declaration as string
function Printer:decl_to_string(fun)
   local spec_strs = {}
   if fun.linkage then
      table.insert(spec_strs, 'extern ' .. fun.linkage)
   elseif fun.is_extern then
      table.insert(spec_strs, 'extern')
   end
   if fun.friend then
      table.insert(spec_strs, 'friend')
   end
   if not self.no_inline and fun.is_inline then
      table.insert(spec_strs, 'LZZ_INLINE')
   end
   if not self.no_virtual and fun.is_virtual then
      table.insert(spec_strs, 'virtual')
   end
   if not self.no_explicit and fun.is_explicit then
      table.insert(spec_strs, 'explicit')
   end
   if not self.no_static and fun.is_static then
      table.insert(spec_strs, 'static')
   end
   local name = fun.name
   if self.qual_name then
      name = _name.new_qualified_name(self.qual_name, name)
   end
   local dcl_str = name:to_string() .. _param.func_params_to_string(fun.params, self.is_decl)
   if fun.cv then
      dcl_str = dcl_str .. ' ' .. _cv_spec_seq.to_string(fun.cv)
   end
   if not self.no_pure and fun.is_pure then
      dcl_str = dcl_str .. ' = 0'
   end
   --[=[
   if fun.throw_spec then
      dcl_str = appends(dcl_str, throwSpecToString(fun.throw_spec))
   end
   --]=]
   local to_type = fun.type
   if to_type then
      dcl_str = to_type:to_string(dcl_str) 
   end
   if #spec_strs > 0 then
      return table.concat(spec_strs, ' ') .. ' ' .. dcl_str
   end
   return dcl_str
end

-- open and close namespace 
function Printer.open_ns(file, ns)
   if ns then
      ns:print_open(file)
   end
end
function Printer.close_ns(file, ns)
   if ns then
      ns:print_close(file)
   end
end

-- print func decl to file, namespace optional
function Printer:print_decl(file, fun, ns)
   Printer.open_ns(file, ns)
   --[=[
   -- template specs if template function
   if fun.tmpl_specs then
      printTmplSpecs(file, fun.tmpl_specs, self.is_decl)
   end
   --]=]
   file:print(fun.name:get_loc(), self:decl_to_string(fun) .. ';')
   Printer.close_ns(file, ns)
end

-- print func definition with optional template specs and namespace
function Printer:print_defn(file, fun, tmpl_specs, ns)
   Printer.open_ns(file, ns)
   --[=[
   -- template specs
   if tmpl_specs then
      printTmplSpecs(file, tmpl_specs)
   end
   if fun.tmpl_specs then
      printTmplSpecs(file, fun.tmpl_specs, self.is_decl)
   end
   --]=]
   -- decl
   file:print(fun.name:get_loc(), self:decl_to_string(fun))
   -- try
   if fun.handlers then
      file:print(getNameLoc(fun.name), 'try')
   end
   -- ctor member init
   local ctor_init = fun.ctor_init
   if ctor_init and #ctor_init > 0 then
      printCtorInit(file, ctor_init)
   end
   -- body
   file:print_enclosed_block(fun.body.loc, fun.body.lexeme)
   -- try catch handlers
   if fun.handlers then
      for _, handler in ipairs(fun.handlers) do
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
   Printer.close_ns(file, ns)
end

local function new_printer(args)
   return setmetatable(args, Printer)
end

-- print namespace function definition
local function print_ns_defn(fun, ns)
   local decl_file, defn_file
   if fun.is_static or ns.is_unnamed then
      decl_file = lzz.src_decl()
      defn_file = lzz.src_body()
   else
      --local is_tmpl = fun.tmpl_specs ~= nil
      --local is_expl_spec = is_tmpl and isExplicitTmplSpec(fun.tmpl_specs)
      local is_tmpl = false
      local is_expl_spec = false

      local is_inline = fun.is_inline
      if not fun.name.is_qualified then
         decl_file = lzz.hdr_decl(false, false)
      end
      if not is_tmpl or is_expl_spec then
         if is_inline then
            defn_file = lzz.hdr_decl(true, false)
         else
            defn_file = lzz.src_body()
         end
      else
         defn_file = lzz.hdr_body(is_inline, true)
      end      
   end
   if decl_file then
      local printer = new_printer{is_decl=true, no_inline=true}
      printer:print_decl(decl_file, fun, ns)
   end
   -- always have definition
   local printer = new_printer{is_decl=(not decl_file)}
   printer:print_defn(defn_file, fun, nil, ns)
end

-- print namespace function dcl
local function print_ns_decl(fun, ns)
   local printer = new_printer{is_decl=true}
   if fun.is_static or ns.is_unnamed then
      printer:print_decl(lzz.src_body(), fun, ns)
   else
      printer:print_defn(lzz.hdr_decl(false, false), fun, ns)
   end
end

local module = {}

-- print namespace definition
function module.print_def(fun, ns)
   if fun.is_defn then
      print_ns_defn(fun, ns)
   else
      print_ns_decl(fun, ns)
   end
end

return module
