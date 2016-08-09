-----------------------------------------------------------------------------
-- parameter declarations
-----------------------------------------------------------------------------
local append              = require 'util/append'
local getFuncParam        = require 'lzz/param/get_func_param'
local getTmplParam        = require 'lzz/param/get_tmpl_param'
local getTypeParam        = require 'lzz/param/get_type_param'
local nodes               = require 'lzz_nodes'
-----------------------------------------------------------------------------

--
-- get params
--

local GetParams = {}

-- param-decl-1-list <* -> LPAREN param-init-decl
function GetParams:onParamDeclList1 (node)
   return {node:getParamInitDecl ()}
end
-- param-decl-1-list -> param-decl-1-list COMMA param-init-decl
function GetParams:onParamDeclList2 (node)
   return append (node:getParamDecl1List ():accept (self), node:getParamInitDecl ())
end

-- tmpl-param-list -> tmpl-param
function GetParams:onTmplParamList1 (node)
   return {node:getTmplParam ()}
end
-- tmpl-param-list -> tmpl-param-list COMMA tmpl-param
function GetParams:onTmplParamList2 (node)
   return append (node:getTmplParamList ():accept (self), node:getTmplParam ())
end

local function getParams (node)
   return node:accept (GetParams)
end

--
-- param init decl
--

-- param-init-decl <* -> param-decl
function nodes.ParamDecl1:onNode ()
   local dcl = self[1][2]
   return getFuncParam (dcl)
end

-- param-init-decl <* -> param-decl ASSIGN block 4
function nodes.ParamDecl2:onNode ()
   local dcl = self[1][2]
   dcl.default = self[3].lexeme
   return getFuncParam (dcl)
end

--
-- param decl body
--

-- helper func
local function onParamDeclBody (params, has_ellipse)
   params.has_ellipse = has_ellipse
   return params
end

-- param-decl-1-body -> param-decl-1-list ellipse-opt
function nodes.ParamDeclBody1:onNode ()
   return onParamDeclBody (getParams (self:getParamDecl1List ()), self:getEllipseOpt () ~= nil)
end

-- param-decl-1-body -> param-decl-1-list COMMA ELLIPSE
function nodes.ParamDeclBody2:onNode ()
   return onParamDeclBody (getParams (self:getParamDecl1List ()), true)
end

-- param-decl-1-body -> LPAREN ellipse-opt
function nodes.ParamDeclBody3:onNode ()
   return onParamDeclBody ({}, self:getEllipseOpt () ~= nil)
end

-- param-decl-1-body -> LPAREN VOID
function nodes.ParamDeclBody4:onNode ()
   return onParamDeclBody ({}, false)
end

--
-- template params
--

-- tmpl-params -> tmpl-param-list-opt
function nodes.TmplParams:onNode ()
   local param_list = self:getTmplParamListOpt ()
   if param_list then
      return getParams (param_list)
   else
      return {}
   end
end

-- type-param <* -> type-key + obj-name
function nodes.TypeParam1:onNode ()
   return getTypeParam {name=self:getObjName ()}
end

-- type-param <* -> type-key + obj-name ASSIGN abstract-decl
function nodes.TypeParam2:onNode ()
   return getTypeParam {name=self[2], default=self[4][2].tp}
end

-- tmpl-tmpl-param <* -> TEMPLATE LT tmpl-params GT CLASS obj-name
function nodes.TmplTmplParam1:onNode ()
   return getTmplParam {params=self[3], name=self[6]}
end

-- tmpl-tmpl-param <* -> TEMPLATE LT tmpl-params GT CLASS obj-name ASSIGN obj-name
function nodes.TmplTmplParam2:onNode ()
   return getTmplParam {params=self[3], name=self[6], default=self[8]}
end
