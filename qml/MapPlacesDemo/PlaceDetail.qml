import QtQuick 1.1

Rectangle{
    width: parent.width
    height: parent.height
    color: "transparent"

    Rectangle{
        id: selectedPlaceRect
        anchors.top: parent.top
        width: parent.width
        height: parent.height  - backButton_detailView.height
        color: "lightsteelblue"

        // Place icon
        Image{
            id: icon_detailView
            source: MapPlacesRequestor.getIcon(selectedIndex);
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            width: 70
            height: 70
        }
        // Place title
        Text {
            id: detailText1
            text: MapPlacesRequestor.getPlacesTitle(selectedIndex);
            font.bold: true
            font.pixelSize: 25
            anchors.top: icon_detailView.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }
        // Place vicinity
        Text {
            id: detailText2
            text: MapPlacesRequestor.getPlacesVicinity(selectedIndex);
            font.bold: true
            font.pixelSize: 20
            anchors.top: detailText1.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }
        // View on map button
        ImageButton
        {
            id: viewOnMapButton
            width: 200
            height: 150
            normalImage: "images/ViewOnMap.png"
            pressedImage: normalImage
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: detailText2.bottom
            anchors.topMargin: 30
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    placeMapView.visible = true
                }
            }
        }

    }

    // Back button
    ImageButton{
        id: backButton_detailView
        width: parent.width
        height: 60
        normalImage: "images/back.png"
        pressedImage: normalImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        MouseArea{
            anchors.fill: parent
            onClicked: aroundMeListView.visible = "true"}
    }

}
