-----------------------------------------------------------------------------
-- print enum
-----------------------------------------------------------------------------
local getNameLoc          = require 'lzz/name/get_name_loc'
local nameToString        = require 'lzz/name/name_to_string'
local printNsClose        = require 'lzz/namespace/print_ns_close'
local printNsOpen         = require 'lzz/namespace/print_ns_open'
-----------------------------------------------------------------------------

-- print enum
local function printEnum (file, enum, ns)
   local n = printNsOpen (ns, file)
   local name = enum.name
   if name then
      if enum.class_key then
         file:print (getNameLoc (name), 'enum ' .. enum.class_key .. ' ' .. nameToString (name))
      else
         file:print (getNameLoc (name), 'enum ' .. nameToString (name))
      end
   else
      file:print (enum.loc, 'enum')
   end
   file:printOpenBrace ()
   for _, enumtor in ipairs (enum) do
      local name, init = table.unpack (enumtor)
      local str = nameToString (name)
      if init then
         str = str .. ' = ' .. init
      end
      file:print (getNameLoc (name), str .. ',')
   end
   file:printCloseBrace (true)
   printNsClose (file, n)
end

return printEnum