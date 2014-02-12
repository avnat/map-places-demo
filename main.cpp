#include <QtGui/QApplication>
#include "MapPlacesRequestor.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    MapPlacesRequestor myMapPlaces;
    return app.exec();
}
