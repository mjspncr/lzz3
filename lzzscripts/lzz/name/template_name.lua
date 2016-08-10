-----------------------------------------------------------------------------
-- template name
-----------------------------------------------------------------------------

local TemplateName = class ()
function TemplateName:__init (has_tmpl, base_name, args)
   -- has_tmpl true if base_name prefixed with explicit 'template' keyword
   self.has_tmpl = has_tmpl
   self.base_name = base_name
   -- args is a string
   self.args = args
end

-- accept visitor
function TemplateName:accept (visitor)
   return visitor:onTemplateName (self)
end

return TemplateName
