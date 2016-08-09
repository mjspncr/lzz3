-----------------------------------------------------------------------------
-- const volatile spec selection
-----------------------------------------------------------------------------
local CvSpec              = require 'lzz/misc/cv_spec'
local specSel             = require 'lzz/misc/spec_sel'
-----------------------------------------------------------------------------

local CvSpecSel = specSel (CvSpec)

-- get cv from specs
function CvSpecSel:getCv ()
   return self:toString ()
end

return CvSpecSel
