# Lazy C++

Lazy C++ is C++ without header files. Write code in one file and the Lazy C++ compiler will generate your header and source files.

Just browse the source tree for examples. The Lazy C++ compiler is writen in Lazy C++ (and Lua)!

Still some work to do on version 3, but it can build itself. Version 2 is available at <http://www.lazycplusplus.com>. You'll need version 2 to bootstrap version 3.

Version 3 is designed to be extensible--it acheives this in two ways:

1. The compiler, lzz, has a built-in parser generator. You'll use lzz to build the Lazy C++ parser. The parser FSM (Finite State Machine) is loaded at runtime.

2. Semantic actions are coded in Lua. 

So language support is now a scripting exercise :) The compiler (the C++ portion) is composed of the following parts:

1. C++ preprocessor
2. Parser generator
3. Parser runtime
4. Configuration manager
5. Low level output handler
6. Lua interpreter

The parser generator produces a backtracking LR parser FSM.

Bottom up parsers are very nice as they reduce to a series of tables that can be loaded at runtime. Coupled with a scripting langage, the semantics too can be interpreted at runtime. Lua is very well suited for this task. Check under lzzscripts/lzz to see the code.

Lzz is a bit tricky to build. Here's what you need to do (on Linux):

1. Download and install Lua (just as described in the Lua readme document). Lzz builds with the lastest version (5.3).

2. Open up the top level makefile (in this directory) and set the LZZ variable. Use Lzz version 2.8.2 to bootstrap.

3. Type 'make BUILD=OPT'.

4. Install lzz3. Just copy the binary (under build.gcc/bin) to some directory in your PATH, *and* set the LZZSCRIPTS environment variable to the full path to the lzzscripts directory, which you should also copy if you're going to be making tweaks to the Lua code.

5. Bootstrap the grammar parser: 'lzz3 -z'. This will generate the files basil.fsm, basil_nodes.lua and basil_states.txt in your lzzscripts directory. basil_states.txt is a human readable dump of the FSM (for your reading pleasure only). For kicks you can use the parser you just generated to build itself using 'lzz3 -y' (this will be build the parser from the rule grammar in basil_rules.txt).

6. Generate the Lazy C++ parser: 'lzz3 -g'. The command reads the Lazy C++ grammar in lzz_rules.txt and generates the files lzz.fsm, lzz_nodes.lua and lzz_states.txt. Again, lzz_states.txt is for you only. If extending the grammar you'll find this file very helpful, specially if you introduce conflicts (conflicts in the grammar simply introduce a backtracking point, but you do need to specify the order in which the actions are attempted if the conflict is intentional).

7. In the makefile point LZZ to your installed lzz3 binary.
