-----------------------------------------------------------------------------
-- lzz app
-----------------------------------------------------------------------------
require 'util/class'
-----------------------------------------------------------------------------
require 'lzz/node/class'
require 'lzz/node/decl'
require 'lzz/node/name'
require 'lzz/node/namespace'
require 'lzz/node/param_decl'
require 'lzz/node/simple_decl'
-----------------------------------------------------------------------------
local NsScope             = require 'lzz/scope/ns_scope'
local printNs             = require 'lzz/namespace/print_ns'
-----------------------------------------------------------------------------

local Lzz = application ()
function Lzz:init ()
   self.scopes = {}
   self:pushScope (NsScope {})
end

-- get current scope (DEPRECATED)
function Lzz:getCurrentScope ()
   local scopes = self.scopes
   return scopes [#scopes]
end

function Lzz:getScope ()
   local scopes = self.scopes
   return scopes [#scopes]
end

-- push scope, scope becomes current scope
function Lzz:pushScope (scope)
   table.insert (self.scopes, scope)
end

-- pop current scope
function Lzz:popScope ()
  table.remove (self.scopes)
end

-- finish
function Lzz:onTree ()
   printNs (self:getCurrentScope ().ns)
end
