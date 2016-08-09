-----------------------------------------------------------------------------
-- decl spec sel
-----------------------------------------------------------------------------
local BuiltinSpecSel      = require 'lzz/misc/builtin_spec_sel'
local BuiltinType         = require 'lzz/type/builtin_type'
local CVSpecSel           = require 'lzz/misc/cv_spec_sel'
local FtorSpecSel         = require 'lzz/misc/ftor_spec_sel'
-----------------------------------------------------------------------------

local DeclSpecSel = class ()

-- set typedef spec (all set/add functions return self)
function DeclSpecSel:setTypedef (token)
   self.typedef = token.loc
   return self
end

-- set friend
function DeclSpecSel:setFriend (token)
   self.friend = token.loc
   return self
end

-- set type
function DeclSpecSel:setType (tp)
   self.tp = tp
   return self
end

-- add cv specifier
function DeclSpecSel:addCv (token)
   local specs = self.cv_specs or CVSpecSel ()
   self.cv_specs = specs:add (token)
   return self
end

-- add builtin spec
function DeclSpecSel:addBuiltin (token)
   local specs = self.bltn_specs or BuiltinSpecSel ()
   self.bltn_specs = specs:add (token)
   return self
end

-- add function or storage specifier
function DeclSpecSel:addFtor (token)
   local specs = self.ftor_specs or FtorSpecSel ()
   self.ftor_specs = specs:add (token)
   return self
end

-- get cv string
function DeclSpecSel:getCv ()
   local specs = self.cv_specs
   if specs then
      return specs:getCv ()
   else
      return nil
   end
end

-- get decl spec 
function DeclSpecSel:getDeclSpec ()
   local tp
   if self.bltn_specs then
      tp = BuiltinType (self:getCv (), self.bltn_specs:getBuiltin ())
   elseif self.tp then
      tp = self.tp
      tp.cv = self:getCv ()
   end
   local specs = self.ftor_specs or FtorSpecSel ()
   return {typedef=self.typedef, friend=self.friend, specs=specs, tp=tp}
end

return DeclSpecSel
