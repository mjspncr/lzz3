
local function ctor (cls, ...)
   local obj = setmetatable ({}, cls)
   if cls.__init then
      cls.__init (obj, ...)
   end
   return obj
end

local CLASS = { __call = ctor }

function class (base)
   local cls = {}
   -- if has base class make shallow copy
   if base then
      for k, v in pairs (base) do
         cls [k] = v
      end
   end
   cls.__index = cls
   return setmetatable (cls, CLASS)
end
