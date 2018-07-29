## to build must have these vars set (to build from any src dir set these vars in your env)

# this directory
export ROOT ?= $(PWD)
# maketools directory, make.include is in here
export MAKETOOLS ?= $(ROOT)/maketools
# target build, must have make.$CONFIG in maketools, gcc or i386-mingw32
export CONFIG ?= gcc
# need lzz to build lzz
export LZZ ?= lzz

# basilcc lib and src directories
BASILCC_ROOT ?= /usr/local/release/basilcc/x100
export BASILCC_LIB ?= $(BASILCC_ROOT)/build.gcc/lib
export BASILCC_SRC ?= $(BASILCC_ROOT)/build.gcc/src

SUBDIRS=src
include $(MAKETOOLS)/make.include
