# Lazy C++

Lazy C++ is C++ without header files. Write code in one file and Lzz, the Lazy C++ compiler, will generate your header and source files.

Just browse the source tree for examples. Lzz is writen in Lazy C++ (and Lua)!

This is Lzz version 3. It is still a work progress, though it can compile itself. The latest stable version is 2.8.2 and is available at http://www.lazycplusplus.com. You will need version 2.8.2 to bootstrap version 3.

Version 3 is extensible. The parser finite state machine (FSM) and semantic actions are not hardcoded. Instead the FSM is loaded at runtime, and semantic actions are coded in Lua. New language constructs can be added without recompiling Lzz!

The parser FSM is generated using BasilCC. Since the parser runtime library, also in BasilCC, is required to build Lzz you must build BasilCC first. BasilCC is at mjspncr/basilcc.

Follow these steps to get Lzz up and running:

1. Download and build BasilCC. Note this step will require Lua 5.3. You'll also need Lzz 2.8.2 to bootstrap the build.

2. Edit the makefile in this directory. Set LZZ to the Lzz 2.8.2 executable, and BASILCC_ROOT to your BasilCC directory.

3. Build the lzz3 executable: make BUILD=OPT. The binary will be created in build.gcc/bin.

4. Generate the parser FSM from the Lazy C++ grammar: basilcc lzzscripts/lzz_rules.txt. The parser FSM and a file with Lua node definitions will be created in the same directory. You'll also see a file named lzz_states.txt; this is just dump of all states, very helpful when debugging parsing conflicts.

5. Set the environment variable LZZSCRIPTS to the absolute path of the lzzscripts directory. 

If you'd like to compile Lzz with binary you just built, in the makefile set LZZ to the binary and type 'make clean; make BUILD=OPT'.
