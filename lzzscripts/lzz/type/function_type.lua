-----------------------------------------------------------------------------
-- function type
-----------------------------------------------------------------------------

local FunctionType = class ()
function FunctionType:__init (cv, to_tp, param_tps, throw_spec)
   self.cv = cv
   self.to_tp = to_tp
   self.param_tps = param_tps
   self.throw_spec = throw_spec
end

-- accept visitor
function FunctionType:accept (visitor)
   return visitor:onFunctionType (self)
end

return FunctionType
