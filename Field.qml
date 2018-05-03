import QtQuick 2.0
import QtQuick.Layouts 1.3

Item {
    property int _row: 1
    property int _col: 1
    property Pawn pawn
    property var _background: "#2d3d56"
    property var _background_unused: "#d7d3e5"

    Rectangle {
        id: rectangle
        anchors.fill: parent

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: onClick()
        }


        states: [

            State {
                name: "unused"
                when: (_row+_col)%2 == 1
                PropertyChanges { target:rectangle; color: _background_unused }
            },

            State {
                name: "used"
                when: (_row+_col)%2 == 0
                PropertyChanges { target:rectangle; color: _background;}
            }
        ]
    }



    Layout.fillWidth: true
    Layout.fillHeight: true


    function onClick(){
        console.log("test");
    }
}
