require 'util/class'
local nodes = require 'basil_nodes'

-- rule-name -> IDENT EQUALS
function nodes.RuleName1:onNode ()
   local IDENT = self:getIDENT ()
   return Name (IDENT.lexeme, IDENT.loc, true)
end

-- rule-name -> IDENT COLON
function nodes.RuleName2:onNode ()
   local IDENT = self:getIDENT ()
   return Name (IDENT.lexeme, IDENT.loc, false)
end

-- attrib-seq < ->
function nodes.AttribSeq1:onNode ()
   return {}
end

-- attrib-seq -> attrib-seq NUMBER
function nodes.AttribSeq2:onNode ()
   local attrib_seq = self:getAttribSeq ()
   attrib_seq.lex_state = tonumber (self:getNUMBER ().lexeme)
   return attrib_seq
end

-- attrib-seq -> attrib-seq LT
function nodes.AttribSeq3:onNode ()
   local attrib_seq = self:getAttribSeq ()
   attrib_seq.sticky = true
   return attrib_seq
end

-- attrib-seq -> attrib-seq STAR
function nodes.AttribSeq4:onNode ()
   local attrib_seq = self:getAttribSeq ()
   attrib_seq.accept = true
   return attrib_seq
end

-- attrib-seq -> attrib-seq PLUS  bang-seq-opt
function nodes.AttribSeq5:onNode ()
   local attrib_seq = self:getAttribSeq ()
   attrib_seq.r_priority = attrib_seq.r_priority + Priority (1, self:getBangSeqOpt ())
   return attrib_seq
end

-- attrib-seq -> attrib-seq CARET bang-seq-opt
function nodes.AttribSeq6:onNode ()
   local attrib_seq = self:getAttribSeq ()
   attrib_seq.f_priority = attrib_seq.f_priority + Priority (1, self:getBangSeqOpt ())
   return attrib_seq
end

-- attrib-seq -> attrib-seq GT    bang-seq-opt
function nodes.AttribSeq7:onNode ()
   local attrib_seq = self:getAttribSeq ()
   attrib_seq.s_priority = attrib_seq.s_priority + Priority (1, self:getBangSeqOpt ())
   return attrib_seq
end

-- symbol -> IDENT attrib-seq
function nodes.Symbol:onNode ()
   local attrib_seq = self:getAttribSeq ()
   local IDENT = self:getIDENT ()
   return Symbol (IDENT.lexeme, IDENT.loc, attrib_seq.r_priority, attrib_seq.f_priority, attrib_seq.s_priority,
     attrib_seq.lex_state, attrib_seq.sticky, attrib_seq.accept)
end

-- rule <* -> rule-name-opt symbol ARROW symbol-seq-opt >
function nodes.Rule:onNode ()
   local right_rule_symbols = getSymbolsOpt (self:getSymbolSeqOpt ())
   addRule (self:getRuleNameOpt (), self:getSymbol (), right_rule_symbols)
end

-- bang-seq -> BANG
function nodes.BangSeq1:onNode ()
   return 1
end

-- bang-seq -> bang-seq BANG
function nodes.BangSeq2:onNode ()
   return self:getBangSeq () + 1
end

-- get symbols visitor
local GetSymbols = class ()

-- symbol-seq < -> symbol
function GetSymbols:onSymbolSeq1 (node)
   table.insert (self, node:getSymbol ())
end
-- symbol-seq < -> symbol-seq symbol
function GetSymbols:onSymbolSeq2 (node)
   node:getSymbolSeq ():accept (self)
   table.insert (self, node:getSymbol ())
end

-- get symbols opt symbol seq
function getSymbolsOpt (symbol_seq_opt)
   local symbols = GetSymbols ()
   if symbol_seq_opt then
      symbol_seq_opt:accept (symbols)
   end
   return symbols
end
