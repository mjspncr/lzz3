# Lazy C++

Lazy C++ is C++ without header files. You just code definitions, and the Lazy C++ compiler will generate your header and source files.

Lazy C++ is developed in Lazy C++, so just browse the source tree for examples.

Still some work to do on version 3 of the compiler, but at least it can build itself. Version 2 is available at <http://www.lazycplusplus.com>. You'll need use version 2 to bootstrap version 3.

Version 3 is a very different beast. Version 3 is designed to be extensible. It acheives this in two ways:

1. The compiler (lzz) includes a parser generator. In fact, you need lzz to build the Lazy C++ parser! (actually you need lzz to build the parser to build parser to parse Lazy C++ :)

2. Semantic actions are coded in Lua. 

The Lazy C++ semantics are *not* hardcoded. The semantics are coded in Lua. The compiler contains only the following:

1. C++ preprocessor
2. Parser generator
3. Parser runtime
4. Configuration manager
5. Low level output handler

And of course the Lua interpreter. The parser generator produces a backtracking LR parser FSM (Finite State Machine). The FSM is interpreted by the parser runtime module.

Yes, bottom up parsers are very cool as they reduce to a series of tables, and tables can be be loaded at runtime. Coupled with a scripting langage the semantics too can be interpreted at runtime!  Amazing.  Version 3 is a bit slower, but in the last 15 years (lzz was first introduced in 2001) machines have gotten a lot faster!

As you might imagine, lzz is a bit tricky to build. Here's what you need to do (on Linux):

1. Download and install Lua (just as described in the Lua readme document). Lzz builds with the lastest version (5.3). Note you must install it as the Lzz makefile simply does '-llua'.

2. Open up the top level makefile (in this directory) and set the LZZ variable. Use Lzz version 2.8.2 to bootstrap.

3. Type 'make BUILD=OPT'.

4. Install lzz3. This part is easy: just copy the binary (under build.gcc/bin) to some directory in your PATH, *and* set the LZZSCRIPTS environment variable to the full path to the lzzscripts directory, which you should also copy if you're going to be making tweaks to the Lua code. Put the copy commands in a script to make it easier.

5. Bootstrap the grammar parser: 'lzz3 -z'. This will create the files basil.fsm, basil_nodes.lua and basil_states.txt in your lzzscripts directory. basil_states.txt is a human readable dump of the FSM (for your reading pleasure only).  Next, for kicks, you can do the same using the grammar for the grammar: 'lzz3 -y'.

6. Generate the Lazy C++ parser: 'lzz3 -g'. This will create the files lzz.fsm, lzz_nodes.lua and lzz_states.txt in your lzzscripts directory.  Again, lzz_states.txt is for you only.  If extending the grammar you'll find this file very helpful, specially if you introduce conflicts (conflicts in the grammar simply introduce a backtracking point, but you do need to specify the order in which the actions are attempted if the conflict is intentional).

7. In the makefile point LZZ to your installed lzz3 binary.

If you made it feel free to add some missing C++ features (by extending the lzz grammar and Lua scripts only). For example, a namespace alias would be something simple to start with.
