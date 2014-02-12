import QtQuick 1.1

Rectangle{
    width: parent.width
    height: parent.height
    color: "transparent"
    anchors.top: parent.top

    // Around me button
    ImageButton{
        id: aroundMeButton
        width: 250
        height: 60
        normalImage: "images/AroundMeButton.png"
        pressedImage: normalImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 120
        MouseArea {
            anchors.fill: parent
            onClicked: {
                aroundMeMapView.visible = true
                // Requesting map
                MapPlacesRequestor.PlacesRequest();
            }
        }
    }

    // About button
    ImageButton{
        id: aboutButton
        width: 250
        height: 60
        normalImage: "images/about.png"
        pressedImage: normalImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: aroundMeButton.bottom
        anchors.topMargin: 30
        MouseArea{
            anchors.fill: parent
            onClicked: aboutView.visible = true
        }
    }

    // Exit button
    ImageButton{
        id: exitButton
        width: 250
        height: 60
        normalImage: "images/exit.png"
        pressedImage: normalImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: aboutButton.bottom
        anchors.topMargin: 30
        MouseArea{
            anchors.fill:parent
            onClicked: Qt.quit();
        }
    }
}
