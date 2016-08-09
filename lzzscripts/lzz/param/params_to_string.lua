-----------------------------------------------------------------------------
-- return params as string joined by comma with optional parens or angle brackets
-----------------------------------------------------------------------------

-- return params as string with default args if is_decl true
local function helper(params, is_decl)
   local strs = {} 
   for _, param in ipairs(params) do
      table.insert(strs, param:toString(is_decl))
   end
   return table.concat(strs, ', ')
end

-- params to string with default args if is_decl true
-- add parens if context='func', angle brackets if context='tmpl'
local function paramsToString(params, is_decl, context)
   local str = helper(params, is_decl)
   if context == 'func' then
      str = '(' .. str .. ')'
   elseif context == 'tmpl' then
      str = '<' .. str .. '>'
   end
   return str
end

return paramsToString
