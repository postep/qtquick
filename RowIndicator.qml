import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    property alias indicatorText: t.text

    Rectangle {
        id: rectangle
        color: "#675a97"
        anchors.fill: parent
        anchors.leftMargin: parent.width/3
        anchors.rightMargin: parent.width/3
        anchors.topMargin: parent.height/6
        anchors.bottomMargin: parent.height/6
    }

    Layout.fillWidth: true
    Layout.fillHeight: true

    Text{
        id: t
        text: "R"
        anchors.centerIn: parent
    }
}
