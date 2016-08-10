-----------------------------------------------------------------------------
-- function and storage spec selection
-----------------------------------------------------------------------------
local FtorSpec            = require 'lzz/misc/ftor_spec'
local specSel             = require 'lzz/misc/spec_sel'
-----------------------------------------------------------------------------

local FtorSpecSel = specSel (FtorSpec)

-- check spec flags, error if any 1 found
function FtorSpecSel:checkSpecs1 (flags, msg)
   local flags = self.flags & flags
   local i = 1
   while i <= flags do
      if i & flags ~= 0 then
         lzz.error (self [i], string.format (msg, self:name (i)))
      end
      i = i << 1
   end
end

-- check spec flags, error if any 2 found
function FtorSpecSel:checkSpecs2 (flags, msg)
   local flags = self.flags & flags
   local i = 1
   while i <= flags do
      if i & flags ~= 0 then
         local j = i << 1
         while j <= flags do
            if j & flags ~= 0 then
               lzz.error (self [j], string.format (msg, self:name (j), self:name (i)))
            end
            j = j << 1
         end
      end
      i = i << 1
   end
end

-- return member function that returns true if spec is set
local function isSpec (spec)
   return function (self)
      return self:has (spec)
   end
end

FtorSpecSel.isStatic   = isSpec (FtorSpec.STATIC)
FtorSpecSel.isExtern   = isSpec (FtorSpec.EXTERN)
FtorSpecSel.isMutable  = isSpec (FtorSpec.MUTABLE)
FtorSpecSel.isInline   = isSpec (FtorSpec.INLINE)
FtorSpecSel.isVirtual  = isSpec (FtorSpec.VIRTUAL)
FtorSpecSel.isExplicit = isSpec (FtorSpec.EXPLICIT)

return FtorSpecSel
