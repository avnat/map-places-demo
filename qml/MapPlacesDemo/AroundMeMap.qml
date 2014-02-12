import QtQuick 1.1

Rectangle{
    width: parent.width
    height: parent.height
    color: "transparent"

    property alias aroundMeMapImage:aroundMeMap

    Rectangle{
        id: infoText
        width: parent.width
        height: 30
        anchors.top: parent.top
        color: "lightblue"
        Text {
            text: "Places around you!"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 20
            font.bold: true
        }
    }

    // Around me map
    Image{
        id: aroundMeMap
        width: parent.width
        height: parent.height - refreshButton.height - backButton_aroundMeMapView.height - infoText.height
        anchors.top: infoText.bottom
        source: "images/AroundMe.png"
        cache: false
        MouseArea{
            anchors.fill: parent
            onClicked: {
                aroundMeListView.visible = true
            }
        }
    }

    // Refresh button
    ImageButton{
        id: refreshButton
        width: parent.width
        height: 60
        normalImage: "images/refresh.png"
        pressedImage: normalImage
        anchors.top:  aroundMeMap.bottom
        MouseArea{
            anchors.fill: parent
            // Requesting map
            onClicked:MapPlacesRequestor.MapRequest();
        }
    }

    // Back button
    ImageButton{
        id: backButton_aroundMeMapView
        width: parent.width
        height: 60
        normalImage: "images/back.png"
        pressedImage: normalImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        MouseArea{
            anchors.fill: parent
            onClicked: homescreen.visible = "true"}
    }

}
