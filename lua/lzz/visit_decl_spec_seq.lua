-- lzz.decl_spec_seq_visitor
--

local _cv_spec_seq = require('lzz.cv_spec_seq')
local _builtin_spec_seq = require('lzz.builtin_spec_seq')
local _ftor_spec_seq = require('lzz.ftor_spec_seq')
local _type = require('lzz.type')

-- node visitor
local Visitor = {}
Visitor.__index = Visitor

-- add ftor spec
function Visitor:add_ftor_spec(token)
   self.ftor_spec_seq = self.ftor_spec_seq or _ftor_spec_seq.new()
   self.ftor_spec_seq:add(token)
end
-- add cv spec
function Visitor:add_cv_spec(token)
   self.cv_spec_seq = self.cv_spec_seq or _cv_spec_seq.new()
   self.cv_spec_seq:add(token)
end
-- add builtin spec
function Visitor:add_builtin_spec(token)
   self.builtin_spec_seq = self.builtin_spec_seq or _builtin_spec_seq.new()
   self.builtin_spec_seq:add(token)
end

-- xxxS-decl-spec-seq -> ftor-spec
function Visitor:onSDeclSpecSeq1(node)
   return self:add_ftor_spec(node[1])
end   
-- xxxS-decl-spec-seq -> xxxS-decl-spec-seq ftor-spec
function Visitor:onSDeclSpecSeq2(node)
   node[1]:accept(self)
   return self:add_ftor_spec(node[1])
end   

-- xxVx-decl-spec-seq -> cv-spec
function Visitor:onVDeclSpecSeq1(node)
   self:add_cv_spec(node[1])
end   
-- xxVx-decl-spec-seq -> xxVx-decl-spec-seq cv-spec
function Visitor:onVDeclSpecSeq2(node)
   node[1]:accept(self)
   self:add_cv_spec(node[2])
end   

-- xBxx-decl-spec-seq -> builtin-type
function Visitor:onBDeclSpecSeq1(node)
   self:add_builtin_spec(node[1])
end
-- xBxx-decl-spec-seq -> xBxx-decl-spec-seq builtin-type
function Visitor:onBDeclSpecSeq2 (node)
   node[1]:accept(self)
   self:add_builtin_spec(node[2])
end

-- xUVx-decl-spec-seq -> obj-name
function Visitor:onUDeclSpecSeq1(node)
   self.type = _type.new_user(node[1])
end
-- xUVx-decl-spec-seq -> xxVx-decl-spec-seq obj-name
function Visitor:onUDeclSpecSeq2(node)
   node[1]:accept(self)
   self.type = _type.new_user(node[2])
end

-- visit decl-spec-seq, return table
local function visit_decl_spec_seq(node)
   local decl_spec_seq = {}
   node:accept(setmetatable(decl_spec_seq, Visitor))
   return setmetatable(decl_spec_seq, nil)
end

-- function module
local module = {}

-- visit node and return decl spec
function module.get_decl_spec(node)
   local decl_spec_seq = visit_decl_spec_seq(node)

   local ftor_spec_seq = decl_spec_seq.ftor_spec_seq
   local type = decl_spec_seq.type
   local builtin_spec_seq = decl_spec_seq.builtin_spec_seq
   local cv_spec_seq = decl_spec_seq.cv_spec_seq

   if not type then
      if builtin_spec_seq then
         type = _type.new_builtin(builtin_spec_seq:get_builtin())
      else
         -- must be constructor decl spec seq 
      end
   end
   
   -- if have cv spec seq then must have type
   if cv_spec_seq then
      type.cv = cv_spec_seq:get_cv()
   end

   print(type:to_string())

   -- return table with type and ftor specs
   return {type=type, ftor_spec_seq=ftor_spec_seq}
end

return module
