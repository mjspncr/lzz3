-----------------------------------------------------------------------------
-- define lazy class
-----------------------------------------------------------------------------
local DtorName            = require 'lzz/name/dtor_name'
local FtorSpecSel         = require 'lzz/misc/ftor_spec_sel'
local declareObj          = require 'lzz/scope/declare_obj'
local defineClass         = require 'lzz/scope/define_class'
local defineFunc          = require 'lzz/scope/define_func'
local getCtorName         = require 'lzz/name/get_ctor_name'
local getNameLoc          = require 'lzz/name/get_name_loc'
local nameToString        = require 'lzz/name/name_to_string'
local setAccess           = require 'lzz/scope/set_access'
-----------------------------------------------------------------------------

-- initialize base objects in ctor_init list
local function initBaseObjs(specs, ctor_init)
   if specs then
      for _, spec in ipairs(specs) do
         init = spec.init
         if init then
            local kind, exprs = table.unpack(init)
            if exprs then
               table.insert(ctor_init, {kind, spec.name, table.concat(exprs, ', ')})
            end
         end
      end
   end
end

-- true if arg matches an expr
local function isExpr(exprs, arg)
   for _, expr in ipairs(exprs) do
      if expr == arg then
         return true
      end
   end
   return false
end

-- true if arg matches any expr in base_specs
local function isBaseSpecExpr(base_specs, arg)
   for _, base_spec in ipairs(base_specs) do
      local init = base_spec.init
      if init and isExpr(init[2], arg) then
         return true
      end
   end
   return false
end

-- declare ctor params
local function declareParams(scope, params, base_specs)
   for _, param in ipairs(params) do
      local name = param.name
      local expr = nameToString(name)
      if not(base_specs and isBaseSpecExpr(base_specs, expr)) then
         declareObj(scope, {specs=param.specs, name=name, tp=param.tp, init={'paren', expr}})
      end
   end
end

-- define ctor and dtor
local function defineCtor(scope, name, params, ctor_init)
   -- ctor
   local loc = getNameLoc(name)
   local ctor_name = getCtorName(name)
   local body = {loc=loc, lexeme=''}
   defineFunc(scope, {specs = FtorSpecSel():add{loc=loc, lexeme='inline'}:add{loc=loc, lexeme='explicit'},
                      name = ctor_name,
                      params = params,
                      ctor_init = ctor_init,
                      body = body})
   -- dtor
   local dtor_name = DtorName(loc, ctor_name.ident)
   defineFunc(scope, {specs = FtorSpecSel(),
                      name = dtor_name,
                      params = {},
                      body = body})
end

-- define lazy class
local function defineLazyClass(scope, cls_def, params)
   local loc = getNameLoc(cls_def.name)
   local ctor_init = {loc=loc}
   local base_specs = cls_def.base_specs
   initBaseObjs(base_specs, ctor_init)
   cls_def.ctor_init = ctor_init
   scope = defineClass(scope, cls_def)
   declareParams(scope, params, base_specs)
   local is_class = cls_def.cls_key == 'class'
   if is_class then
      setAccess(scope, loc, 'public')
   end
   defineCtor(scope, cls_def.name, params, ctor_init)
   if is_class then
      setAccess(scope, loc, 'private')
   end
   return scope
end

return defineLazyClass
