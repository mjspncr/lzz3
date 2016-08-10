-----------------------------------------------------------------------------
-- spec selection
-----------------------------------------------------------------------------
local specsToString       = require 'lzz/misc/specs_to_string'
-----------------------------------------------------------------------------

-- return spec sel class with specs from Spec
local function specSel (Spec)
   local SpecSel = class ()
   function SpecSel:__init ()
      self.flags = 0
   end
   -- add spec, return self
   function SpecSel:add (token)
      local flag = Spec.specs [token.lexeme]
      if self.flags & flag ~= 0 then
         -- duplicate specifier
      else
         self.flags = self.flags | flag
         self [flag] = token.loc
      end
      return self
   end
   -- true if has spec
   function SpecSel:has (spec)
      return self.flags & spec ~= 0
   end
   -- return name of spec
   function SpecSel:name (spec)
      return Spec.names [spec]
   end
   -- to string, apply filter to flags if set
   function SpecSel:toString (filter)
      local flags = self.flags
      if filter then
         flags = flags & filter
      end
      return specsToString (Spec, flags)
   end
   return SpecSel
end

return specSel
