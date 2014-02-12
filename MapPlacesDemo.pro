QT       += core gui network  xml

# Add more folders to ship with the application, here
folder_01.source = qml/MapPlacesDemo
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

INCLUDEPATH += C:/QtSDKNew/Simulator/QtMobility/mingw/include/QtLocation
#INCLUDEPATH += C:/QtSDKNew/Symbian/SDKs/Symbian3Qt474/include

symbian:TARGET.UID3 = 0xE7EDF820

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices Location

SOURCES += main.cpp \
    MapPlacesRequestor.cpp \
    GPSRequestor.cpp

HEADERS += \
    MapPlacesRequestor.h \
    GPSRequestor.h

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
 CONFIG += mobility
 MOBILITY += location


# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
# CONFIG += qdeclarative-boostable

# Add dependency to Symbian components
# CONFIG += qt-components


# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()
