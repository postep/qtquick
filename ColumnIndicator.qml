import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true

    property alias indicatorText: t.text
    Rectangle {
        id: rectangle
        color: "#675a97"
        anchors.fill: parent
        anchors.leftMargin: parent.width/6
        anchors.rightMargin: parent.width/6
        anchors.topMargin: parent.height/3
        anchors.bottomMargin: parent.height/3
    }

    Text{
        id: t
        text: "C"
        anchors.centerIn: parent
    }
}
