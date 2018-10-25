TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += \
        main.c \
    serialize.c

HEADERS += \
    Fileio.h \
    Defn.h \
    Rversion.h \
    Rinternals.h \
    Rconfig.h \
    Errormsg.h \
    R_ext/RS.h \
    R_ext/Riconv.h \
    R_ext/Error.h \
    R_ext/Complex.h \
    R_ext/Arith.h \
    R_ext/libextern.h \
    R_ext/Boolean.h \
    R_ext/Memory.h \
    R_ext/Utils.h \
    R_ext/Print.h \
    R_ext/Rdynload.h \
    Rinlinedfuns.h \
    rpc/types.h \
    rpc/xdr.h \
    Rconnections.h \
    R_ext/Connections.h \
    config.h
