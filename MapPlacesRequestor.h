#ifndef MAPPLACESREQUESTOR_H
#define MAPPLACESREQUESTOR_H

#include <QObject>

#include <QNetworkProxyFactory>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QDomDocument>
#include <QDomElement>
#include <QImageReader>
#include <QImage>
#include <QtGui>

#include <QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "GPSRequestor.h"

class Places{
public:
    Places(QString aname, QString avicinity, QString atype, QString alat, QString alng)
    {
        name = aname;
        vicinity = avicinity;
        lat = alat;
        lng = alng;
        type = atype;
    }
    QString name, vicinity, type;
    QString lat, lng;
};

class MapPlacesRequestor : public QObject
{
    Q_OBJECT
public:
    MapPlacesRequestor(QObject *parent = 0);

    Q_INVOKABLE void MapRequest();
    Q_INVOKABLE void PlacesRequest();
    Q_INVOKABLE QStringList getPlacesNameList();
    Q_INVOKABLE void zoomIn();
    Q_INVOKABLE void zoomOut();
    Q_INVOKABLE  void getPoiMap(int index);
    Q_INVOKABLE QString getPlacesTitle(int index);
    Q_INVOKABLE QString getPlacesVicinity(int index);
    Q_INVOKABLE QString getIcon(int index);

private:
    QNetworkAccessManager *nam;
    QList<Places *> iPlacesList;
    bool iAroundMeMapReq;
    bool iPoiMapReq;

signals:
    void PlacesResponse(QVariant);
    void MapResponse_AroundMe();
    void MapResponse_Poi();

private slots:
    void finished(QNetworkReply *reply);
    void GetPlaces(QString lat, QString lng);
    int parseResponse(QString PlacesData);
    void getPlacesImage();
    void updateLatLong(QString lat,QString lng);

private:
    QmlApplicationViewer viewer;
    QDeclarativeContext *ctxt;
    QObject *rootObject;
    QImage mapImage;
    int index_cache;

    GPSRequestor* iGPSRequestor;
    QString iLat, iLng;
};

#endif // MAPPLACESREQUESTOR_H
