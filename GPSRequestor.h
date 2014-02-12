#ifndef GPSREQUESTOR_H
#define GPSREQUESTOR_H

#include <QGeoPositionInfo>
#include <QGeoPositionInfoSource>
#include <QDebug>
#include <QPointer>

// QtMobility namespace
QTM_USE_NAMESPACE

class GPSRequestor : public QObject
{
    Q_OBJECT

    public:
        GPSRequestor();
    public slots:
    /**
     * Called when the current position is updated.
     */
    void positionUpdated(QGeoPositionInfo geoPositionInfo);

    signals:
    void updateLatLong(QString lat, QString lng);

    private:
    /**
     * Obtains the location data source and starts listening for position
     * changes.
     */
    void startGPS();

    private:
    QPointer<QGeoPositionInfoSource> locationDataSource;
    QGeoPositionInfo myPositionInfo;
};
#endif // GPSREQUESTOR_H
