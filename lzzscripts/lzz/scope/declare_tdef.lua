-----------------------------------------------------------------------------
-- declare typedef
-----------------------------------------------------------------------------
local TdefEntity          = require 'lzz/entity/tdef_entity'
local addEntity           = require 'lzz/misc/add_entity'
-----------------------------------------------------------------------------

local DeclareTdef = class ()
function DeclareTdef:__init (tdef)
   self.tdef = tdef
end

-- declare typedef
local function declareTdef (scope, tdef)
   return scope:accept (DeclareTdef (tdef))
end

-- build entity
function DeclareTdef:buildEntity ()
   return setmetatable (self.tdef, TdefEntity)
end

-- in namespace
function DeclareTdef:onNs (ns)
   return addEntity (ns, self:buildEntity ())
end

-- in class
function DeclareTdef:onClassDefn (cls_defn)
   return addEntity (cls_defn, self:buildEntity ())
end

return declareTdef
