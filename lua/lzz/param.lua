-- lzz.param
--

-- non type parameter
local NonTypeParam = {} 
NonTypeParam.__index = NonTypeParam
-- to string
function NonTypeParam:to_string(is_decl)
   -- any specifiers?
   local str = self.type:to_string(self.name:to_string())
   if self.default_arg then
      str = str .. ' = ' .. self.default_arg
   end
   return str
end

-- return params as string with default args if is_decl true
local function params_to_string(params, is_decl)
   local strs = {} 
   for _, param in ipairs(params) do
      table.insert(strs, param:to_string(is_decl))
   end
   return table.concat(strs, ', ')
end

local module = {}

-- new non type param
function module.new_non_type_param(args)
   return setmetatable(args, NonTypeParam)
end

-- function params to string, default args if is_decl true
function module.func_params_to_string(params, is_decl)
   local params_str = params_to_string(params, is_decl)
   return '(' .. params_str .. ')'
end

return module
