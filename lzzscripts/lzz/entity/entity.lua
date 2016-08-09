-----------------------------------------------------------------------------
-- entity
-----------------------------------------------------------------------------
local dummy               = require 'util/dummy'
-----------------------------------------------------------------------------
local Entity = class ()

-- these should always be defined
--Entity.printNsDefn  = dummy
--Entity.printMbrDecl = dummy

-- optional
Entity.printMbrDefn = dummy

-- or
--
-- Entity.printDecl
-- Entity.printMbrDecl
-- Entity.printMbrNsDecl

-- or
-- Entity.printNs
-- Entity.printMbr
-- Entity.printNsMbr

return Entity
