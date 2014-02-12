import QtQuick 1.1

Rectangle{
    width: parent.width
    height: parent.height
    color: "transparent"

    Rectangle{
        id: infoText_AroundMe
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

    // List of places around
    ListView{
        id: listview
        width: parent.width
        height: parent.height - backButton_aroundMeListView.height - infoText_AroundMe.height
        clip: true
        anchors.top: infoText_AroundMe.bottom
        model: listmodel
        delegate: Rectangle {
            width: parent.width
            height: 50
            color: "lightsteelblue"
            Image{
                id: icon
                width: 40
                height: 40
                source: MapPlacesRequestor.getIcon(index);
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
            Text {
                id: listItemtext
                text: modelData
                anchors.left: icon.right
                anchors.leftMargin: 10
                font.pixelSize: 20
                color: "darkblue"
            }
            Rectangle{
                width: parent.width
                height: 1
                color: "darkgreen"
                anchors.top: icon.bottom
                anchors.topMargin: 5
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    detailView.visible = true;
                    selectedIndex = index;
                    MapPlacesRequestor.getPoiMap(index);
                }
            }
        }
    }

    // Back button
    ImageButton{
        id: backButton_aroundMeListView
        width: parent.width
        height: 60
        normalImage: "images/back.png"
        pressedImage: normalImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        MouseArea{
            anchors.fill: parent
            onClicked: aroundMeMapView.visible = "true"
        }
    }
}
