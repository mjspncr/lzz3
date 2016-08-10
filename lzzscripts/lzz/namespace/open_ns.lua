-----------------------------------------------------------------------------
-- open namespace (move to scope)
-----------------------------------------------------------------------------
local NsEntity            = require 'lzz/entity/ns_entity'
local NsScope             = require 'lzz/scope/ns_scope'
local addEntity           = require 'lzz/misc/add_entity'
-----------------------------------------------------------------------------

-- open namespace, return namespace scope
local function openNs(scope, loc, name)
   -- scope can only be a namespace scope
   local encl_ns = scope.ns
   -- set flag if unnamed or enclosed in unnamed namespace
   local unnamed
   if encl_ns.unnamed or not name then
      unnamed = true
   end
   local ns = setmetatable({encl_ns=encl_ns, loc=loc, name=name, unnamed=unnamed}, NsEntity)
   addEntity(encl_ns, ns)
   return NsScope(ns)
end

return openNs
