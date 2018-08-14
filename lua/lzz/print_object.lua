-- lzz.print_object
--

local Printer = {}
Printer.__index = Printer

-- return declaration as string
function Printer:dcl_to_string(obj)
   local spec_strs = {}
   if obj.linkage then
      table.insert(spec_strs, string.format('extern %s', obj.linkage))
   elseif not self.no_extern and (self.is_extern or obj.is_extern) then
      table.insert(spec_strs, 'extern')
   end
   if not self.no_static and obj.is_static then
      table.insert(spec_strs, 'static')
   end
   if obj.is_mutable then
      table.insert(spec_strs, 'mutable')
   end
   local name = obj.name
   if self.qual_name then
      name = _name.new_qualified_name(self.qual_name, name)
   end
   local type_str = obj.type:to_string(name:to_string())
   if #spec_strs > 0 then
      return table.concat(spec_strs, ' ') .. ' ' .. type_str
   else
      return type_str
   end
end

-- open and close namespace 
local function open_ns(file, ns)
   if ns then
      ns:print_open(file)
   end
end
local function close_ns(file, ns)
   if ns then
      ns:print_close(file)
   end
end

-- print object to file, namespace optional
function Printer:print(file, obj, tmpl_specs, ns)
   open_ns(file, ns)
   --[=[
   if tmpl_specs then
      printTmplSpecs(file, tmpl_specs)
   end
   --]=]
   local str = self:dcl_to_string(obj)
   if self.with_init and obj.init then
      local init_format, init_expr = table.unpack(obj.init)
      str = str .. ' ' .. string.format(init_format, init_expr)
   end
   file:print(obj.name:get_loc(), str .. ';')
   close_ns(file, ns)
end

-- return new printer with args
local function new_printer(args)
   return setmetatable(args, Printer)
end

local module = {}

-- print namespace object
function module.print_def(obj, ns)
   local has_decl, has_defn = true, true
   local is_qual = obj.name.is_qualified
   if obj.is_static or ns.is_unnamed then
      has_decl = false
   elseif obj.is_extern or obj.linkage then
      has_defn = obj.init ~= nil
      has_decl = not (has_defn and is_qual)
   else
      has_decl = not (obj.type:is_const() or is_qual)
   end
   if has_decl then
      local printer = new_printer{is_extern = true}
      printer:print(lzz.hdr_decl(false, false), obj, nil, ns)
   end      
   if has_defn then
      local printer = new_printer{with_init=true, no_extern=has_decl}
      printer:print(has_decl and lzz.src_body() or lzz.src_decl(), obj, nil, ns)
   end
end

return module
