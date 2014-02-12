#include "GPSRequestor.h"

#include <QGeoCoordinate>

GPSRequestor::GPSRequestor()
{
    startGPS();
}

void GPSRequestor::startGPS()
{
    // Obtain the location data source if it is not obtained already
    if (!locationDataSource)
    {
        locationDataSource =
                QGeoPositionInfoSource::createDefaultSource(this);
        // Whenever the location data source signals that the current
        // position is updated, the positionUpdated function is called
        connect(locationDataSource, SIGNAL(positionUpdated(QGeoPositionInfo)),
                this, SLOT(positionUpdated(QGeoPositionInfo)));

        // Start listening for position updates
        locationDataSource->startUpdates();
    }
}

void GPSRequestor::positionUpdated(QGeoPositionInfo geoPositionInfo)
{
    if (geoPositionInfo.isValid())
    {
        // We've got the position. No need to continue the listening.
        locationDataSource->stopUpdates();

        // Save the position information into a member variable
        myPositionInfo = geoPositionInfo;

        // Get the current location as latitude and longitude
        QGeoCoordinate geoCoordinate = geoPositionInfo.coordinate();
        qreal latitude = geoCoordinate.latitude();
        qreal longitude = geoCoordinate.longitude();        
        updateLatLong(QString("%1").arg(latitude),QString("%1").arg(longitude));
    }
}
