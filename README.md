# Lazy C++

Lazy C++ is C++ without header files. Write code in one file and Lzz, the Lazy C++ compiler, will generate your header and source files.

Just browse the source tree for examples. Lzz is writen in Lazy C++ (and Lua)!

Version 3 can build itself, though work is still in progress. Version 2 is available at <http://www.lazycplusplus.com>. You'll need version 2 to bootstrap version 3.

The big feature in this version is extensibility. The Lazy C++ grammar and semantic actions are _not_ hardcoded. They can be extended without recompiling Lzz.

Now you need mjspncr/basilcc to build the Lzz parser. And of course you need Lzz to build basilcc :)

Here's how to build Lzz on Linux:

1. Download and install Lua (as described in the Lua readme document). Lzz builds with Lua version 5.3.

2. Open up the makefile in this directory and point LZZ to the Lzz compiler. Use Lzz version 2.8.2 to bootstrap.

3. Type 'make BUILD=OPT'.

4. Compile the Lzz grammar: basilcc lzzscripts/lzz_rules.txt. This will generate the parser FSM and a file with Lua node definitions.

5. If you'd like to compile Lzz with binary you just built, in the makefile point LZZ to your lzz3 binary and type 'make clean; make BUILD=OPT'.
