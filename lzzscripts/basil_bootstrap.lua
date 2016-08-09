-- bootstrap basil parser
--
-- start -> rule-seq-opt
-- rule-seq-opt ->
-- rule-seq-opt -> rule-seq
-- rule-seq -> rule
-- rule-seq -> rule-seq rule
-- rule = rule <* -> rule-name-opt symbol ARROW symbol-seq-opt >
-- rule-name-opt ->
-- rule-name-opt -> rule-name
-- rule_name_1 = rule-name -> IDENT EQUALS
-- rule_name_2 = rule-name -> IDENT COLON
-- symbol-seq-opt ->
-- symbol-seq-opt -> symbol-seq
-- symbol_seq_1 = symbol-seq < -> symbol
-- symbol_seq_2 = symbol-seq < -> symbol-seq symbol
-- symbol = symbol-> IDENT attrib-seq
-- attrib_seq_1 = attrib-seq < -> 
-- attrib_seq_2 = attrib-seq -> attrib-seq NUMBER
-- attrib_seq_3 = attrib-seq -> attrib-seq LT
-- attrib_seq_4 = attrib-seq -> attrib-seq STAR
-- attrib_seq_5 = attrib-seq -> attrib-seq PLUS  bang-seq-opt
-- attrib_seq_6 = attrib-seq -> attrib-seq CARET bang-seq-opt
-- attrib_seq_7 = attrib-seq -> attrib-seq GT    bang-seq-opt
-- bang-seq-opt -> 
-- bang-seq-opt -> bang-seq
-- bang_seq_1 = bang-seq -> BANG
-- bang_seq_2 = bang-seq -> bang-seq BANG

-- start -> rule-seq-opt
addRule(nil, Symbol('start'), {Symbol('rule-seq-opt')})  

-- rule-seq-opt ->
addRule(nil, Symbol('rule-seq-opt'))  
-- rule-seq-opt -> rule-seq
addRule(nil, Symbol('rule-seq-opt'), {Symbol ('rule-seq')})

-- rule-seq -> rule
addRule (nil, Symbol('rule-seq'), {Symbol ('rule')})
-- rule-seq -> rule-seq rule
addRule (nil, Symbol('rule-seq'), {Symbol ('rule-seq'), Symbol ('rule')})

-- rule= rule -> rule-name-opt > symbol ARROW symbol-seq-opt >
addRule (Name('rule', nil, true), Symbol('rule'),
  {Symbol('rule-name-opt', nil, nil, nil, Priority(1)),
   Symbol('symbol'), Symbol('ARROW'), Symbol('symbol-seq-opt', nil, nil, nil, Priority(1))})

-- rule-name-opt ->
addRule (nil, Symbol('rule-name-opt'))
-- rule-name-opt -> rule-name *
addRule (nil, Symbol('rule-name-opt'), {Symbol('rule-name', nil, nil, nil, nil, nil, false, true)})

-- rule_name_1 = rule-name -> IDENT EQUALS
addRule (Name('rule-name-1', nil, true), Symbol('rule-name'), {Symbol('IDENT'), Symbol('EQUALS')})
-- rule_name_2 = rule-name -> IDENT COLON
addRule (Name('rule-name-2', nil, true), Symbol('rule-name'), {Symbol('IDENT'), Symbol('COLON')})

-- symbol-seq-opt ->
addRule (nil, Symbol('symbol-seq-opt'))
-- symbol-seq-opt -> symbol-seq
addRule (nil, Symbol('symbol-seq-opt'), {Symbol('symbol-seq')})

-- symbol_seq_1 = symbol-seq -> symbol
addRule (Name('symbol-seq-1', nil, true), Symbol('symbol-seq'), {Symbol('symbol')})
-- symbol_seq_2 = symbol-seq -> symbol-seq symbol
addRule (Name('symbol-seq-2', nil, true), Symbol('symbol-seq'), {Symbol('symbol-seq'), Symbol ('symbol')})

-- symbol= symbol <* -> IDENT attrib-seq
addRule (Name('symbol', nil, true), Symbol('symbol', nil, nil, nil, nil, nil, true, true),
  {Symbol('IDENT'), Symbol('attrib-seq')})

-- attrib_seq_1 = attrib-seq < ->
addRule (Name('attrib-seq-1', nil, true), Symbol('attrib-seq'))
-- attrib_seq_2 = attrib-seq -> attrib-seq NUMBER
addRule (Name('attrib-seq-2', nil, true), Symbol('attrib-seq'), {Symbol('attrib-seq'), Symbol('NUMBER')})
-- attrib_seq_3 = attrib-seq -> attrib-seq LT
addRule (Name('attrib-seq-3', nil, true), Symbol('attrib-seq'), {Symbol('attrib-seq'), Symbol('LT')})
-- attrib_seq_4 = attrib-seq -> attrib-seq STAR
addRule (Name('attrib-seq-4', nil, true), Symbol('attrib-seq'), {Symbol('attrib-seq'), Symbol('STAR')})
-- attrib_seq_5 = attrib-seq -> attrib-seq PLUS bang-seq-opt
addRule (Name('attrib-seq-5', nil, true), Symbol('attrib-seq'),
         {Symbol('attrib-seq'), Symbol ('PLUS'), Symbol('bang-seq-opt')})
-- attrib_seq_6 = attrib-seq -> attrib-seq CARET bang-seq-opt
addRule (Name('attrib-seq-6', nil, true), Symbol('attrib-seq'),
         {Symbol('attrib-seq'), Symbol('CARET'), Symbol('bang-seq-opt')})
-- attrib_seq_7 = attrib-seq -> attrib-seq GT bang-seq-opt
addRule (Name('attrib-seq-7', nil, true), Symbol('attrib-seq'),
         {Symbol('attrib-seq'), Symbol('GT'), Symbol('bang-seq-opt')})

-- bang-seq-opt ->
addRule (nil, Symbol('bang-seq-opt'))
-- bang-seq-opt -> bang-seq
addRule (nil, Symbol('bang-seq-opt'), {Symbol('bang-seq')})

-- bang_seq_1 = bang-seq -> BANG
addRule (Name('bang-seq-1', nil, true), Symbol('bang-seq'), {Symbol('BANG')})
-- bang_seq_2 = bang-seq -> bang-seq BANG
addRule (Name('bang-seq-2', nil, true), Symbol('bang-seq'), {Symbol('bang-seq'), Symbol('BANG')})
