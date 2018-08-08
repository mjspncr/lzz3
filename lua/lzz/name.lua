-- lzz.name
--

--
-- base (or leaf) names
--

-- all base names have a loccation
local function get_loc(self)
   return self.loc
end

-- simple name, loc and ident
local SimpleName = {get_loc=get_loc}
SimpleName.__index = SimpleName

-- return name as string
function SimpleName:to_string()
   return self.ident
end

-- operator name, loc and oper
local OperName = {get_loc=get_loc}
OperName.__index = OperName 

-- return name as string
function OperName:to_string()
   return self.oper
end

-- destructor name
local DtorName = {get_loc=get_loc}
DtorName.__index = DtorName

-- return name as string
function DtorName:to_string()
   return '~' .. self.ident
end

--
-- compound names
--

-- template name, has_tmpl flag, base_name, and args
local TemplateName = {}
TemplateName.__index = TemplateName

-- return name as string
function TemplateName:to_string()
   -- just in case old complier avoid >>
   local args = self.args
   if string.sub(args, -1) == '>' then
      args = args .. ' '
   end
   local s = string.format('%s <%s>', self.base_name:to_string(), args)
   if self.has_tmpl then
      return 'template ' .. s
   else
      return s
   end
end

-- qualified name, nested_name and name
local QualifiedName = {}
QualifiedName.__index = QualifiedName

-- return name as string
function QualifiedName:to_string()
   local s = '::' .. self.name:to_string()
   if self.nested_name then
      return self.nested_name:to_string() .. s
   end
   return s
end

-- module table
local module = {}

-- return new simple name
function module.new_simple_name(loc, ident)
   return setmetatable({loc=loc, ident=ident}, SimpleName)
end

-- return new operator name
function module.new_oper_name(loc, oper)
   return setmetatable({loc=loc, oper=oper}, OperName)
end

-- return new dtor name
function module.new_dtor_name(loc, oper)
   return setmetatable({loc=loc, oper=oper}, DtorName)
end

-- new template name
function module.new_template_name(has_tmpl, base_name, args)
   return setmetatable({has_tmpl=has_tmpl, base_name=base_name, args=args}, TemplateName)
end

-- new qualified name
function module.new_qualified_name(nested_name, name)
   return setmetatable({nested_name=nested_name, name=name}, QualifiedName)
end

return module
