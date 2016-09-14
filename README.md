# Lazy C++

Lazy C++ is C++ without header files. Write code in one file and the Lazy C++ compiler, Lzz, will generate your header and source files.

Just browse the source tree for examples. Lzz is writen in Lazy C++ (and Lua)!

Still some work to do on version 3, but it can build itself. Version 2 is available at <http://www.lazycplusplus.com>. You'll need version 2 to bootstrap version 3.

The big plus in version 3 is extensibility. The Lazy C++ grammar and semantic actions are _not_ hardcoded. They can be extended without recompiling Lzz.

Lzz includes a parser generator that produces a backtracking LR parser Finite State Machine (FSM). It's loaded at runtime. Semantic actions are coded in Lua.

Lzz takes some work to build. Here's what you need to do (on Linux):

1. Download _and_ install Lua (as described in the Lua readme document). Lzz builds with the lastest Lua version, 5.3.

2. Open up the makefile in this directory and point LZZ to the Lzz compiler. Use Lzz version 2.8.2 to bootstrap.

3. Type 'make BUILD=OPT'.

4. Install lzz3. Copy the binary (under build.gcc/bin) to some directory in your PATH, and set the LZZSCRIPTS environment variable to the full path to your lzzscripts directory, which you may also want to copy.

5. Bootstrap the grammar parser: 'lzz3 -z'. This will generate the files basil.fsm, basil_nodes.lua and basil_states.txt in your lzzscripts directory. basil_states.txt is a human readable dump of the FSM. For kicks you can use the parser you just generated to compile itself using 'lzz3 -y' (this will build the parser from the rule grammar in basil_rules.txt).

6. Compile the Lazy C++ parser: 'lzz3 -g'. This will generate the files lzz.fsm, lzz_nodes.lua and lzz_states.txt from the Lazy C++ grammar in lzz_rules.txt. You'll find lzz_states.txt very helpful if you ever introduce conflicts. Conflicts in the grammar simply introduce a backtracking point, but you must order the shift/reduce actions if the conflict is intentional (more on this in a later document).

7. Good to go. If you'd like to compile Lzz with binary you just built, in the makefile point LZZ to your installed lzz3 binary and type 'make clean; make BUILD=OPT'.
