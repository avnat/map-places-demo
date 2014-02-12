import QtQuick 1.1


Image{
    id: container

    property variant text
    property variant normalImage
    property variant pressedImage
    signal clicked

    height: text.height + 10; width: text.width + 20
    smooth: true

    source: !mouseArea.pressed ? normalImage : pressedImage

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: container.clicked()
    }

    Text {
        id: text
        anchors.centerIn:parent
        font.pointSize: 14
        text: parent.text
        color: "white"
    }
}
