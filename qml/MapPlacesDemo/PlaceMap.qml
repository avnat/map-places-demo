import QtQuick 1.1

Rectangle{
    width: parent.width
    height: parent.height
    color: "transparent"

    property alias placeMapImage:placeMap

    Rectangle{
        id: infoText_placeMapView
        width: parent.width
        height: 30
        anchors.top: parent.top
        color: "lightblue"
        Text {
            text: MapPlacesRequestor.getPlacesTitle(selectedIndex)
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 20
            font.bold: true
        }
    }

    // Poi map
    Image{
        id: placeMap
        width: parent.width
        height:parent.height - refreshButton_placeMapView.height - backButton_placeMapView.height - infoText_placeMapView.height
        anchors.top: infoText_placeMapView.bottom
        cache: false
        source: "images/PoiMap.png"
    }

    // Zoom in button
    ImageButton{
        id: zoomInButton
        normalImage: "images/zoomin.png"
        pressedImage: normalImage
        width: parent.width/3
        height: 60
        anchors.top:placeMap.bottom
        anchors.left: parent.left
        MouseArea{
            anchors.fill: parent
            // Accessing zoomIn() from MyMapRequestor.cpp
            onClicked:MapPlacesRequestor.zoomIn();
        }
    }

    // Zoom out button
    ImageButton{
        id: zoomOutButton
        normalImage: "images/zoomout.png"
        pressedImage: normalImage
        width: parent.width/3
        height: 60
        anchors.top:  placeMap.bottom
        anchors.left: zoomInButton.right

        MouseArea{
            anchors.fill: parent
            // Accessing zoomOut() from MyMapRequestor.cpp
            onClicked:MapPlacesRequestor.zoomOut();
        }
    }

    // Refresh button
    ImageButton{
        id: refreshButton_placeMapView
        normalImage: "images/refresh120.png"
        pressedImage: normalImage
        width: parent.width/3
        height: 60
        anchors.top:  placeMap.bottom
        anchors.left: zoomOutButton.right

        MouseArea{
            anchors.fill: parent
            // Requesting map
            onClicked:MapPlacesRequestor.MapRequest();
        }
    }

    // Back button
    ImageButton
    {
        id: backButton_placeMapView
        width: parent.width
        height: 60
        normalImage: "images/back.png"
        pressedImage: normalImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        MouseArea{
            anchors.fill: parent
            onClicked: detailView.visible = "true"}
    }
}
