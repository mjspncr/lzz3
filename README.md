# Lzz, The Lazy C++ Compiler

Lazy C++ is C++ without header files. Write code in one file and let Lzz generate your header and source files.

Just browse the source tree for examples. Lzz is writen in Lazy C++ (and Lua)!

This is Lzz version 3. It is still a work progress, though it can compile itself. The latest stable version is 2.8.2 and is available at http://www.lazycplusplus.com. You will need version 2.8.2 to bootstrap version 3.

Version 3 is extensible. The parser finite state machine (FSM) and semantic actions are not hardcoded. Instead the FSM is loaded at runtime, and semantic actions are coded in Lua. New language constructs can be added without recompiling Lzz!

The FSM is generated using BasilCC (mjspncr/basilcc). Since the parser runtime library is required to build Lzz you must build BasilCC first.

Follow these steps to get Lzz up and running:

1. Download and build BasilCC. Note this step will require Lua 5.3. You'll also need Lzz 2.8.2 to bootstrap the build.

2. Edit the makefile in this directory. Set LZZ to the Lzz 2.8.2 executable, and set BASILCC_ROOT to your BasilCC directory.

3. Build lzz3: make BUILD=OPT. The binary will be created in build.gcc/bin.

4. Generate the parser FSM (and Lua node definitions) from the Lazy C++ grammar: basilcc lzzscripts/lzz_rules.txt.

5. Set the environment variable LZZSCRIPTS to the full path of the lzzscripts directory. 

To compile Lzz with binary you just built, in the makefile set LZZ to the binary and type 'make clean; make BUILD=OPT'.
