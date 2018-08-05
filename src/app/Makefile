DIR  := app
BIN  := lzz3
LIBS := cpp lzz config util
# DL defined in make.$CONFIG
MORELIBS = basil$(OPTSUFFIX) lua $(DL)
MORELIBDIRS = $(BASILCC_LIB)
INCDIRS = $(BASILCC_SRC)/basil
LOCALINCDIRS = util config lzz cpp
include $(MAKETOOLS)/make.include
