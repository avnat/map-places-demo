#include "MapPlacesRequestor.h"

QString MAP_WIDTH="360";
QString MAP_HEIGHT="430";
int MAP_ZOOM= 14;

QString RADIUS="500";
QString FORMAT = "xml";
QString SENSOR = "false";
QString GOOGLE_API_KEY = "YOUR KEY HERE";
QString AROUNDMEPATH = "qml/MapPlacesDemo/images/AroundMe.png";
QString PLACEPATH ="qml/MapPlacesDemo/images/PoiMap.png";

MapPlacesRequestor::MapPlacesRequestor(QObject *parent) :
    QObject(parent)
{
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);

    // Exposing Logic class to QML
    ctxt = viewer.rootContext();
    ctxt->setContextProperty("MapPlacesRequestor", this);

    // Setting QML source file
    viewer.setMainQmlFile(QLatin1String("qml/MapPlacesDemo/main.qml"));

    rootObject = dynamic_cast<QObject*>(viewer.rootObject());
    connect(this, SIGNAL(PlacesResponse(QVariant)), rootObject, SLOT(updatePlacesModel(QVariant)));
    connect(this, SIGNAL(MapResponse_AroundMe()), rootObject, SLOT(updateAroundMeMap()));
    connect(this, SIGNAL(MapResponse_Poi()), rootObject, SLOT(updatePoiMap()));

    QNetworkProxyFactory::setUseSystemConfiguration(true);
    nam = new QNetworkAccessManager(this);

    connect(nam,SIGNAL(finished(QNetworkReply*)),this,SLOT(finished(QNetworkReply*)));
    iAroundMeMapReq = false;

    // Conecting signal from Qt to QML
    viewer.showExpanded();

    iGPSRequestor = new GPSRequestor();
    connect(iGPSRequestor, SIGNAL(updateLatLong(QString,QString)), this, SLOT(updateLatLong(QString,QString)));
}

void MapPlacesRequestor::finished(QNetworkReply *reply)
{
    if (iAroundMeMapReq || iPoiMapReq)
    {
        // Map received
        if (reply->error() == QNetworkReply::NoError)
        {
            // read data from QNetworkReply here
            //Creating QImage from the reply
            QImageReader imageReader(reply);
            mapImage = imageReader.read();

            if (iAroundMeMapReq)
            {
                mapImage.save(AROUNDMEPATH);
                MapResponse_AroundMe();
            }
            else if (iPoiMapReq)
            {
                mapImage.save(PLACEPATH);
                MapResponse_Poi();
            }

        }
    }
    else
    {
        // XML response received
        parseResponse( reply->readAll());
        PlacesResponse(getPlacesNameList());
        MapRequest();
    }
}

void MapPlacesRequestor::GetPlaces(QString lat, QString lng)
{
    iAroundMeMapReq = false;
    iPoiMapReq = false;
    QString url = "https://maps.googleapis.com/maps/api/place/search/"
            +FORMAT+"?location="
            +lat+","
            +lng+"&radius="
            +RADIUS+
            "&sensor="+
            SENSOR+
            "&key="
            +GOOGLE_API_KEY;
    nam->get(QNetworkRequest(QUrl(url)));
    iAroundMeMapReq = false;
}

int MapPlacesRequestor::parseResponse(QString PlacesData)
{
    iPlacesList.clear();
    QDomDocument doc;

    if( !doc.setContent(PlacesData))
    {
        return -2;
    };

    QDomElement root = doc.documentElement();

    QDomNode n = root.firstChild();

    while( !n.isNull() )
    {
        QDomElement e = n.toElement();

        if (e.tagName()=="result")
        {
            QString pname, pvicinity, plat, plng, ptype;
            QDomNode result_n = e.firstChild();

            while(!result_n.isNull())
            {
                QDomElement result_e = result_n.toElement();

                if (result_e.tagName() == "name")
                {
                    pname = result_e.text();
                }
                else if (result_e.tagName() == "vicinity")
                {
                    pvicinity = result_e.text();
                }
                else if (result_e.tagName() == "type")
                {
                    if (ptype.length()==0)
                    {
                        ptype= result_e.text();
                    }

                }
                else if( result_e.tagName() == "geometry")
                {
                    QDomNode geometry_n = result_e.firstChild();

                    QDomElement geometry_e = geometry_n.toElement();

                    if(geometry_e.tagName() == "location")
                    {
                        QDomNode location_n = geometry_n.firstChild();

                        while(!location_n.isNull())
                        {
                            QDomElement location_e = location_n.toElement();

                            if(location_e.tagName()== "lat")
                            {
                                plat = location_e.text();
                            }

                            if(location_e.tagName()== "lng")
                            {
                                plng = location_e.text();
                            }

                            location_n = location_n.nextSibling();
                        }
                    }
                }

                result_n = result_n.nextSibling();
            }

            iPlacesList.append(new Places(pname, pvicinity,ptype, plat, plng));
        }

        n = n.nextSibling();
    }
    return 0;
}


QStringList MapPlacesRequestor::getPlacesNameList(){
    QStringList list;
    for (int i =0; i<iPlacesList.count(); i++)
    {
        list.append(iPlacesList.at(i)->name);
    }
    return list;
}

QString MapPlacesRequestor::getPlacesVicinity(int index){

    if (index<iPlacesList.count()){
        return iPlacesList.at(index)->vicinity;
    }
    return "-1";
}

QString MapPlacesRequestor::getPlacesTitle(int index)
{
    if (index<iPlacesList.count()){
        return iPlacesList.at(index)->name;
    }
    return "-1";
}

QString MapPlacesRequestor::getIcon(int index){

    if (index<iPlacesList.count()){

         if (iPlacesList.at(index)->type == "lodging"
                 || iPlacesList.at(index)->type == "establishment"
                 || iPlacesList.at(index)->type == "airport"
                 || iPlacesList.at(index)->type == "bar"
                 || iPlacesList.at(index)->type == "doctor"
                 || iPlacesList.at(index)->type == "zoo"
                 || iPlacesList.at(index)->type == "school"
                 || iPlacesList.at(index)->type == "restaurant"
                 || iPlacesList.at(index)->type == "university"
                 || iPlacesList.at(index)->type == "cafe")
        {
             return QString("images/" + iPlacesList.at(index)->type + ".png");
         }
        else
        {
             return "images/poi.png";
        }
    }
    return "-1";
}


void MapPlacesRequestor::getPlacesImage()
{
    QString url("http://m.nokia.me/?poi=");
    for (int i =0; i<iPlacesList.count(); i++)
    {
        if (i==6)
        {
            break;
        }
        url.append(iPlacesList.at(i)->lat);
        url.append(",");
        url.append(iPlacesList.at(i)->lng);
        url.append(",");
    }
    url.append("&h="
               + MAP_HEIGHT + ",&w="
               + MAP_WIDTH + "&nopoim");
    nam->get(QNetworkRequest(QUrl(url)));
    iAroundMeMapReq = true;
    iPoiMapReq = false;
}

void MapPlacesRequestor::MapRequest()
{
    getPlacesImage();
}

void MapPlacesRequestor::PlacesRequest()
{
    GetPlaces(iLat, iLng);
}


void MapPlacesRequestor::getPoiMap(int index)
{
    index_cache = index;
    QString lat = iPlacesList.at(index)->lat;
    QString lng = iPlacesList.at(index)->lng;

    QString url = "http://m.nokia.me/?c="
            +lat+","
            +lng+",&h="
            + MAP_HEIGHT + ",&w="
            + MAP_WIDTH + "&z="
            + QString::number(MAP_ZOOM) + "&nord";

    nam->get(QNetworkRequest(QUrl(url)));
    iAroundMeMapReq = false;
    iPoiMapReq= true;
}


void MapPlacesRequestor::zoomIn()
{
    if(MAP_ZOOM!=16)
    {
        MAP_ZOOM++;
        getPoiMap(index_cache);
    }
}

void MapPlacesRequestor::zoomOut()
{
    if(MAP_ZOOM!=8)
    {
        MAP_ZOOM--;
        getPoiMap(index_cache);
    }

}
void MapPlacesRequestor::updateLatLong(QString lat,QString lng)
{
    iLat = lat;
    iLng = lng;
}
