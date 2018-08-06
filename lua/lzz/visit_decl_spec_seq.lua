-- lzz.decl_spec_seq_visitor
--

local _cv_spec_seq = require('lzz.cv_spec_seq')
local _builtin_spec_seq = require('lzz.builtin_spec_seq')
local _builtin_type = require('lzz.builtin_type')

-- node visitor
local Visitor = {}
Visitor.__index = Visitor

-- xxVx-decl-spec-seq -> cv-spec
function Visitor:onVDeclSpecSeq1(node)
   self.cv_spec_seq:add(node[1])
end   
-- xxVx-decl-spec-seq -> xxVx-decl-spec-seq cv-spec
function Visitor:onVDeclSpecSeq2(node)
   node[1]:accept(self)
   self.cv_spec_seq:add(node[2])
end   

-- xBxx-decl-spec-seq -> builtin-type
function Visitor:onBDeclSpecSeq1(node)
   self.builtin_spec_seq:add(node[1])
end
-- xBxx-decl-spec-seq -> xBxx-decl-spec-seq builtin-type
function Visitor:onBDeclSpecSeq2 (node)
   node[1]:accept(self)
   self.builtin_spec_seq:add(node[2])
end

-- visit decl-spec-seq
local function visit_decl_spec_seq(node)
   local decl_spec_seq =
   {
      cv_spec_seq = _cv_spec_seq.new(),
      builtin_spec_seq = _builtin_spec_seq.new(),
   }
   node:accept(setmetatable(decl_spec_seq, Visitor))
   return setmetatable(decl_spec_seq, nil)
end

local module = {}

-- visit node and return decl spec
function module.get_decl_spec(node)
   local decl_spec_seq = visit_decl_spec_seq(node)
   local type
   local builtin = decl_spec_seq.builtin_spec_seq:get_builtin()
   if builtin then
      type = _builtin_type.new({builtin=builtin})
   else
      type = decl_spec_seq.type
   end
   if type then
      type.cv = decl_spec_seq.cv_spec_seq:get_cv()
   end
   print(type:to_string())
end

return module
