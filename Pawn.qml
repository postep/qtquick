import QtQuick 2.0

Item {
    property color color: pawn.color
    Rectangle{
        id: pawn
        anchors.fill: parent
        anchors.margins: parent.width/4
        color: "black"
        radius: parent.width/2
        visible: true
    }
}
