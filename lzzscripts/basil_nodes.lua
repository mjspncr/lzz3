local nodes = {}

-- rule -> rule-name-opt > symbol ARROW symbol-seq-opt >
local Rule = node ("Rule")
function Rule:getRuleNameOpt ()
   return self [1]
end
function Rule:getSymbol ()
   return self [2]
end
function Rule:getARROW ()
   return self [3]
end
function Rule:getSymbolSeqOpt ()
   return self [4]
end
function Rule:accept (visitor)
   return visitor:onRule (self)
end
nodes.Rule = Rule

-- rule-name -> IDENT EQUALS
local RuleName1 = node ("RuleName1")
function RuleName1:getIDENT ()
   return self [1]
end
function RuleName1:getEQUALS ()
   return self [2]
end
function RuleName1:accept (visitor)
   return visitor:onRuleName1 (self)
end
nodes.RuleName1 = RuleName1

-- rule-name -> IDENT COLON
local RuleName2 = node ("RuleName2")
function RuleName2:getIDENT ()
   return self [1]
end
function RuleName2:getCOLON ()
   return self [2]
end
function RuleName2:accept (visitor)
   return visitor:onRuleName2 (self)
end
nodes.RuleName2 = RuleName2

-- symbol-seq -> symbol
local SymbolSeq1 = node ("SymbolSeq1")
function SymbolSeq1:getSymbol ()
   return self [1]
end
function SymbolSeq1:accept (visitor)
   return visitor:onSymbolSeq1 (self)
end
nodes.SymbolSeq1 = SymbolSeq1

-- symbol-seq -> symbol-seq symbol
local SymbolSeq2 = node ("SymbolSeq2")
function SymbolSeq2:getSymbolSeq ()
   return self [1]
end
function SymbolSeq2:getSymbol ()
   return self [2]
end
function SymbolSeq2:accept (visitor)
   return visitor:onSymbolSeq2 (self)
end
nodes.SymbolSeq2 = SymbolSeq2

-- symbol <* -> IDENT attrib-seq
local Symbol = node ("Symbol")
function Symbol:getIDENT ()
   return self [1]
end
function Symbol:getAttribSeq ()
   return self [2]
end
function Symbol:accept (visitor)
   return visitor:onSymbol (self)
end
nodes.Symbol = Symbol

-- attrib-seq ->
local AttribSeq1 = node ("AttribSeq1")
function AttribSeq1:accept (visitor)
   return visitor:onAttribSeq1 (self)
end
nodes.AttribSeq1 = AttribSeq1

-- attrib-seq -> attrib-seq NUMBER
local AttribSeq2 = node ("AttribSeq2")
function AttribSeq2:getAttribSeq ()
   return self [1]
end
function AttribSeq2:getNUMBER ()
   return self [2]
end
function AttribSeq2:accept (visitor)
   return visitor:onAttribSeq2 (self)
end
nodes.AttribSeq2 = AttribSeq2

-- attrib-seq -> attrib-seq LT
local AttribSeq3 = node ("AttribSeq3")
function AttribSeq3:getAttribSeq ()
   return self [1]
end
function AttribSeq3:getLT ()
   return self [2]
end
function AttribSeq3:accept (visitor)
   return visitor:onAttribSeq3 (self)
end
nodes.AttribSeq3 = AttribSeq3

-- attrib-seq -> attrib-seq STAR
local AttribSeq4 = node ("AttribSeq4")
function AttribSeq4:getAttribSeq ()
   return self [1]
end
function AttribSeq4:getSTAR ()
   return self [2]
end
function AttribSeq4:accept (visitor)
   return visitor:onAttribSeq4 (self)
end
nodes.AttribSeq4 = AttribSeq4

-- attrib-seq -> attrib-seq PLUS bang-seq-opt
local AttribSeq5 = node ("AttribSeq5")
function AttribSeq5:getAttribSeq ()
   return self [1]
end
function AttribSeq5:getPLUS ()
   return self [2]
end
function AttribSeq5:getBangSeqOpt ()
   return self [3]
end
function AttribSeq5:accept (visitor)
   return visitor:onAttribSeq5 (self)
end
nodes.AttribSeq5 = AttribSeq5

-- attrib-seq -> attrib-seq CARET bang-seq-opt
local AttribSeq6 = node ("AttribSeq6")
function AttribSeq6:getAttribSeq ()
   return self [1]
end
function AttribSeq6:getCARET ()
   return self [2]
end
function AttribSeq6:getBangSeqOpt ()
   return self [3]
end
function AttribSeq6:accept (visitor)
   return visitor:onAttribSeq6 (self)
end
nodes.AttribSeq6 = AttribSeq6

-- attrib-seq -> attrib-seq GT bang-seq-opt
local AttribSeq7 = node ("AttribSeq7")
function AttribSeq7:getAttribSeq ()
   return self [1]
end
function AttribSeq7:getGT ()
   return self [2]
end
function AttribSeq7:getBangSeqOpt ()
   return self [3]
end
function AttribSeq7:accept (visitor)
   return visitor:onAttribSeq7 (self)
end
nodes.AttribSeq7 = AttribSeq7

-- bang-seq -> BANG
local BangSeq1 = node ("BangSeq1")
function BangSeq1:getBANG ()
   return self [1]
end
function BangSeq1:accept (visitor)
   return visitor:onBangSeq1 (self)
end
nodes.BangSeq1 = BangSeq1

-- bang-seq -> bang-seq BANG
local BangSeq2 = node ("BangSeq2")
function BangSeq2:getBangSeq ()
   return self [1]
end
function BangSeq2:getBANG ()
   return self [2]
end
function BangSeq2:accept (visitor)
   return visitor:onBangSeq2 (self)
end
nodes.BangSeq2 = BangSeq2

return nodes
