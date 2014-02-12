import QtQuick 1.1

Rectangle{
    width: parent.width
    height: parent.height
    color: "transparent"

    Rectangle{
        width: parent.width-25
        height: parent.height/3
        radius: 5
        color: "white"
        anchors.centerIn: parent

        Text{
            id: app_name
            text: "MapPlacesDemo v1.0.0"
            font.pixelSize: 30
            font.bold: true
            color: "black"
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text{
            id: developer_info
            text: "Developed by Avnee Nathani \navnee.nathani@gmail.com"
            font.pixelSize: 20
            font.bold: true
            color: "black"
            anchors.top: app_name.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text{
            id: project_info
            text: "MapPlacesDemo is open source at\nprojects.developer.nokia.com/locationdemos"
            font.pixelSize: 15
            font.wordSpacing: Text.AlignHCenter
            color: "black"
            anchors.top: developer_info.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    MouseArea{
        anchors.fill: parent
        onClicked: homescreen.visible = "true"
    }
}
