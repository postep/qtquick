import QtQuick 2.0

Rectangle {
    property color pieceColor: "red"
    property string team;

    id : piece
    width: 80
    height: width
    radius: width/2
    color: "black"
    Rectangle{
        id : innerCircle
        width: 74
        height: width
        radius: width/2
        color: parent.pieceColor
        anchors.centerIn: parent
    }


    function setTeam(t){
        piece.team = t
        if(t == "none"){
            visible = false
            pieceColor = "white"
        }
        if(t == "red"){
            visible = true
            pieceColor = "red"
        }
        if(t == "black"){
            visible = true
            pieceColor = "darkgray"
        }
    }
}
