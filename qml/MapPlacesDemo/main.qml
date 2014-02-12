import QtQuick 1.1

Image{
    id: myApp
    width: 360
    height: 640
    source: "images/background.png"

    property variant listmodel;
    property variant aroundMeMap;
    property int selectedIndex;

    // Update places
    function updatePlacesModel(fetchedModel){
        listmodel = fetchedModel;
    }

    // Update around me map
    function updateAroundMeMap(){
        aroundMeMapView.aroundMeMapImage.source = "-1"
        aroundMeMapView.aroundMeMapImage.source =  "images/AroundMe.png"
    }

    // Update place map
    function updatePoiMap(){
        placeMapView.placeMapImage.source = "-1"
        placeMapView.placeMapImage.source =  "images/PoiMap.png"
    }

    Image{
        id: titleBar
        source: "images/title.png"
    }

    // Switching between screens
    SimpleViewManager{
        id: myViewManager
        width: parent.width
        height: parent.height - titleBar.height
        anchors.top: titleBar.bottom

        // Home screen
        HomeScreen{
            id: homescreen
        }

        // Around me map view
        AroundMeMap{
            id: aroundMeMapView
        }

        // List of places around
        AroundMeList{
            id: aroundMeListView
        }

        // Details view of poi
        PlaceDetail{
            id: detailView
        }

        // Poi map view
        PlaceMap{
            id: placeMapView
        }

        // About view
        About{
            id: aboutView
        }
    }
}
