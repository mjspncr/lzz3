-----------------------------------------------------------------------------
-- define functor
-----------------------------------------------------------------------------
local OperName            = require 'lzz/name/oper_name' 
local defineFunc          = require 'lzz/scope/define_func'
local defineLazyClass     = require 'lzz/scope/define_lazy_class'
local getNameLoc          = require 'lzz/name/get_name_loc'
-----------------------------------------------------------------------------

local function defineFunctor (scope, functor_def)
   local name = functor_def.name
   local cls_def = {
      cls_key = 'struct',
      name = name,
      base_specs = functor_def.base_specs,
   }
   scope = defineLazyClass (scope, cls_def, functor_def.ctor_params)
   functor_def.base_specs  = nil
   functor_def.ctor_params = nil
   functor_def.name = OperName (getNameLoc (name), '()')
   defineFunc (scope, functor_def)
end

return defineFunctor
