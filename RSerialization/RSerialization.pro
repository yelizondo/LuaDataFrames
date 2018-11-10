TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += \
        main.c \
    serialize.c \
    arithmetic.c \
    R_ext/arith.c \
    graphapp/arith.c \
    graphapp/array.c \
    graphapp/bitmaps.c \
    graphapp/buttons.c \
    graphapp/clipboard.c \
    graphapp/context.c \
    graphapp/controls.c \
    graphapp/cursors.c \
    graphapp/dialogs.c \
    graphapp/drawing.c \
    graphapp/drawtext.c \
    graphapp/events.c \
    graphapp/fonts.c \
    graphapp/gbuttons.c \
    graphapp/gdraw.c \
    graphapp/gif.c \
    graphapp/gimage.c \
    graphapp/gmenus.c \
    graphapp/image.c \
    graphapp/init.c \
    graphapp/menus.c \
    graphapp/metafile.c \
    graphapp/objects.c \
    graphapp/printer.c \
    graphapp/rgb.c \
    graphapp/status.c \
    graphapp/stdimg.c \
    graphapp/strings.c \
    graphapp/tooltips.c \
    graphapp/windows.c \
    R_ext/arith.c \
    arithmetic.c \
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
    config.h \
    Internal.h \
    R_ext/Itermacros.h \
    arithmetic.h \
    graphapp/ga.h \
    graphapp/graphapp.h \
    graphapp/stdimg.h \
    graphapp/str.h \
    R_ext/Arith.h \
    R_ext/Boolean.h \
    R_ext/Complex.h \
    R_ext/Connections.h \
    R_ext/Error.h \
    R_ext/Itermacros.h \
    R_ext/libextern.h \
    R_ext/Memory.h \
    R_ext/Print.h \
    R_ext/Rdynload.h \
    R_ext/Riconv.h \
    R_ext/RS.h \
    R_ext/Utils.h \
    rpc/types.h \
    rpc/xdr.h \
    arithmetic.h \
    config.h \
    Defn.h \
    Errormsg.h \
    Fileio.h \
    Internal.h \
    Rconfig.h \
    Rconnections.h \
    Rinlinedfuns.h \
    Rinternals.h \
    Rversion.h \
    graphapp/graphapp.h
